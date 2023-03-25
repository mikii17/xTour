import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { CommentsService } from './comments.service';
import { CreateCommentDto } from './dto/create-comment.dto';
import { UpdateCommentDto } from './dto/update-comment.dto';


@Controller('comments')
export class CommentsController {
  constructor(private readonly commentsService: CommentsService) {}

  @Post()
  async create(@Body() createCommentDto: CreateCommentDto) {
    return await this.commentsService.createComment(createCommentDto);
  }


  // @Get()
  // findAll() {
  //   return this.commentsService.findAll();
  // }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    return await this.commentsService.findOne(id);
  }
  @Get(':postId')
  async getComments(@Param('postId') postId: String){
    return await this.commentsService.getComment(postId);
  }
  @Get('replies/:replyId')
  async getReply(@Param('replyId') replyId: String){
    return await this.commentsService.getReply(replyId);

  }

  @Patch('/:id')
  update(@Param('id') id: string, @Body() updateCommentDto: UpdateCommentDto) {
    return this.commentsService.update(id, updateCommentDto);
  }

  @Delete('/:id')
  remove(@Param('id') id: string) {
    return this.commentsService.remove(id);
  }
}
