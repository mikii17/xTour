/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFiles, Query } from '@nestjs/common';
import { PostsService } from './posts.service';
import { CreatePostDto } from './dto/create-post.dto';
import { FilesInterceptor } from '@nestjs/platform-express';

@Controller('posts')
export class PostsController {
  constructor(private readonly postsService: PostsService) {}

  @Post()
  create(
    @Body() createPostDto: CreatePostDto
  ){
    console.log(createPostDto)
    return this.postsService.create(createPostDto);
  }

  @Post('images/:id')
  @UseInterceptors(FilesInterceptor('files', 3))
  createImages(
    @Param('id') id: string,
    @UploadedFiles() files: Array<Express.Multer.File>
  ){
    return this.postsService.insertImages(files, id);
  }
  
  @Post('like')
  liked(
    @Body('postId') postId: string,
    @Body('userId') userId: string
  ){
    return this.postsService.liker(postId, userId)
  }

  @Get()
  async findAll() {
    const posts = await this.postsService.findAll();
    return posts
  }

  @Get('homepage')
  HomePagePost(@Query() friendsList: Array<{userId: string}>){
    return this.postsService.findhomepagePost(friendsList);
  }

  @Get('search')
  searchPost(@Query() serachQuery: string){
    return this.postsService.searchPost(serachQuery);
  }

  @Patch(':id')
  async update(
    @Param('id') postId: string, 
    @Body('story') story: string,
    @Body('discription') disc: string,
    @Body('like') like: string,
    @Body('comment') comment: string,
    ) {

    const result = await this.postsService.update(postId, story, disc, like, comment);
    return result
  }

  @Delete(':id')
  async delete(@Param('id') id: string){
    console.log('delete')
    return await this.postsService.remove(id);
  }
}
