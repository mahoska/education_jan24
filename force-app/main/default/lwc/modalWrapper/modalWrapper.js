import { LightningElement } from 'lwc';

export default class ModalWrapper extends LightningElement {
isOpen = false;
isOpenSecond = false;

openHandler(){
    this.isOpen = true;
}

closeHandler(){
    this.isOpen = false;
}

openSecondHandler(){
    this.isOpenSecond = true;
}

closeSecondHandler(){
    this.isOpenSecond = false;
}

}