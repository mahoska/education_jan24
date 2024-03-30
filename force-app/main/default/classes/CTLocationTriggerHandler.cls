/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-30-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class CTLocationTriggerHandler {
    public static void beforeInsert(List<Location__c> newLocations) {
        for (location__c location : newLocations) {
            // set statuc to 'green' for new locations
            location.Status__c = 'Green';
        }
    }

    /**if status changed update  Status_Update_Date__c*/
    public static void beforeUpdate(List<Location__c> newLocations, Map<Id, Location__c> oldMapLocation){
        for(Location__c location : newLocations) {
            if(location.Status__c != oldMapLocation.get(location.Id).Status__c){
                 location.Status_Update_Date__c = Date.today(); 
            }
        }
    }


    public static void afterUpdate(List<Location__c> newLocations, Map<Id, Location__c> oldMapLocation){
        Set<Id> locationsWithRedStatus = new Set<id>();
        for(Location__c location : newLocations) {
            if(location.Status__c == 'Red' && oldMapLocation.get(location.Id).Status__c != 'Red') {
                locationsWithRedStatus.add(location.Id);
            }
        }

        Set<Id> personIdsInRedLocation = new Set<Id>();
        List<Location_Tracing__c> tracesWithRedLocationStatus = CTLocationTracingController.getLocationsByLocationIds(locationsWithRedStatus);
        for(Location_Tracing__c trace : tracesWithRedLocationStatus){
            personIdsInRedLocation.add(trace.Person__c);
        }

        if(personIdsInRedLocation.size() > 0){
            List<Person__c> updatedPersons = new List<Person__c>();

            for(Id pid : personIdsInRedLocation){
                updatedPersons.add(new Person__c(Id=pid, Health_Status__c='Yellow'));
            }

            update updatedPersons;
        }
    }

}