import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { UserModule } from './user/user.module';
import { AuthModule } from './auth/auth.module';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';


@Module({
  imports: [MongooseModule.forRoot('mongodb://127.0.0.1:27017/xTour',{
    useUnifiedTopology: true,
    useNewUrlParser: true,
  }), UserModule, AuthModule
  ,
  ServeStaticModule.forRoot({
    rootPath: join(__dirname, '..', 'images'),
  }),ServeStaticModule.forRoot({
    rootPath: join(__dirname, '..', 'images', "users"),
  }),ServeStaticModule.forRoot({
    rootPath: join(__dirname, '..', 'images', "segami"),
  })],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
