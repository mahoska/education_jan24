/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 04-01-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class CTLocationStatusUpdateBatch implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        List<String> healthStatuses = new List<String> {'Red', 'Orange', 'Yellow'};
        Date today = Date.today();
        Date fourteenDayAgo = today - 14;
        return Database.getQueryLocator('SELECT Id FROM Location__c WHERE Status__c = :healthStatuses  AND Status_Update_Date__c = :fourteenDayAgo ');
    }

    public void execute(Database.BatchableContext bc, List<Location__c> scope){
        for(Location__c location : scope){
            location.Status__c = 'Green';
        }
        update scope;
    }

    public void finish(database.BatchableContext bc){
       //System.debug('Batch is completed');
    }
    
}