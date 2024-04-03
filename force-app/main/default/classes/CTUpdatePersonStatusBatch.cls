/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 04-01-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class CTUpdatePersonStatusBatch implements Database.Batchable<SObject>{

    public  Database.QueryLocator start(Database.BatchableContext bc){
        Date today = Date.today();
        Date fourteenDaysAgo = today - 14;
        List<String> healthStatuses = new List<String> {'Red', 'Orange', 'Yellow'};
        return Database.getQueryLocator('SELECT Id, Health_Status__c FROM Person__c WHERE Status_Update_Date__c = :fourteenDaysAgo AND Health_Status__c IN :healthStatuses');
    }

    public void execute(Database.BatchableContext bc, List<Person__c> scope){
        for(Person__c person : scope){
            person.Health_Status__c = 'Green';
        }
        update scope;
    }

    public void finish(database.BatchableContext bc){
       //System.debug('Batch is completed');
    }
}