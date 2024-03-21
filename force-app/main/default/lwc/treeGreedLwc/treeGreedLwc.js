import { LightningElement, wire } from 'lwc';
import allAccountsWithContacts from '@salesforce/apex/AccountContact.allAccountsWithContacts';
export default class TreeGreedLwc extends LightningElement {
    gridData = [];
  
    @wire(allAccountsWithContacts)
    accountsWithContactsResult({data, error}){
        if(data){
            console.log(data);
            this.formatGridData(data);
        }
        if(error){
            console.error(error);
        }
    }


    /**Columns */
    gridColumns = [
        {
            label:"Name",
            fieldName:"Name",
            type:'text'
        },
        {
            label:"Phone",
            fieldName:"Phone",
            type:'text'
        },
        {
            label:"Account Website",
            fieldName:"Website",
            type:'url',
            typeAttributes:{
                target:'_blank'
            }
        } 
    ];

    dummyData = [
        {
            Name:"Salesforce",
            Email:"Salesforce@gmail.com",
            Website:'https://trailhead.salesforce.com/'
        },
        {
            Name:"Troop",
            Email:"troop@gmail.com",
            Website:'salesforcetroop.com'
        },
    ]

    formatGridData(result){
        this.gridData = result.map(item=>{
            const {Contacts, ...accounts} = item;
            const updatedContact = Contacts.map(cont=>{
                return {...cont, "_children":this.dummyData}
            });
            return {...accounts, "_children":updatedContact};
        });
        console.log(this.gridData);
    }
}