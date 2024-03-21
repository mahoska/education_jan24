import { LightningElement, wire } from 'lwc';

//Car__c Schema
import NAME_FIELD from '@salesforce/schema/Car__c.Name';
import PICTURE_URL_FIELD from '@salesforce/schema/Car__c.Picture_URL__c';
import CATEGORE_FIELD from '@salesforce/schema/Car__c.Category__c';
import MAKE_FIELD from '@salesforce/schema/Car__c.Make__c';
import MSRP_FIELD from '@salesforce/schema/Car__c.MSRP__c';
import FUEL_FIELD from '@salesforce/schema/Car__c.Fuel_Type__c';
import SEATS_FIELD from '@salesforce/schema/Car__c.Number_of_Seats__c';
import CONTROL_FIELD from '@salesforce/schema/Car__c.Control__c';

//this function is used to extract fields values
import {getFieldValue} from 'lightning/uiRecordApi';


//Lightning Message Service and a message channel
import {subscribe, MessageContext, unsubscribe} from 'lightning/messageService';
import CAR_SELECTED_MESSAGE from '@salesforce/messageChannel/CarSelected__c';

//navigation
import {NavigationMixin} from 'lightning/navigation';
import CAR_OBJECT from '@salesforce/schema/Car__c';

export default class CarCard extends NavigationMixin(LightningElement) {
    //exposing fields to make them available in the template
    categoryField = CATEGORE_FIELD;
    makeField = MAKE_FIELD;
    msrpField = MSRP_FIELD;
    fuelField = FUEL_FIELD;
    seatsField = SEATS_FIELD;
    controlField = CONTROL_FIELD;

    //Id of Car__c to display data
    recordId;

    //car fields displayed with specific format
    carName
    carPictureUrl
    handleRecordLoaded(event){
        const {records} = event.detail;
        const recordData = records[this.recordId];
        this.carName = getFieldValue(recordData, NAME_FIELD);
        this.carPictureUrl = getFieldValue(recordData, PICTURE_URL_FIELD);
    }

    /**Load context for LMS */
    @wire(MessageContext)
    messageContext;

    //subscription reference for carSelected
    carSelectedSubscription;

    connectedCallback(){
        //get selected car Id from carTileList (LMS)
        this.subsribeHandler();
    }

    subsribeHandler(){
        this.carSelectedSubscription = subscribe(this.messageContext, CAR_SELECTED_MESSAGE, (message)=>this.handlerCarSelected(message));
    }

    handlerCarSelected(message){
        this.recordId = message.carId;
    }

    disconnectedCallback(){
        unsubscribe(this.carSelectedSubscription);
        this.carSelectedSubscription = null;
    }

    /**navigation to record page */
    handleNavigateToRecord(){
        this[NavigationMixin.Navigate]({
            type:'standard__recordPage',
            attributes:{
                recordId:this.recordId,
                objectApiName:CAR_OBJECT.objectApiName,
                actionName:'view'
            }
        });
    }


}