import { LightningElement } from 'lwc';
import LightningConfirm from 'lightning/confirm';
export default class LightningComfirmDemo extends LightningElement {

    async comfirmHandler(){
        const result = await LightningConfirm.open({
            message:'Would you like to refresh the page?',
            //variant:"headerless":'',//hide header
            label:'Are you sure?', 
            theme:'success' //success->green, warning->orange, error->red, info->grey
        });
        console.log(result);
        //on click on Ok result will be true else false 
        if(result === true){
            location.reload();
        }
    }
}