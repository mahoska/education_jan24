import { LightningElement } from 'lwc';
import LightningPrompt from 'lightning/prompt';
import LightningAlert from 'lightning/alert';
export default class LightningPromtDemo extends LightningElement {
    /*async promptHandler(){
        const result = await LightningPrompt.open({
            message:'Please enter your age',
        });
        console.log(result);
    }*/

    promptHandler(){
        const result = LightningPrompt.open({
            message:'Please enter your age',
            label:"check your eligibility",
            theme:"success",//error, warning, info
            defaultValue:30
        }).then(result=>{
            console.log(result);
            if(result && Number(result)>18){
                this.alertHandler('You are eligible', 'Congratulate', 'success');
            }else{
                this.alertHandler('You are not eligible', 'Sorry', 'error');
            }
        })
    }

    alertHandler(message, label, theme){
        LightningAlert.open({
            message:message,
            label:label,
            theme:theme
        });
    }
}