import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateCommentDto } from './dto/create-comment.dto';
import { UpdateCommentDto } from './dto/update-comment.dto';
import {InjectModel} from '@nestjs/mongoose';
import { CommentSchema, Comments } from './Schemas/comments.schema';
import {Model} from 'mongoose';


@Injectable()
export class CommentsService {
  constructor(
    @InjectModel("Comments") private readonly commentsModel: Model<Comments>
  ){}
  async createComment(createCommentDto: CreateCommentDto) {
   const {commenterId,replyId, postId, message} = createCommentDto;
   const comment = await this.commentsModel.create({commenterId,replyId, postId, message});

  return comment;
  }



  
  async getReply(replyId:String,page:number){

    const pages:number = parseInt(page as any) || 1;
    const limit = 5;
    const replies = await this.commentsModel.find({replyId:replyId}).skip((pages -1)*limit).limit(limit).exec();
    if(!replies) throw new NotFoundException("replies not found");
   
    return replies;
  }

  async getComment(postId:String){
    const comments = await this.commentsModel.find({postId: postId});
    if(!comments) throw new NotFoundException("comments not found");
    return comments;
  }



  async findOne(id: String) {
    
    const comment = (await this.commentsModel.findById(id));
    
    if(!comment) throw new NotFoundException('Course Not Found');
    return comment.message;
  }

  async update(id:String, updateComment: UpdateCommentDto) {
    
    return await this.commentsModel.findByIdAndUpdate(id, updateComment);
  }

  async remove(id: String) {
    const comment = await this.commentsModel.findById(id);
    
    if(!comment){
      throw new NotFoundException('Comment not found');
    }

    await this.commentsModel.findByIdAndDelete(id);

    await this.commentsModel.deleteMany({replyId: id});
  }
}
