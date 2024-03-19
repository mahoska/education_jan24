import { LightningElement, api } from 'lwc';

export default class GoogleAction extends LightningElement {
    @api recordId;
    @api invoke(){
        console.log("invoked", this.recordId);
        window.open("https://google.com","_blank");
    }
}