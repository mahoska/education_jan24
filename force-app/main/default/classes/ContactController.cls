/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-12-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList() {
        return [SELECT Id, Name, Title, Email FROM Contact];
    }
}