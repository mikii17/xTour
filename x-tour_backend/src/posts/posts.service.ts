import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreatePostDto } from './dto/create-post.dto';
import { Post } from './model/post.model';
import { penddingPost } from './model/penndingPost.model';
import { UserService } from 'src/user/user.service';
import { QueryPostDto } from './dto/query.dto';
import { PassportModule } from '@nestjs/passport';

@Injectable()
export class PostsService {
  constructor(
    @InjectModel('Post') private readonly postModel: Model<Post>,
    @InjectModel('pending')
    private readonly PendingpostModel: Model<penddingPost>,
    private readonly userService: UserService,
  ) {}

  // async create(
  //   Model: any,
  //   createPostDto: CreatePostDto,
  //   id = null,
  // ): Promise<Post> {
  //   var newPost;
  //   console.log(id)
  //   if (id !== null) {
  //      newPost = await Model.create({ ...createPostDto, creatorId: id });
  //      await this.userService.penddingposts(id, newPost.id)
  //   } else {
  //     // TODO:
  //     // TODO:
  //     // await this.removePending(createPostDto, createPostDto.creatorId)
  //      newPost = await Model.create(createPostDto);
  //      await this.userService.posts(createPostDto.creatorId, newPost.id)
  //   }
  //   return newPost;
  // }
  async insertImages(Model: any, images: Array<any>, id: string) {
    const createdPost = await Model.findById({ _id: id });
    createdPost.images = images;
    return await createdPost.save().populate([{path: "comment", perDocumentLimit: 3}, "creatorId"]);
  }

  async findAll(Model: any) {
    const posts = await Model.find().populate([{path: "comment", perDocumentLimit: 3}, "creatorId"]);
    return posts as Post[];
  }

  async searchPost(Model: any, searchParam: string) {
    const posts = await Model.find({ story: searchParam }).populate([{path: "comments", perDocumentLimit: 3}, "creatorId"]);
    return posts as Post[];
  }

  async findhomepagePost(query, id: string) {
    const { search = '', perPage = 20, page = 1 } = query;
    const skip = perPage * (page - 1);

    const followings = (await this.userService.getUser({ _id: id })).following;
    const posts = await this.postModel
      .find({
        creatorId: { $in: followings },
        story: { $regex: search, $options: 'i' },
      })
      .limit(perPage)
      .skip(skip)
      .populate([{path: "comments", perDocumentLimit: 3}, "creatorId"]);
      
    return posts;

  }

  async like(postId: string, userId: string) {
    return await this.postModel.findByIdAndUpdate(postId,{$addToSet: {likes: userId}},{returnOriginal: false}).populate([{path: "comment", perDocumentLimit: 3}, "creatorId"]);
  }

  async unlike(postId: string , userId: string){
    return await this.postModel.findByIdAndUpdate(postId,{$pull: {likes: userId}},{returnOriginal: false}).populate([{path: "comment", perDocumentLimit: 3}, "creatorId"]);
  }
  
  async update(Model: any, id: string, story: string, description: string) {
    const updatedproduct = await Model.findById(id);
    if (story) {
      updatedproduct.story = story;
    }
    if (description) {
      updatedproduct.description = description;
    }
    const result = await updatedproduct.save().populate([{path: "comment", perDocumentLimit: 3}, "creatorId"]);

    return result;
  }

  async remove(model: any, id: string, userid: string, pending = false) {
    if (pending) {
      await this.userService.removePenddingposts(userid, id);
    } else {
      await this.userService.removePosts(userid, id);
    }
    return await model.deleteOne({ _id: id }).exec();
  }

  //----------------------------------------------------------------
  /// operations for the Aproved Posts

  async createAproved(createPost, id: string): Promise<Post> {
    await this.PendingpostModel.findByIdAndDelete(id);
    await this.userService.removePenddingposts(createPost.creatorId, id);
    const newpost = await this.postModel.create(createPost);
    await this.userService.posts(createPost.creatorId, newpost.id);
    return newpost;
  }

  async comments(commenteId: string ,postId){
    await this.postModel.findByIdAndUpdate(postId,{$addToSet: {comments: commenteId}}).populate([{path: "comment", perDocumentLimit: 3}, "creatorId"]);
  }

  async InsertAprovedimages(images: Array<any>, id: string) {
    return await this.insertImages(this.postModel, images, id);
  }

  async findAllAproved(query: QueryPostDto) {
    const { search = '', perPage = 20, page = 1 } = query;
    const skip = perPage * (page - 1);
    const posts = await this.postModel
      .find({ title: { $regex: search, $options: 'i' } })
      .limit(perPage)
      .skip(skip)
      .populate([{path: "comments", perDocumentLimit: 3}, "creatorId"]);
    // const postsCount = await this.postModel.count({
    //   title: { $regex: search, $options: 'i' },
    // });
    return  posts;
  }
  async searchAprovedposts(searchTerm: string) {
    return await this.searchPost(this.postModel, searchTerm);
  }

  // async updateAproved(id: string, story: string, description: string) {
  //   return await this.update(this.postModel, id, story, description);
  // }

  async removeAproved(id: string, postId: string) {
    return await this.remove(this.postModel, id, postId);
  }

  //================================================
  // operations for the pennding collection

  async createPending(createPost: CreatePostDto, id: string): Promise<Post> {
    const newPost = await this.PendingpostModel.create({
      ...createPost,
      creatorId: id,
    });
    await this.userService.penddingposts(id, newPost.id);
    return newPost;
  }

  async findAllPendings(query: QueryPostDto) {
    const { search = '', perPage = 20, page = 1 } = query;
    const skip = perPage * (page - 1);
    const pendingPosts = await this.PendingpostModel.find({
      title: { $regex: search, $options: 'i' },
    })
      .limit(perPage)
      .skip(skip)
      .populate([{path: "comments", perDocumentLimit: 3}, "creatorId"]);
    // const pendingPostsCount = await this.PendingpostModel.count({
    //   title: { $regex: search, $options: 'i' },
    // });
    return pendingPosts;
  }

  async updatePending(id: string, story: string, description: string) {
    return await this.update(this.PendingpostModel, id, story, description);
  }

  async removePending(id: string, userid: string) {
    return await this.remove(this.PendingpostModel, id, userid, true);
  }

  async insertPendingImages(images: Array<any>, id) {
    return await this.insertImages(this.PendingpostModel, images, id);
  }
}
