/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-30-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class ContactTriggerHandler {
    public static void checkActiveContact(List<Contact> contactsList){
        Set<Id> accountsWithChangeActiveContacts = new Set<Id>();
        for(Contact con : contactsList){
            if(String.isNotBlank(con.AccountId) && con.isActive__c==true){
                accountsWithChangeActiveContacts.add(con.AccountId);
            }
        }
        if(accountsWithChangeActiveContacts.size() > 0) {
            ContactTriggerService.updateAccount(accountsWithChangeActiveContacts);
        }     
    }

    public static void afterUpdateContact(List<Contact> newContactsList, Map<Id,Contact> oldContactsMap){
        Set<Id> accountsWithChangeActiveContacts = new Set<Id>();
        for(Contact con : newContactsList){
            if(String.isNotBlank(con.AccountId) && con.isActive__c != oldContactsMap.get(con.Id).isActive__c){
                accountsWithChangeActiveContacts.add(con.AccountId);
            }
        }
        if(accountsWithChangeActiveContacts.size() > 0) {
            ContactTriggerService.updateAccount(accountsWithChangeActiveContacts);
        }     
    }
}