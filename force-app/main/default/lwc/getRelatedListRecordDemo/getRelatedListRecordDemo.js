import { LightningElement, wire } from 'lwc';
import {getRelatedListRecords} from 'lightning/uiRelatedListApi';
export default class GetRelatedListRecordDemo extends LightningElement {
    recordsList;
    @wire(getRelatedListRecords, {
        parentRecordId:'001QI00000BczHDYAZ',
        relatedListId:'Contacts',
        fields:['Contact.Name', 'Contact.Id'] //optional fields
    })listRecordsHandler({data, error}){
        if(data){
            this.recordsList = data;
            console.log('relatedRecords:',JSON.stringify(data));
        }
        if(error){
            console.error(error);
        }
    }
}