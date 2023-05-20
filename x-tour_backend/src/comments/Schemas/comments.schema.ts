import {Prop, Schema, SchemaFactory} from '@nestjs/mongoose';
import mongoose from 'mongoose';
import { User } from './userSchema/user.schema';

@Schema({
    timestamps: true
})
export class Comments{
    @Prop({required: true, ref: "User", type: mongoose.Schema.Types.ObjectId})
    commenterId: User;
    
    @Prop({ref: 'Comments', type: mongoose.Schema.Types.ObjectId})
    replyId: Comments;

    @Prop({ref: 'Post', type: mongoose.Schema.Types.ObjectId})
    postId: Post ;

    @Prop()
    message:String;

}

export const CommentSchema = SchemaFactory.createForClass(Comments);
