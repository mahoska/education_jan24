import { LightningElement, wire } from 'lwc';
import getInvitationAddress from '@salesforce/apex/InvitationController.getInvitationAddressById';
export default class InvantationAddress extends LightningElement {
    recordId = '';/*'a00S8000006WXlZIAW';*/
    addressDetails={};

    connectedCallback(){
        let invitationId = new URL(location.href).searchParams.get('invitationid');
        //console.log(invitationId);
        if(invitationId){
            this.recordId = invitationId
        }
    }

    @wire(getInvitationAddress, {Id:'$recordId'})
    addressHandler({data, error}){
        if(data){
            console.log("addressHandler data:", JSON.stringify(data));
            this.addressDetails = data;
        }
        if(error){
            console.log("addressHandler error:", error);
        }
    }
}