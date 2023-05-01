import {Prop, Schema, SchemaFactory} from '@nestjs/mongoose';
import mongoose from 'mongoose';

@Schema({
    timestamps: true
})
export class Comments{
    @Prop({required: true, ref: "Users", type: mongoose.Types.ObjectId})
    commenterId: mongoose.Types.ObjectId;
    
    @Prop({ref: 'Comments', type: mongoose.Types.ObjectId})
    replyId: mongoose.Types.ObjectId;

    @Prop()
    postId: String;

    @Prop()
    message:String;

}

export const CommentSchema = SchemaFactory.createForClass(Comments);