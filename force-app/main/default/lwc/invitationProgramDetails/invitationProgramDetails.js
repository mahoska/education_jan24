import { LightningElement, wire } from 'lwc';
import getProgramDetailsByInvitationId from '@salesforce/apex/InvitationController.getProgramDetailsByInvitationId';
export default class InvitationProgramDetails extends LightningElement {
    recordId = '';/*'a00S8000006WXlZIAW';*/
    programList = [];

    connectedCallback(){
        let invitationId = new URL(location.href).searchParams.get('invitationid');
        //console.log(invitationId);
        if(invitationId){
            this.recordId = invitationId;
        }
    }

    @wire(getProgramDetailsByInvitationId, {InvitationId: '$recordId'})
    programDetailsHandler({data, error}){
        if(data){
            console.log("programDetailsList", JSON.stringify(data));
            this.programList = data;
        }
        if(error){
            console.error(error);
        }
    }
}