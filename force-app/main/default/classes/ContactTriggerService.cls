/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-29-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class ContactTriggerService {
   
    public static void updateAccount(Set<Id> accountsIdSet){
        Map<Id, Account> accountsForUpdate = new Map<Id, Account>();

        for(AggregateResult ar : [SELECT  AccountId, COUNT(Id) activeContacts
                                    FROM Contact 
                                    WHERE isActive__c=true AND AccountId IN :accountsIdSet 
                                    GROUP BY AccountId]){
                
            Id accId = (Id) ar.get('AccountId');
            Integer activeContactsAmount = (Integer) ar.get('activeContacts');                          
            Account ac = new Account(Id=accId, Active_Contacts__c=activeContactsAmount);
            accountsForUpdate.put(accId, ac);                          
        }

        //update accounts with zero active contacts
        for(Id accId : accountsIdSet){
            if(!accountsForUpdate.containsKey(accId)){
                Account ac = new Account(Id=accId, Active_Contacts__c=0);
                accountsForUpdate.put(accId, ac);   
            }
        }

        update accountsForUpdate.values();       
    }
}