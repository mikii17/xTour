import { IsNotEmpty } from "class-validator";
import mongoose from "mongoose";
export class CreateCommentDto {

    commenter: mongoose.Schema.Types.ObjectId;

    @IsNotEmpty()
    message: String;

    replies: String[]
}
