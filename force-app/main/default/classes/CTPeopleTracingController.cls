/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-29-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class CTPeopleTracingController {
 
    public static List<People_Tracing__c> getTraces(String recordId){
        return [SELECT Id, Name, Contact_Date__c, Contact_Type__c, Person_1__c, Person_2__c, Person_1__r.Health_Status__c, Person_2__r.Health_Status__c, Person_1__r.Token__c, Person_2__r.Token__c 
        FROM People_Tracing__c
        WHERE Person_1__c = :recordId OR Person_2__c = :recordId
        ORDER BY Contact_Date__c DESC];
    }

    public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> newPeopleTraces){
        //unique person ids
        Set<Id> personIdsSet = new Set<Id>();

        for(People_Tracing__c trace : newPeopleTraces){
            personIdsSet.add(trace.Person_1__c);
            personIdsSet.add(trace.Person_2__c);
        }

        //list duplicates
        List<People_Tracing__c> duplicatesList = new List<People_Tracing__c>();

        //map person id and set of person id
        Map<Id, Set<Id>>  mapOfExistingRecords = new Map<Id,Set<Id>>();
        
        List<People_Tracing__c> existingRecords = [SELECT Id, Person_1__c, Person_2__c  
                                                    FROM People_Tracing__c
                                                     WHERE Person_1__c IN :personIdsSet
                                                     OR Person_2__c IN :personIdsSet
                                                    ];

        if(existingRecords != null && existingRecords.size() > 0){
            for(People_Tracing__c trace : existingRecords){
                //build map for person 1
                if(!mapOfExistingRecords.containsKey(trace.Person_1__c)){
                     mapOfExistingRecords.put(trace.Person_1__c, new Set<Id>());
                }

                mapOfExistingRecords.get(trace.Person_1__c).add(trace.Person_2__c); 

                //build map for person 2
                if(!mapOfExistingRecords.containsKey(trace.Person_2__c)){
                    mapOfExistingRecords.put(trace.Person_2__c, new Set<Id>());
               }

               mapOfExistingRecords.get(trace.Person_2__c).add(trace.Person_1__c); 
            }

            //loop over existing records to find duplicates
            for(People_Tracing__c trace : newPeopleTraces){
                //check duplicates in map
                if((mapOfExistingRecords.containsKey(trace.Person_1__c) && mapOfExistingRecords.get(trace.Person_1__c).contains(trace.Person_2__c))
                ||
                (mapOfExistingRecords.containsKey(trace.Person_2__c) && mapOfExistingRecords.get(trace.Person_2__c).contains(trace.Person_1__c)))
                
                duplicatesList.add(trace);
            }
        }

        return duplicatesList;
    }
}