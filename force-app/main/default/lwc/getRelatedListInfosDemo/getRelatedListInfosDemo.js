import { LightningElement, wire } from 'lwc';
import {getRelatedListInfo} from 'lightning/uiRelatedListApi';
export default class GetRelatedListInfosDemo extends LightningElement {
    relatedListData
    @wire(getRelatedListInfo, {
        parentObjectApiName:'Account',//This is an Api name of parent object that you want to get related list for
        relatedListId:'Contacts',//Api name of related list oblect
        //recordTypeId:''//optional
    })listInfoHandler({data, error}){
        if(data){
            console.log('listInfo:',JSON.stringify(data));
            this.relatedListData = data;
        }
        if(error){
            console.error(error);
        }
    }
}