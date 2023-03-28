/* eslint-disable prettier/prettier */
export interface CreatePostDto {
    story: string;
    description: string,
    comments: Array<string>,
    likes: Array<string>,
    images: Array<Express.Multer.File>,
    creatorId: string
}
