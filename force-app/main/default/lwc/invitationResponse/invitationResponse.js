import { LightningElement, wire } from 'lwc';
import getRVSPDetails from '@salesforce/apex/InvitationController.getRSVPDetails';
import getResponsePicklistValues from '@salesforce/apex/InvitationController.getResponsePicklistValues';
import submitResponse from '@salesforce/apex/InvitationController.submitResponse';
export default class InvitationResponse extends LightningElement {

    recordId = '';/*'a00S8000006WXlZIAW';*/
    formData={};
    rsvpDetailsInfo={};
    rvspMessage='';
    /*get rvspOptions(){
        return [
            {label:"Joyfully Accept", value:"Joyfully Accept"},
            {label:"Regretfully Decline", value:"Regretfully Decline"}
        ];
    }*/

        connectedCallback(){
            let invitationId = new URL(location.href).searchParams.get('invitationid');
            //console.log(invitationId);
            if(invitationId){
                this.recordId = invitationId;
            }
        }

    @wire(getResponsePicklistValues)
    picklistHandler({data, error}){
        if(data){
            console.log("picklist", data);
            this.rvspOptions = data.map(item=>{
                return {label:item, value:item}
            });
            this.checkAndSetMessage();
        }
        if(error){
            console.error(error);
        }
    }

    @wire(getRVSPDetails, {Id: '$recordId'})
    rvspHandler({data, error}){
        if(data){
            console.log("rvspHandler data:", JSON.stringify(data));
            this.rsvpDetailsInfo = data;
        }
        if(error){
            console.error(error);
        }
    }

    changeHandler(event){
        const {name, value} = event.target //name = "Email", "test1@gmail.com"
        this.formData={...this.formData, [name]:value}
    }

    submitHandler(event){
        this.rvspMessage = '';
        event.preventDefault();
        console.log("this.formData", JSON.stringify(this.formData));
        const {Name, Email, Phone, Response, additionalGuests='0', additionalComment} = this.formData;
        submitResponse({
            InvitationId: this.recordId,
            Name,
            Email, 
            Phone,
            Response,
            additionalGuests, 
            additionalComment
        }).then(result=>{
            console.log("result", result);
            if(result){
                localStorage.setItem(`InvitationSubmitted-${this.recordId}`, Response);
                this.checkAndSetMessage();
            }
        }).catch(error=>{
            console.error("submitResponse error", error);
        })
    }

    checkAndSetMessage(){
        let isResponseSubmitted = '';
        let allKeys = Object.keys(window.localStorage);
        allKeys.forEach(item=>{
            if(item.endsWith(this.recordId)){
                isResponseSubmitted = localStorage[item];
                console.log('isResponseSubmitted:', isResponseSubmitted);
            }
        });

        if(isResponseSubmitted === 'Joyfully Accept'){
            this.rvspMessage = this.rsvpDetailsInfo.Rsvp_Accept_Message__c;
        }else if(isResponseSubmitted === 'Regretfully Decline'){
            this.rvspMessage = this.rsvpDetailsInfo.Rsvp_Decline_Message__c;
        }else if(!isResponseSubmitted && this.isRespondByDateIsPast(this.rsvpDetailsInfo.Respond_By__c)){
            this.rvspMessage = this.rsvpDetailsInfo.Rsvp_after_date_Message__c;
        }else{
            this.rvspMessage = '';
        }
    }

    isRespondByDateIsPast(respondByDate){
        //get the current date
        const today = new Date();
        //provide a date to compare
        const providedate = new Date(respondByDate);

        if(today>providedate){
            return true;
        }else{
            return false;
        }
    }
}