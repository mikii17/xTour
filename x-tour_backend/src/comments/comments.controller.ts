import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { CommentsService } from './comments.service';
import { CreateCommentDto } from './dto/create-comment.dto';
import { UpdateCommentDto } from './dto/update-comment.dto';
import { getReplyDto } from './dto/getReply.dto';
import { AuthGuard } from '@nestjs/passport';


@Controller('comments')
export class CommentsController {
  constructor(private readonly commentsService: CommentsService) {}

  @UseGuards(AuthGuard('jwt'))
  @Post()
  async create(@Body() createCommentDto: CreateCommentDto) {
    return await this.commentsService.createComment(createCommentDto);
  }


  @Get(':id')
  async findOne(@Param('id') id: string) {
    return await this.commentsService.findOne(id);
  }
  
  @Get('post/:postId')
  async getComments(@Param('postId') postId: String){
    return await this.commentsService.getComment(postId);
  }
  @Get('replies/:replyId')
  async getReply(@Param() params:getReplyDto){
    const {replyId, page} = params;
    return await this.commentsService.getReply(replyId,page);

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
