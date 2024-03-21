import { LightningElement, api } from 'lwc';

export default class SetterDemoChildComponent extends LightningElement {
    userData;
    objDataFromParent;

    @api
    get detail(){
        return this.userData;
    }

    set detail(data){
        let newAgeData = data.age*2;
        this.userData = {...data, 'age':newAgeData, 'location':'Szczecin'};
    }

    @api 
    get objdata(){
        return this.userData;
    }

    set objdata(data){
        this.objDataFromParent  = data.map(item=>{
            return item.name === "b"? {"name":"troop"}:{...item}
        });
    }


}