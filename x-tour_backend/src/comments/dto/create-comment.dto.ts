import { IsNotEmpty, IsString } from "class-validator";
import mongoose from "mongoose";
export class CreateCommentDto {
    @IsNotEmpty()
    commenterId: String;

    replyId:String;

    postId: String;

    @IsNotEmpty()
    @IsString()
    message: String;

}
