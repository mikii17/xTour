import {
  Body,
  Controller,
  Get,
  Post,
  Param,
  Query,
  Patch,
  Delete,
  UsePipes,
  UseInterceptors,
  UploadedFile,
  ValidationPipe,
  UseGuards,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express/multer';
import { diskStorage } from 'multer';
import * as path from 'path';
import { CreateJournalDto } from './Dtos/create_journal.dto';
import { QueryStringDto } from './Dtos/query.dto';
import { JournalService } from './journal.service';
import { Journal } from './Schemas/journal.schema';
import { Roles } from 'src/auth/Decorator/roles.decorator';
import { Role } from 'src/auth/enum/role.enum';
import { AuthGuard } from '@nestjs/passport';

@Controller('journals')
export class JournalController {
  constructor(private readonly journalService: JournalService) {}

  @Get()
  async getApprovedJournals(@Query() queryString: QueryStringDto) {
    return await this.journalService.getApprovedJournals(queryString);
  }
  
  @UseGuards(AuthGuard('jwt'))
  @Roles(Role.Journalist, Role.Admin)
  @Get('pending')
  async getPendingJournals(@Query() querystring: QueryStringDto) {
    return await this.journalService.getPendingJournals(querystring);
  }

  @UseGuards(AuthGuard('jwt'))
  @Roles(Role.Journalist, Role.Admin)
  @Get('pending/:id')
  async getPendingJournal(@Param('id') id: string) {
    return await this.journalService.getPendingJournal(id);
  }

  @Get('/:id')
  async getApprovedJournal(@Param('id') id: string) {
    return await this.journalService.getApprovedJournal(id);
  }
 
  @UseGuards(AuthGuard('jwt'))
  @Roles(Role.Admin)
  @Post()
  async approveJournal(@Body() body: { id: string; journal: Journal }) {
    return await this.journalService.approveJournal(body.id, body.journal);
  }

  @UseGuards(AuthGuard('jwt'))
  @Roles(Role.Journalist)
  @Post('Pending')
  @UsePipes(new ValidationPipe({ transform: true }))
  async createJournal(@Body() body: CreateJournalDto) {
    return await this.journalService.createJournal(body);
  }

  @UseGuards(AuthGuard('jwt'))
  @Roles(Role.Journalist)
  @Post('pending/image/:id')
  @UseInterceptors(
    FileInterceptor('image', {
      storage: diskStorage({
        destination: './Images/pending',
        filename(req, file, callback) {
          callback(
            null,
            Date.now() + path.extname(file.originalname),
          );
        },
      }),
    }),
  )
  async uploadPendingFile(
    @UploadedFile() file: Express.Multer.File,
    @Param('id') id: string,
  ) {
    await this.journalService.insertImageOnPending(id, `pending/${file.filename}`);
    const response = {
      originalname: file.originalname,
      filename: `pending/${file.filename}`,
    };
    return response;
  }

  @Post('image/:id')
  @UseInterceptors(
    FileInterceptor('image', {
      storage: diskStorage({
        destination: './Images/approved',
        filename(req, file, callback) {
          callback(
            null,
            `approved/${Date.now() + path.extname(file.originalname)}`,
          );
        },
      }),
    }),
  )
  async uploadApprovedFile(
    @UploadedFile() file: Express.Multer.File,
    @Param('id') id: string,
  ) {
    await this.journalService.insertImageOnApproved(id, file.filename);
    const response = {
      originalname: file.originalname,
      filename: file.filename,
    };
    return response;
  }

  @UseGuards(AuthGuard('jwt'))
  @Roles(Role.Journalist)
  @Patch('pending/:id')
  async updatePendingJournal(@Param('id') id: string, @Body() body) {
    return await this.journalService.updatePendingJournal(id, body);
  }

  @UseGuards(AuthGuard('jwt'))
  @Roles(Role.Journalist, Role.Admin)
  @Patch('/:id')
  async updateApprovedJournal(@Param('id') id: string, @Body() body) {
    return await this.journalService.updateApprovedJournal(id, body);
  }

  @UseGuards(AuthGuard('jwt'))
  @Roles(Role.Journalist, Role.Admin)
  @Delete('pending/:id')
  async deletePendingJournal(@Param('id') id: string) {
    return this.journalService.deletePendingJournal(id);
  }

  @UseGuards(AuthGuard('jwt'))
  @Roles(Role.Journalist, Role.Admin)
  @Delete('/:id')
  async deleteApprovedJournal(@Param('id') id: string) {
    return this.journalService.deleteApprovedJournal(id);
  }
}
