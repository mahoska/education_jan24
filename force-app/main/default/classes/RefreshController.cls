/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-21-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class RefreshController {
    @AuraEnabled
    public static List<Account> getAccountRating(Id accountId){
        return [SELECT Id, Rating FROM Account WHERE Id =: accountId];
    }
}