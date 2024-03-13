/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-12-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class MapControllerLWC {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name, description, BillingStreet, BillingCountry, BillingCity, BillingState, BillingPostalCode FROM Account ORDER BY Name LIMIT 10];
        
    }
}