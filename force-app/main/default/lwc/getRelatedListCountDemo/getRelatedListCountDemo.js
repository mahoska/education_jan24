import { LightningElement, wire } from 'lwc';
import {getRelatedListCount} from 'lightning/uiRelatedListApi';
export default class GetRelatedListCountDemo extends LightningElement {
    relatedData;
    @wire(getRelatedListCount, {
        parentRecordId:'001av000000LgM3AAK',//the Id of the parent record that you want to get related list for
        relatedListId:'Contacts' //The Api name of a related list object such as Contacts, Opportunity
    })listCountHandler({data, error}){
        if(data){
            console.log(JSON.stringify(data));
            this.relatedData = data;
        }
        if(error){
            console.error(error);
        }
    }

}