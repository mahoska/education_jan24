import { LightningElement } from 'lwc';
import LightningAlert from 'lightning/alert';
export default class LightningAlertDemo extends LightningElement {

    async alertHandler(event){
        //window.alert("Hello"); // ealier we were using this
        const {name} = event.target;
        const {hideHeader} = event.target.dataset;
        await LightningAlert.open({
            message:"This is the alert",
            variant:hideHeader?"headerless":'',//hide header
            label:`I am ${name} Header`, 
            theme:name //success->green, warning->orange, error->red, info->grey
        })
        .then(_=>{
            //console.log("result", result);
            let x = 2;
            let y = 3;
            this.add(x,y);
        })
    }

    add(a,b){
        console.log(a+b);
    }
}