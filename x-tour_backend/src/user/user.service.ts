import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { FilterQuery, Model } from 'mongoose';
import { User, userDocument } from './userSchema/user.schema';
import * as bcrypt from 'bcrypt';
import { Role } from "src/auth/enum/role.enum";

@Injectable()
export class UserService {
    userId: string;
    constructor(@InjectModel(User.name) private userModel: Model<userDocument>){}

    async getUser(filterQuery: FilterQuery<User>): Promise<User>{
        return await this.userModel.findOne(filterQuery);
    }

    async getUsers(): Promise<User[]>{
        return await this.userModel.find()
    }

    async createUser(user: User): Promise<User>{
        const salt = await bcrypt.genSalt();
        const hashPassword = await bcrypt.hash(user.password, salt);
        user.password=hashPassword

        const users= new this.userModel(user);
        return  await users.save()
    }

    async updateUser(filterQuery: FilterQuery<User>, user: Partial<User>): Promise<User>{
        return this.userModel.findByIdAndUpdate(filterQuery,user)
    }

    async followUser(userId: string, followedUserId: string) {
        await this.userModel.updateOne({ _id: userId }, {  $addToSet : { following: followedUserId } });
        await this.userModel.updateOne({ _id: followedUserId }, { $addToSet : { follower: userId } });
    }
    
    async unfollowUser(userId: string, unfollowedUserId: string) {
        await this.userModel.updateOne({ _id: userId }, { $pull: { following: unfollowedUserId } });
        await this.userModel.updateOne({ _id: unfollowedUserId }, { $pull: { follower: userId } });
    }

    async getUserFollowers(userId: string): Promise<User[]> {
        const user = await this.userModel.findOne({userId}).populate('follower').select('follower').exec();
        return user.follower;
    }

    async getUserFollowing(userId: string): Promise<User[]> {
        const user = await this.userModel.findOne({userId}).populate('following').select('following').exec();
        return user.following;
    }

    async posts(userId: string, postId: string){
        await this.userModel.updateOne({_id: userId},{ $addToSet : {posts: postId}});
    }

    async bookmarkPosts(userId: string, postId: string){
        await this.userModel.findByIdAndUpdate(userId, { $addToSet : {posts: postId}});
    }


    async updateRtHash(userId: string, rt: string): Promise<void> {
        const salt = await bcrypt.genSalt();
        const hashRt = await bcrypt.hash(rt, salt);
        await this.userModel.findByIdAndUpdate(userId,{refresh_token: hashRt});
    }

    async isJournal(userId: string): Promise<any>{
        await this.userModel.findByIdAndUpdate(userId, { $addToSet : {role: Role.Journalist}})
       
    }

    async isAdmin(userId: string): Promise<any>{
        await this.userModel.findByIdAndUpdate(userId, { $addToSet : {role: Role.Admin}})
       
    }
  
} 
