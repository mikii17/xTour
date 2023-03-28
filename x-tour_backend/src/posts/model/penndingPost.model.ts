/* eslint-disable prettier/prettier */
import * as mongoose from "mongoose";

export const penddingPostSchema = new mongoose.Schema({
    story: { type:  String},
    description: { type: String},
    comments: { type: Array<string>, required: true},
    likes: { type: Array<string>, required: true},
    creatorId: { type: String},
    images: { type: Array<Express.Multer.File>},
});

export class penddingPost {
    constructor(
        public id: string,
        public story: string,
        public description: string,
        public comments: Array<string>,
        public likes: Array<string>,
        public creatorId: string,
        public images: Array<Express.Multer.File>,
    ){}
}