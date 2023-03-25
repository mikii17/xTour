import {Prop, Schema, SchemaFactory} from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import * as mongoose from 'mongoose';
import { type } from 'os';

@Schema({
    timestamps: true
})
export class Comments{
    @Prop({required: true})
    commenterId: String;
    
    @Prop()
    replyId: String;

    @Prop()
    postId: String;


    @Prop()
    message:String;


}

export const CommentSchema = SchemaFactory.createForClass(Comments);