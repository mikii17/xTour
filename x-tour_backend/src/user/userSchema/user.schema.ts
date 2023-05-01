import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Document } from 'mongoose';
import { Role } from "src/auth/enum/role.enum";

export type userDocument= User & Document;

@Schema()
export class User{
    @Prop({unique: true})
    username: string;

    @Prop()
    password: string;

    @Prop()
    follower: string[];

    @Prop()
    following: string[];

    @Prop()
    posts: string[];

    @Prop()
    bookmarkPosts: string[];

    @Prop()
    profilePicture: string;

    @Prop()
    refresh_token: string;

    @Prop()
    role: Role[];
}

export const userSchema=SchemaFactory.createForClass(User);