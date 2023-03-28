/* eslint-disable prettier/prettier */
import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreatePostDto } from './dto/create-post.dto';
import { Post } from './model/post.model';

@Injectable()
export class PostsService {

  constructor(
    @InjectModel('Post') private readonly postModel: Model<Post>
  ){}

  async create(createPostDto: CreatePostDto,): Promise<Post> {
    const newPost = new this.postModel(createPostDto)
    return await newPost.save();
  }
  async insertImages(images: Array<Express.Multer.File>, id: string){
    const createdPost = await this.postModel.findById({_id: id})
    createdPost.images = images
    return await createdPost.save()

  }
  async findAll() {
    const posts = await this.postModel.find();
    return posts as Post[];
  }

  async searchPost(searchParam: string) {
    const posts = await this.postModel.find({story: searchParam});
    return posts as Post[];
  }

  async findhomepagePost(friendsList: Array<{userId: string}>) {
    const posts = []
    friendsList.forEach( async (friend) => {
      posts.push(await this.postModel.find({creatorId: friend.userId}))
    })
    return posts as Post[];
  }

  async liker(postId: string, userId: string ){
    const posttobeLiked = await this.postModel.findById(postId)
    if (posttobeLiked.likes.findIndex((Ids)=>  {
      return userId === Ids}) === -1)
      {
        posttobeLiked.likes.push(userId)
        return await posttobeLiked.save()
    }
    else{
      return HttpException.createBody("you have already liked this post", "404")
    }

  }
  async update(
    id: string,
    story: string,
    description: string,
    like: string,
    comment: string,
    ) {

      const updatedproduct = await this.postModel.findById(id)
      if (story){
        updatedproduct.story = story
      }
      if (description){
        updatedproduct.description = description
      }
      if (like){
        updatedproduct.likes.push(like) 
      }
      if (comment){
        updatedproduct.comments.push(comment)
      }
      const result = await updatedproduct.save()

    return result
  }

  async remove(id: string) {
    return await this.postModel.deleteOne({_id: id}).exec()
  }
}
