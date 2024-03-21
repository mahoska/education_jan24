import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class Notifications extends LightningElement {

    toastHandler(){
        this.showToast('Success', '{0} Account Created! {1}','success');
    }

    toastHandlerErr(){
        this.showToast('Error!', 'Account Creation Failed','error');
    }

    toastHandlerWarn(){
        this.showToast('Warning!', 'Password should have 15 characters','warning');
    }

    toastHandlerInfo(){
        this.showToast('Info!', 'Summer 20 realease is available','info','sticky');
    }


    showToast(title, message, variant, mode){
        const event = new ShowToastEvent({
            title:title,
            message:message,
            variant:variant,
            messageData:[
                'Salesforce', {
                    url:'https://www.salesforce.com',
                    label:'Click Here'
                }
            ],
            mode:mode
        });
        this.dispatchEvent(event);
    }
}