import { LightningElement } from 'lwc';

export default class C2pParentComponent extends LightningElement {
    showModal = false;
    massage;

    clickHandler(){
        this.showModal = true;
    }

    closeHandler(event){
        this.showModal = false;
        this.message = event.detail.msg; 
    }
}