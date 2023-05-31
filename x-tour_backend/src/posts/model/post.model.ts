/* eslint-disable prettier/prettier */
import * as mongoose from "mongoose";

export const postSchema = new mongoose.Schema({
    story: { type:  String},
    description: { type: String},
    comments: { type: [{type: mongoose.Schema.Types.ObjectId, ref:"Comments"}], required: true},
    likes: { type: [{type: mongoose.Schema.Types.ObjectId, ref:'User'}], required: true},
    creatorId: { type: mongoose.Schema.Types.ObjectId, ref: "User"},
    images: { type: Array<String>},
});

export class Post {
    constructor(
        public story: string,
        public description: string,
        public comments: Array<string>,
        public likes: Array<string>,
        public creatorId: string,
        public images: Array<any>,
    ){}
}