import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { CommentsModule } from './comments/comments.module';
import {MongooseModule} from '@nestjs/mongoose';
import { Mongoose } from 'mongoose';

@Module({
  imports: [
    CommentsModule,
    MongooseModule.forRoot('mongodb://127.0.0.1:27017/xTour')
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
