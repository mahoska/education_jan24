/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-29-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class CTLocationTracingController {
    /**get all visitors for location
     * @param locationId
     * @return List<Location_Tracing__c>
    */
    public static List<Location_Tracing__c> getVisitors(String locationId){
        return [SELECT Id, Person__c, Name, Location__c, Location__r.Name, Visit_Date__c,Person__r.Token__c, Person__r.Health_Status__c
        FROM Location_Tracing__c 
        WHERE  Location__c = :locationId 
        ORDER BY Visit_Date__c DESC];
    }

      /**get last  10 days location ids for visitors
     * @param personIds
     * @return List<Location_Tracing__c>
    */
    public static List<Location_Tracing__c> getLocationsByPerson(Set<Id> personIds){
        return [SELECT Id, Person__c,  Location__c 
        FROM Location_Tracing__c 
        WHERE  Person__c IN :personIds AND  Visit_Date__c = LAST_N_DAYS:10];
    }

    /**get last  10 days visitor ids for location
     * @param locationId
     * @return List<Location_Tracing__c>
    */
    public static List<Location_Tracing__c> getLocationsByLocationIds(Set<Id> locationIds){
        return [SELECT Id, Person__c, Location__c
        FROM Location_Tracing__c 
        WHERE  Location__c IN :locationIds AND Person__r.Health_Status__c = 'Green' AND Visit_Date__c = LAST_N_DAYS:10];
    }


    public static List<Location_Tracing__c> checkDuplicates (List<Location_Tracing__c> newLocationTraces){
        Set<Id> peopleIdsSet = new Set<Id>();
        Set<Id> locationIdsSet = new Set<Id>();

        for(Location_Tracing__c trace : newLocationTraces){
            peopleIdsSet.add(trace.Person__c);
            locationIdsSet.add(trace.Location__c);
        }

        //map of location id, set of person ids
        Map<Id, Set<Id>> mapOfExistingRecords = new Map<Id, Set<Id>>();
        
        //query existing location tracing records
        List<Location_Tracing__c> existingRecords = [SELECT Id, Person__c,  Location__c 
                                                    FROM Location_Tracing__c 
                                                    WHERE  Person__c IN :peopleIdsSet AND Location__c IN :locationIdsSet];

        //list of duplicate records
        List<Location_Tracing__c> duplicatesList = new List<Location_Tracing__c>();

        if(existingRecords != null && existingRecords.size()>0){
            for(Location_Tracing__c trace : existingRecords){
                if(!mapOfExistingRecords.containsKey(trace.Location__c)){
                    mapOfExistingRecords.put(trace.Location__c, new Set<Id>());
                }

                //add person ids to map set
                mapOfExistingRecords.get(trace.Location__c).add(trace.Person__c);
            }

            //loop over new location tracing records
            for (Location_Tracing__c trace : newLocationTraces){
                //first check for location id
                //if item found in map, then check for person in set
                if(mapOfExistingRecords.containsKey(trace.Location__c) && mapOfExistingRecords.get(trace.Location__c).contains(trace.Person__c)){
                    duplicatesList.add(trace);
                }
            }
        }

        return duplicatesList;
    }
}