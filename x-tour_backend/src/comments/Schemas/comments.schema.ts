import {Prop, Schema, SchemaFactory} from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import * as mongoose from 'mongoose';

@Schema()
export class Comments{
    @Prop({required: true,ref:"Users", type:[mongoose.Schema.Types.ObjectId]})
    commenter: mongoose.Schema.Types.ObjectId[];

    @Prop()
    message:String;

    @Prop()
    replies:String[];
}

export const CommentSchema = SchemaFactory.createForClass(Comments);