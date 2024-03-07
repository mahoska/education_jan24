import { LightningElement, wire, api } from 'lwc';
import {getRecord, getFieldValue, getFieldDisplayValue} from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import OWNER_NAME_FIELD from '@salesforce/schema/Account.Owner.Name';
import ANNUAL_REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
export default class GetRecordDemo extends LightningElement {
    name;
    owner;
    annualRevenue;

    @api  recordId;
    //***some fields***
    //@wire(getRecord, {recordId:'$recordId', fields:[NAME_FIELD, OWNER_NAME_FIELD, ANNUAL_REVENUE_FIELD]})
    //***all fields***
    /*
    @wire(getRecord, {recordId:'$recordId', layoutTypes:['Full'], mode:['View']})
    accountHandler({data, error}){
        if(data){
            console.log(data);
            this.name = data.fields.Name.displayValue ? data.fields.Name.displayValue : data.fields.Name.value;
            this.owner = data.fields.Owner.displayValue ? data.fields.Owner.displayValue : data.fields.Owner.value;
            this.annualRevenue = data.fields.AnnualRevenue.displayValue ? data.fields.AnnualRevenue.displayValue : data.fields.AnnualRevenue.value;
        }
        if(error){
            console.error(error);
        }
    }
    */

    /**use getFieldValue and getFieldDisplayValue */
    @wire(getRecord, {recordId:'$recordId', layoutTypes:['Full'], mode:['View']})
    accountHandler({data, error}){
        if(data){
            console.log(data);
            this.name = getFieldValue(data, NAME_FIELD);
            this.owner = getFieldValue(data, OWNER_NAME_FIELD);
            this.annualRevenue = getFieldDisplayValue(data, ANNUAL_REVENUE_FIELD);
        }
        if(error){
            console.error(error);
        }
    }

}