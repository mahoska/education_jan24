/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-19-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class AccountContact {
    @AuraEnabled(cacheable=true)
    public static List<Account> allAccountsWithContacts(){
        return [SELECT Id, Name, Phone, Website, (SELECT Id, Name, Phone, Email FROM Contacts) FROM Account LIMIT 5];
    }

}