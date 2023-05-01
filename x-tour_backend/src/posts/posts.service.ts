/* eslint-disable prettier/prettier */
import { HttpException, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { CreatePostDto } from './dto/create-post.dto';
import { Post } from './model/post.model';
import { penddingPost  } from './model/penndingPost.model';

@Injectable()
export class PostsService {

  constructor(
    @InjectModel('Post') private readonly postModel: Model<Post>,
    @InjectModel('pending') private readonly PendingpostModel: Model<penddingPost >
  ){}

  async create(Model: any, createPostDto: CreatePostDto,): Promise<Post> {
    const newPost = new Model(createPostDto)
    return await newPost.save();
  }
  async insertImages(Model: any, images: Array<any>, id: string){
    const createdPost = await Model.findById({_id: id})
    createdPost.images = images
    return await createdPost.save()

  }
  async findAll(Model: any) {
    const posts = await Model.find();
    return posts as Post[];
  }

  async searchPost(Model: any, searchParam: string) {
    const posts = await Model.find({story: searchParam});
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
    if (posttobeLiked.likes.findIndex((Ids)=>{return userId === Ids}) === -1){
        posttobeLiked.likes.push(userId)
        return await posttobeLiked.save()
    }
    else{
      return HttpException.createBody("you have already liked this post", "404")
    }

  }
  async update(Model: any,
    id: string,
    story: string,
    description: string,
    ) {

      const updatedproduct = await Model.findById(id)
      if (story){
        updatedproduct.story = story
      }
      if (description){
        updatedproduct.description = description
      }
      const result = await updatedproduct.save()

    return result
  }

  async remove(Model: any, id: string) {
    return await this.postModel.deleteOne({_id: id}).exec()
  }


//----------------------------------------------------------------
/// operations for the Aproved Posts

async createAproved(createPost): Promise<Post>{
  return await this.create(this.postModel, createPost)
}

async InsertAprovedimages(images: Array<any>, id: string){
  return await this.insertImages(this.postModel, images, id)
}
async findAllAproved(){
  return await this.findAll(this.postModel)
}
async searchAprovedposts(searchTerm: string){
  return await this.searchPost(this.postModel, searchTerm)
}
async updateAproved(
  id: string,
  story: string,
  description: string,
  ){
    return await this.update(this.postModel,id,story,description)
  }
async removeAproved(id: string){
  return await this.remove(this.postModel,id)
}

//================================================
// operations for the pennding collection

async createPending(createPost): Promise<Post>{
  return await this.create(this.PendingpostModel, createPost)
}

async findAllPendings(){
  return await this.findAll(this.PendingpostModel)
}
async updatePending(
  id: string,
  story: string,
  description: string,
  ){
    return await this.update(this.PendingpostModel,id,story,description)
  }
async removePending(id: string){
  return await this.remove(this.PendingpostModel,id)
}
async insertPendingImages(images: Array<any>, id){
return await this.insertImages(this.PendingpostModel, images, id)
}

}
