import { Module } from '@nestjs/common';
import { JournalService } from './journal.service';
import { JournalController } from './journal.controller';
import { MongooseModule } from '@nestjs/mongoose/dist';
import { Journal, JournalSchema } from './Schemas/journal.schema';
import { JournalPending, JournalPendingSchema } from './Schemas/journal_pending.schema';

@Module({
  imports:[MongooseModule.forFeature(
    [{name: Journal.name, schema: JournalSchema},{name: JournalPending.name, schema: JournalPendingSchema}]
  )],
  providers: [JournalService],
  controllers: [JournalController]
})
export class JournalModule {}
