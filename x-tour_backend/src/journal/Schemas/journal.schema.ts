import { Schema, Prop, SchemaFactory } from "@nestjs/mongoose";
import mongoose from "mongoose";

@Schema()
export class Journal{
    @Prop({ type: mongoose.Schema.Types.ObjectId, ref: 'Journal'})
    creator_id: mongoose.Schema.Types.ObjectId;

    @Prop()
    titile: string;

    @Prop()
    link: string;

    @Prop()
    image: string;

    @Prop()
    description: string;
}

export const  JournalSchema = SchemaFactory.createForClass(Journal);