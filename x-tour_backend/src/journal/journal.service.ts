import { DynamicModule, Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose/dist';
import { Model } from 'mongoose';
import { CreateJournalDto } from './Dtos/create_journal.dto';
import { Journal } from './Schemas/journal.schema';
import { JournalPending } from './Schemas/journal_pending.schema';

@Injectable()
export class JournalService {
    constructor(
        @InjectModel(Journal.name) private readonly journalModel: Model<Journal>,
        @InjectModel(JournalPending.name) private readonly journalPendingModel: Model<JournalPending>
    ){}

    async insertImage(model: any, id: string, image_url: string){
        return await model.findByIdAndUpdate(id, {image: image_url}, {returnOriginal: false});
    }

    async getJournal(model: any, id: string){
        return await model.findById(id);
    }

    async getJournals(model: any, search = "" ,perPage = 20, page = 1){
        const skip = perPage * (page - 1);
        const journals = await model.find({ titile: { $regex: search, $options: "i" }}).limit(perPage).skip(skip);
        const journalsCount = await model.count({ titile: { $regex: search, $options: "i" }});

        return {journals, count: journalsCount};
    }

    async updateJournal(model: any, id: string, journal) {
        return await model.findByIdAndUpdate(id, journal, {returnOriginal: false});    
   }

   async deleteJournal(model, id: string){
       return await model.findByIdAndDelete(id);
   }
        
    // Operations on Pending Journals

    async createJournal(journal: CreateJournalDto){
        return await this.journalPendingModel.create({...journal, image: ''});
    }
    async insertImageOnPending(id: string, image_url: string){
        return await this.insertImage(this.journalPendingModel, id, image_url);
    }
    async getPendingJournal(id: string){
        return await this.getJournal(this.journalPendingModel, id);
    }

    async getPendingJournals(search = "" ,perPage = 20, page = 1){
        return await this.getJournals(this.journalPendingModel, search, perPage, page);
    }
    async updatePendingJournal(id: string, journal) {
        return await this.updateJournal(this.journalPendingModel,id, journal);    
   }

   async deletePendingJournal(id: string){
       return await this.deleteJournal(this.journalPendingModel, id);
   }

    // Operations on Approved Journals

    async approveJournal(id:string, journal: Journal){
        await this.journalPendingModel.findByIdAndDelete(id);
        return await this.journalModel.create(journal);
    }

    async getApprovedJournal(id: string){
        return await this.getJournal(this.journalModel, id);
    }

    async getApprovedJournals(search = "" ,perPage = 20, page = 1){
        return await this.getJournals(this.journalModel, search, perPage, page);
    }
 
    async insertImageOnApproved(id: string, image_url: string){
        return await this.insertImage(this.journalModel, id, image_url);
    }

    async updateApprovedJournal(id: string, journal) {
         return await this.updateJournal(this.journalModel,id, journal);    
    }

    async deleteApprovedJournal(id: string){
        return await this.deleteJournal(this.journalModel, id);
    }
}
