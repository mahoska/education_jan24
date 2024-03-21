import { LightningElement } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class RecordEditCustom extends LightningElement {
    objectName = ACCOUNT_OBJECT;
    inputValue;

    changeHandler(event){
        this.inputValue = event.target.value;
    }

    submitHandler(event){
        event.preventDefault();
        const inputCmp  = this.template.querySelector('lightning-input');
        const value = inputCmp.value;
        if(!value.includes('Australia')){
            inputCmp.setCustomValidity("The account name must include 'Australia");
        }else{
            inputCmp.setCustomValidity("");
            const fields = event.detail.fields;
            fields.Name = value;
            this.template.querySelector('lightning-record-edit-form').submit(fields);
        }
        inputCmp.reportValidity();
    }

    successHandler(event){
        const message = "Record Id:"+event.detail.id;
        this.showToast("Account created", message, "success" );
    }

   errorHandler(event){
        const message = event.detail.message;
        this.showToast("Error creating Account", message, "error" );
   }

   showToast(title, message, variant){
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(toastEvent);
   }

}