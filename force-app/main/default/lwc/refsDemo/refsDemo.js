import { LightningElement } from 'lwc';

export default class RefsDemo extends LightningElement {

    submitHandler(){
        console.log('this.refs.nameRef ',this.refs.nameRef);
        const nameVal = this.refs.nameRef.value;
        const ageVal = this.refs.ageRef.value;
        //if hte template contains dublicate lwc:ref derectives, this.refs references the last directive
        console.log('nameVal ',nameVal);
        console.log('ageVal ',ageVal);

        this.refs.responseRef.innerHTML = `<p>Submitted Name is ${nameVal} and Age is ${ageVal}</p>`;
    }

    //this.querySelector() vs refs
    //refs - more performance, because the appeal goes directly to the element
}