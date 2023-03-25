import {Prop, Schema, SchemaFactory} from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';
import * as mongoose from 'mongoose';

@Schema()
export class Comments{
    @Prop({required: true})
    _id: String;

    @Prop()
    message:String;

    @Prop({ref:"Users", type:[mongoose.Schema.Types.ObjectId]})
    replies:mongoose.Schema.Types.ObjectId[];
}