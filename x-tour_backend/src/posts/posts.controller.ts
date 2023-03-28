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
    return this.postsService.createAproved(createPostDto);
  }

  @Post('images/:id')
  @UseInterceptors(FilesInterceptor('files', 3))
  createImages(
    @Param('id') id: string,
    @UploadedFiles() files: Array<Express.Multer.File>
  ){
    return this.postsService.InsertAprovedimages(files, id);
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
    const posts = await this.postsService.findAllAproved();
    return posts
  }

  @Get('homepage')
  HomePagePost(@Query() friendsList: Array<{userId: string}>){
    return this.postsService.findhomepagePost(friendsList);
  }

  @Get('search')
  searchPost(@Query() serachQuery: string){
    return this.postsService.searchAprovedposts(serachQuery);
  }

  @Patch(':id')
  async update(
    @Param('id') postId: string, 
    @Body('story') story: string,
    @Body('discription') disc: string,
    ) {

    const result = await this.postsService.updateAproved(postId, story, disc);
    return result
  }

  @Patch('images/:id')
  @UseInterceptors(FilesInterceptor('files', 3))
  updateImages(
    @Param('id') id: string,
    @UploadedFiles() files: Array<Express.Multer.File>
  ){
    return this.postsService.updateImages(files, id);
  }

  @Delete(':id')
  async delete(@Param('id') id: string){
    console.log('delete')
    return await this.postsService.removeAproved(id);
  }


  // end points for the pending posts////////////////////////////////////////////////////////////////
  @Post('pending')
  createPending(
    @Body() createPostDto: CreatePostDto
  ){
    console.log(createPostDto)
    return this.postsService.createPending(createPostDto);
  }
  
  @Post('pending/images/:id')
  @UseInterceptors(FilesInterceptor('files', 3))
  creatependingImages(
    @Param('id') id: string,
    @UploadedFiles() files: Array<Express.Multer.File>
  ){
    return this.postsService.insertpendingImages(files, id);
  }
  
  @Get('pending')
  async findAllpending() {
    const posts = await this.postsService.findAllPendings();
    return posts
  }

  @Patch('pending/:id')
  async updatePending(
    @Param('id') postId: string, 
    @Body('story') story: string,
    @Body('discription') disc: string,
    ) {
    const result = await this.postsService.updatePending(postId, story, disc);
    return result
  }

  @Patch('pending/images/:id')
  @UseInterceptors(FilesInterceptor('files', 3))
  updatePendingImages(
    @Param('id') id: string,
    @UploadedFiles() files: Array<Express.Multer.File>
  ){
    return this.postsService.insertPendingImages(files, id);
  }

  @Delete('pending:id')
  async deletePending(@Param('id') id: string){
    console.log('delete')
    return await this.postsService.removePending(id);
  }
}
