import { IsNotEmpty } from "class-validator";

export class CreateJournalDto {
  @IsNotEmpty()
  creator_id: string;

  @IsNotEmpty()
  link: string;

  @IsNotEmpty()
  title: string;

  image: string;
  
  @IsNotEmpty()
  description: string;
}
