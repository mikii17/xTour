/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { MongooseModule} from '@nestjs/mongoose';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PostsModule } from './posts/posts.module';

@Module({
  imports: [PostsModule,
  MongooseModule.forRoot('mongodb://127.0.0.1:27017/')
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
