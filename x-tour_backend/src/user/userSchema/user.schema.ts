import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from 'mongoose';
import { Role } from "src/auth/enum/role.enum";
import { Journal } from "src/journal/Schemas/journal.schema";
import { Post } from "src/posts/model/post.model";

export type userDocument= User & Document; 

@Schema()
export class User{
    @Prop()
    fullName: string

    @Prop({unique: true})
    username: string;

    @Prop()
    password: string;

    @Prop({type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User'}] })
    follower: User[];

    @Prop({type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User'}] })
    following: User[];

    @Prop({type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Post'}] })
    posts: Post[];

    @Prop({type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Post'}] })
    penddingPosts: Post[];

    @Prop({type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Journal'}] })
    journals: Journal[];

    @Prop({type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Journal'}] })
    pendingJournal: Journal[];

    @Prop({type: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Post'}] })
    bookmarkPosts: Post[];

    @Prop()
    profilePicture: string;

    @Prop()
    refresh_token: string;

    @Prop()
    role: Role[];
    
}

export const userSchema=SchemaFactory.createForClass(User);
