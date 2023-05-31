import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PostsModule } from './posts/posts.module';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';
import { JournalModule } from './journal/journal.module';
import { CommentsModule } from './comments/comments.module';
import { APP_GUARD } from '@nestjs/core';
import { RolesGuard } from './auth/guard/roles.guard';
import { MongooseModule } from '@nestjs/mongoose';

@Module({
  imports: [
    MongooseModule.forRoot('mongodb://127.0.0.1:27017/xTour', {
      useUnifiedTopology: true,
      useNewUrlParser: true,
    }),
    PostsModule,
    CommentsModule,
    UserModule,
    AuthModule,
    JournalModule,
    // ServeStaticModule.forRoot({
    //   rootPath: join(__dirname, '..', 'images', 'pending'),
    // }),
    // ServeStaticModule.forRoot({
    //   rootPath: join(__dirname, '..', 'images', 'imagess'),
    // }),
    // ServeStaticModule.forRoot({
    //   rootPath: join(__dirname, '..', 'images'),
    // }),
  ],
  controllers: [AppController],
  providers: [AppService, 
  //   {
  //   provide: APP_GUARD,
  //   useClass: RolesGuard,
  // },
],
})
export class AppModule {}