/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, UseInterceptors, UploadedFiles, Query, ValidationPipe, UsePipes } from '@nestjs/common';
import { PostsService } from './posts.service';
import { CreatePostDto } from './dto/create-post.dto';
import { FilesInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';


@Controller('posts')
export class PostsController {
  constructor(private readonly postsService: PostsService) {}

  @Post()
  create(
    @Body() createPostDto: CreatePostDto
  ){
    return this.postsService.createAproved(createPostDto);
  }
  @Post('images/:id')
  @UseInterceptors(FilesInterceptor('files', 3, {

    storage: diskStorage({
      destination: './images/Approved',
      filename(req, file, callback){
        callback(null, `${Date.now()}-${file.originalname}`)
      }
    })
  }))
  createImages(
    @Param('id') id: string,
    @UploadedFiles() files: Array<Express.Multer.File>
  ){
    const images = [];
    files.forEach((file) => {
      images.push({
        originalName: file.originalname,
        newName: file.filename,
      });
    });
    return this.postsService.InsertAprovedimages(images, id);
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

  @Delete(':id')
  async delete(@Param('id') id: string){
    console.log('delete')
    return await this.postsService.removeAproved(id);
  }

  // end points for the pending posts////////////////////////////////////////////////////////////////
  @Post('pending')
  @UsePipes(new ValidationPipe({ transform: true }))
  createPending(
    @Body() createPostDto: CreatePostDto
  ){
    console.log(createPostDto)
    return this.postsService.createPending(createPostDto);
  }
  
  @Post('pending/images/:id')
  @UseInterceptors(FilesInterceptor('files', 3, {

    storage: diskStorage({
      destination: './images/pending',
      filename(req, file, callback){
        callback(null, `${Date.now()}-${file.originalname}`)
      }
    })
  }))

  creatependingImages(
    @Param('id') id: string,
    @UploadedFiles() files: Array<Express.Multer.File>
  ){

    const images = [];
    files.forEach((file) => {
      images.push({
        originalName: file.originalname,
        newName: file.filename,
      });
    });
    return this.postsService.insertPendingImages(images, id);
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

  @Delete('pending:id')
  async deletePending(@Param('id') id: string){
    console.log('delete')
    return await this.postsService.removePending(id);
  }
}
