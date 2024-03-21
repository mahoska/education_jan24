import { LightningElement } from 'lwc';

export default class NewConditionDerective extends LightningElement {
    showText = false;

    get getLabel(){
        return this.showText ? 'Hide Text' : 'Show Text';
    }

    showTextHandler(){
        this.showText = !this.showText;
    }

    country = "Ukraine";
    newCountry = "USA";

    get isCountryUkraine(){
        console.log("getter isCountryUkraine called");
        return this.country === 'Ukraine';
    }

    countryChangeHandler(event){
        this.country = event.target.value;
    }

    get isCountryUSA(){
        console.log("getter isCountryUSA called");
        return this.newCountry === 'USA';
    }

    get isCountryCanada(){
        console.log("getter isCountryCanada called");
        return this.newCountry === 'Canada';
    }

    newcountryChangeHandler(event){
        this.newCountry = event.target.value;
    }

}