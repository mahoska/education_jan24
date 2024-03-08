/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-08-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class refreshContractController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [SELECT Id, FirstName, LastName, Email FROM Contact LIMIT 10];
    }
}