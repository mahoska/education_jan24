import { LightningElement } from 'lwc';

export default class QuizApp extends LightningElement {
    selected = {};
    correctAnswers = 0;
    isSubmitted = false;
    myQuestions = [
    {
        id: "Question1",
        question:"Cosmic College Business Applications uses Education Cloud and would like to build an online portal for its alumni. The college dean wants to organize volunteer activities and events for the alumni and give them to career advising and job opportunities.Current and prospective students should be able to interact with the this.ariaValueMin. Which of the following should be used to build the online portal?",
        answers:[
            {value:"a", label:"Experience Cloud"},
            {value:"b",label:"Chatter"},
            {value:"c",label:"Einstein Platform"},
        ],
        correctAnswer:"a"
    },
    {
        id: "Question2",
        question:"Cadus Solution would ike to enable recommendations in its customer service site. Which of the following sections should be selected in Workspaces in order to create a recommendation?",
        answers:[
            {value:"a", label:"Builder"},
            {value:"b",label:"Moderation"},
            {value:"c",label:"Content Management"},
        ],
        correctAnswer:"c"
    },
    {
        id: "Question3",
        question:"Acme Appliances wants to add some dashboards to the company's site to monitor activity. How can a dashboard be added to the site?",
        answers:[
            {value:"a", label:"Create dashboard in the site and map it from the Dashboard tab in Salesforce"},
            {value:"b",label:"Create dashboard in Salesforce, ensure that the dashboard folder is available to the site, and map the dashboard in Workspaces"},
            {value:"c",label:"Dashboard are preconfigured and cannot be added to the site"},
        ],
        correctAnswer:"b"
    },
   ] 

   //used for disabling the sumbmit button
   get notAllAnswersSelected(){
    return !(this.myQuestions.length === Object.keys(this.selected).length);
   }

   // for applying dynamic styling to our result
   get isScoredFull(){
    return `slds-text-heading_large ${this.myQuestions.length === this.correctAnswers?
        'slds-text-color_success':'slds-text-color_error'}`
    }
   

   radioGroupHandler(event){
    const {name, value} = event.target; 
    this.selected = {...this.selected, [name]:value };
    //console.log("selected:  ", JSON.parse(JSON.stringify(this.selected)));
   }

   submitHandler(event){
        event.preventDefault();
        let correct = this.myQuestions.filter(item=>this.selected[item.id]===item.correctAnswer);
        this.correctAnswers = correct.length;
        this.isSubmitted = true;
        //console.log( "correctAnswers: ",  this.correctAnswers);
   }

   resetHandler(){
        this.selected={};
        this.correctAnswers=0;
        this.isSubmitted = false;
   }


}