import { PartialType } from '@nestjs/mapped-types';
import { CreateCommentDto } from './create-comment.dto';

export class UpdateCommentDto extends PartialType(CreateCommentDto) {
    
    commenterId: String;

    replyId:String;

    postId: String;

    message: String;
}
