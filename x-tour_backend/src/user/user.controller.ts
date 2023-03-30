import { BadRequestException, Body, Controller, Delete, Get, Param, Patch, Post, Req, UploadedFile, UseGuards, UseInterceptors, UsePipes, ValidationPipe } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express/multer';
import { diskStorage } from 'multer';
import { UserService } from './user.service';
import { Users } from './userDto/update.dto';
import { users } from './userDto/user.dto';
import { User } from './userSchema/user.schema';
import { Request } from 'express';

@Controller('user')
export class UserController {
    constructor(private userService: UserService){

    }

    @UseGuards(AuthGuard('jwt'))
    @Get()
    async getUser(@Req() req: Request): Promise<User>{
        const user=req.user;
        return await  this.userService.getUser(user['id'])
    }

    @Get()
    async getUsers(): Promise<User[]>{
        return await this.userService.getUsers()
    }
    
    @UseGuards(AuthGuard('jwt'))
    @Patch()
    async update(@Req() req: Request, @Body() userDto: Users): Promise<User>{
        const user=req.user;
        return await this.userService.updateUser(user['id'], userDto)
    }

    @UseGuards(AuthGuard('jwt'))
    @Patch('follow/:followedUserId')
    async followUser(@Req() req: Request, @Param('followedUserId') followedUserId: string) {
        const user=req.user;
        await this.userService.followUser(user['id'], followedUserId);
    }
  
    @UseGuards(AuthGuard('jwt'))
    @Delete('unfollow/:unfollowedUserId')
    async unfollowUser(@Req() req: Request, @Param('unfollowedUserId') unfollowedUserId: string) {
        const user=req.user;
      await this.userService.unfollowUser(user['id'], unfollowedUserId);
    }
  
    @UseGuards(AuthGuard('jwt'))
    @Get('followers')
    async getUserFollowers(@Req() req: Request): Promise<string[]> {
        const user=req.user;
      return this.userService.getUserFollowers(user['id']);
    }
  
    @UseGuards(AuthGuard('jwt'))
    @Get(':id/following')
    async getUserFollowing(@Req() req: Request): Promise<string[]> {
        const user=req.user;
      return this.userService.getUserFollowing(user['id']);
    }

    @UseGuards(AuthGuard('jwt'))
    @Patch('posts/:postId')
    async storePosts(@Req() req: Request, @Param('postId') postId: string){
        const user=req.user;
        await this.userService.posts(user['id'], postId);
    }
    
    @UseGuards(AuthGuard('jwt'))
    @Patch(':id/posts/:postId')
    async bookmarkPosts(@Req() req: Request, @Param('postId') postId: string){
        const user=req.user;
        await this.userService.bookmarkPosts(user['id'], postId);
    }

  
    @UseGuards(AuthGuard('jwt'))
    @Post('upload')
    @UseInterceptors(FileInterceptor('image', {
        storage: diskStorage({
            destination: './images/segami',
            filename: (req,file,cb)=> {
                const name= file.originalname.split('.')[0];
                const fileExtention= file.originalname.split('.')[1];
                const newFilename= name+'_'+Date.now()+'.'+fileExtention;

                cb(null,newFilename);
            }
        }),
        fileFilter: (req,file,cb) => {
            if(!file.originalname.match(/\.(jpg|jpeg|png|gif)$/)){
                return cb(null,false);
            }
            return cb(null,true);
        }


    }))
    async uploadFile(@UploadedFile() file: Express.Multer.File, @Req() req: Request): Promise<User> {
        if(!file){
            throw new BadRequestException('File is not an image')
        }
        else{
            const response={profilePicture: `segami/${file.filename}`}
            const user = req.user;
           
    
            // TODO: ADD to user data in the database 
            return await this.userService.updateUser(user["id"], {profilePicture: response.profilePicture})
        }


    }
    
    @UseGuards(AuthGuard('jwt'))
    @Patch('isJournal')
    async journal(@Req() req: Request): Promise<any>{
        const user = req.user;
        return await this.userService.isJournal(user["id"])
    }

    @UseGuards(AuthGuard('jwt'))
    @Patch('isAdmin')
    async admin(@Req() req: Request): Promise<any>{
        const user = req.user;
        return await this.userService.isJournal(user["id"])
    }
}
    
