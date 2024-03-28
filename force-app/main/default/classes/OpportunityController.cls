/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-28-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class OpportunityController {

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunities(){
        return [SELECT StageName FROM Opportunity];
    }

    public static void updateProfile(List<id> oppIds){
        List<Opportunity> oppsList = [SELECT Id, Amount, Profile__c FROM Opportunity WHERE Id IN :oppIds];
        for(Opportunity opp : oppsList){
            if(opp.Amount == null || opp.Amount < 10000){
                opp.Profile__c= 'Low';
            }else if(opp.Amount > 50000){
                opp.Profile__c = 'High';
            }else {
                opp.Profile__c = 'Medium';
            }
        }
        update oppsList;
    }
}