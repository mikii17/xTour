/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { PostsService } from './posts.service';
import { PostsController } from './posts.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { postSchema } from './model/post.model';
import { MulterModule } from '@nestjs/platform-express';

@Module({
  imports: [MongooseModule.forFeature([{name: 'Post', schema: postSchema}]), MulterModule.register({dest:'./images'})],
  controllers: [PostsController],
  providers: [PostsService],
})
export class PostsModule {}
