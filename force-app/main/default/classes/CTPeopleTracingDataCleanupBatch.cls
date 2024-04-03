/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 04-01-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class CTPeopleTracingDataCleanupBatch implements Database.Batchable<SObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc){
         return Database.getQueryLocator('SELECT Id FROM People_Tracing__c WHERE Contact_Date__c < LAST_N_DAYS : 30');
    }

    public void execute(Database.BatchableContext bc, List<People_Tracing__c> scope){
      delete scope;  
    }

    public void finish(database.BatchableContext bc){
        //System.debug('Batch is completed');
    }
}