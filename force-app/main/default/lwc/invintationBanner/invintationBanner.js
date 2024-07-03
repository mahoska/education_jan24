import { LightningElement, wire } from 'lwc';
import marriageInvitationAssets from '@salesforce/resourceUrl/marriageInvitationAssets';
import getInvitationDetailById from '@salesforce/apex/InvitationController.getInvitationDetailsById';
import CONFETII from  '@salesforce/resourceUrl/confetti';
import {loadScript} from 'lightning/platformResourceLoader';
export default class InvintationBanner extends LightningElement {
    theme = 'theme4';
    //paths to the static resourses
    instagramImage = marriageInvitationAssets+'/instagram.svg';
    facebookImage = marriageInvitationAssets+'/facebook.svg';
    twitterImage = marriageInvitationAssets+'/twitter.svg';
    recordId = '';/*'a00S8000006WXlZIAW';*/
    invitationDetails={};
    isConfettiLoaded = false;

    facebookUrl = '';
    twitterUrl = '';
    instagramUrl = '';

    connectedCallback(){
        let invitationId = new URL(location.href).searchParams.get('invitationid');
        console.log(invitationId);
        if(invitationId){
            this.recordId = invitationId
        }
    }

    //countdown properties
    intervalId;
    days = 0;
    hours = 0;
    minutes = 0;
    seconds = 0;

    //dynamically setting background image style for the banner
    get bannerImage(){
        let themeName = marriageInvitationAssets + `/${this.theme}.jpeg`;
        return `background-image:url(${themeName})`;
    }

    //wire service to fetch invitation details by Id
    @wire(getInvitationDetailById, {Id: '$recordId'})
    invitationDetailHandler({data, error}){
        if(data){
            console.log("invitationDetailHandler", JSON.stringify(data));
            this.theme = data.Theme__c;
            this.invitationDetails = data;
            this.facebookUrl = data.Facebook_Url__c;
            this.twitterUrl = data.Twitter_Url__c;
            this.instagramUrl = data.Instagram_Url__c;
            this.countdownTimer(data.Event_Date_And_Time__c);
        }
        if(error){
            console.error(error);
        }
    }


    //function to start the countdown timer
    countdownTimer(targetDate){
        this.intervalId = setInterval(()=>{
            //get the current time
            const currentTime = new Date().getTime();
            const targetTime = new Date(targetDate).getTime();

            //calculate the time difference
            const timeDifference = targetTime - currentTime;
            this.days = Math.floor(timeDifference / (1000 * 60 * 60 * 24));
            this.hours = Math.floor((timeDifference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            this.minutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
            this.seconds = Math.floor((timeDifference % (1000 * 60)) / 1000);

            if(timeDifference <= 0){
                clearInterval(this.intervalId);
            }
        }, 1000)
    }

    renderedCallback(){
        if(!this.isConfettiLoaded){
            //load the confetti script
            this.isConfettiLoaded = true;
            loadScript(this, CONFETII).then(()=>{
                console.log("loaded CONFETTI Successfully");
                const jsConfetti = new JSConfetti();
                jsConfetti.addConfetti();
            }).catch(error=>{
                console.error("Error loading CONFETTI", error);
            })
        }
        //initialize the confetti
        //this.confetti = new window.ConfettiGenerator(this.template.querySelector('canvas'), {zIndex:2});
    }
}