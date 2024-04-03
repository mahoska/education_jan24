/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-31-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class LeadAsynchronous {

    @future
    public static void updateLeadRecords(Set<Id> existingRecordIds){
        List<Lead> existingRecords = [SELECT Id, LeadSource FROM Lead WHERE Id IN :existingRecordIds];
        for(Lead  record : existingRecords){
            record.LeadSource = 'Web';
        }
        update existingRecords;
    }
}