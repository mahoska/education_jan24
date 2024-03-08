import { LightningElement, wire } from 'lwc';
import filterAccountByType from '@salesforce/apex/AccountController.filterAccountByType';
export default class WireApexWithParams extends LightningElement {
    selectedType='';
    @wire(filterAccountByType, {type:'$selectedType'})
    filterAccounts;

    get typeOptions(){
        return[
            {label:'Customer - Channel', value:'Customer - Channel'},
            {label:'Customer - Direct', value:'Customer - Direct'},
        ]
    }

    handleChange(event){
        this.selectedType = event.target.value;
    }

}