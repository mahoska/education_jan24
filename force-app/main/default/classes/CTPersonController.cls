/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-30-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class CTPersonController {

    public static String getToken(String mobileNo) {
        Blob targetBlob = Blob.valueOf(mobileNo);
        Blob hash = Crypto.generateDigest('MD5', targetBlob);

        //get the string value of hash blob
        return EncodingUtil.base64Encode(hash);
    }

    /**get 100 contacts with recent health status change
     * @return List<Person__c>
     */
    public static List<Person__c> getRecentHealthChanges(){
        return [SELECT Id, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c,  Name
                FROM Person__c 
                ORDER BY Status_Update_Date__c DESC
                NULLS LAST
                LIMIT 100];
    }

    
      /**search people on by name, mobile number or token
     * @return List<Person__c>
     */
    public static List<Person__c>searchPeople(String searchTerm){
        searchTerm = searchTerm + '%';
        return [SELECT Id, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c,  Name
        FROM Person__c 
        WHERE Name LIKE :searchTerm
        OR Mobile__c LIKE :searchTerm
        OR Token__c LIKE :searchTerm
        ORDER BY Status_Update_Date__c DESC
        NULLS LAST];
    }

     /**search person by Id
     * @return Person__c
     */
    public static Person__c getPersonById(String personId){
        List<Person__c> people =  [SELECT Id, Health_Status__c, Mobile__c, Status_Update_Date__c, Token__c,  Name
                                    FROM Person__c 
                                    WHERE Id = :personId];
        if(people != null && people.size() > 0){
            return people[0];
        }

        return null;
    }

    /** get count of people in each health status
     * @return  Map<String, Integer>
    */
    public static Map<String, Integer> getHealthStatusCount(){
        Map<String, Integer> healthCountMap = new Map<String, Integer>();

        for(AggregateResult result : [SELECT Health_Status__c, Count(Id) countPeople 
                                        FROM Person__c 
                                        GROUP BY Health_Status__c]){
            healthCountMap.put((String)result.get('Health_Status__c'), (Integer)result.get('countPeople'));
        }

        return healthCountMap;
    }

    public static Set<Id> getCohabitants(Set<Id> personIdsSet, Set<Id> alreadyProcessed){
        List<String> healthStatuses  = new List<String> {'Green', 'Yellow'};
        List<People_Tracing__c> peopleTraces = [SELECT Id, Person_1__c, Person_2__c 
                                                FROM People_Tracing__c 
                                                WHERE (Person_1__c IN :personIdsSet OR Person_2__c IN :personIdsSet) 
                                                AND Contact_Type__c = 'Cohabitant'
                                                AND (Person_1__r.Health_Status__c IN :healthStatuses OR Person_2__r.Health_Status__c IN :healthStatuses)];
        
        Set<Id> cohabitants = new Set<Id>();
        for(People_Tracing__c pt : peopleTraces){
            if(!alreadyProcessed.contains(pt.Person_1__c)){
                cohabitants.add(pt.Person_1__c);
                alreadyProcessed.add(pt.Person_1__c);
            }
            if(!personIdsSet.contains(pt.Person_2__c)){
                cohabitants.add(pt.Person_2__c);
                alreadyProcessed.add(pt.Person_1__c);
            }
        }
        return cohabitants;
    }

    public static Set<Id> getNeighbours(Set<Id> personIdsSet, Set<Id> alreadyProcessed){
        List<People_Tracing__c> peopleTraces = [SELECT Id, Person_1__c, Person_2__c 
                                                FROM People_Tracing__c 
                                                WHERE (Person_1__c IN :personIdsSet OR Person_2__c IN :personIdsSet) 
                                                AND Contact_Type__c = 'Neighbour'
                                                AND (Person_1__r.Health_Status__c = 'Green' OR Person_2__r.Health_Status__c = 'Green')];
        
        Set<Id> neighbours = new Set<Id>();
        for(People_Tracing__c pt : peopleTraces){
            if(!alreadyProcessed.contains(pt.Person_1__c)){
                neighbours.add(pt.Person_1__c);
                alreadyProcessed.add(pt.Person_1__c);
            }
            if(!alreadyProcessed.contains(pt.Person_2__c)){
                neighbours.add(pt.Person_2__c);
                alreadyProcessed.add(pt.Person_2__c);
            }
        }
        return neighbours;
    }

    public static Set<Id> getPrimaryContact(Set<Id> personIdsSet, Set<Id> alreadyProcessed){
        List<String> healthStatuses  = new List<String> {'Green', 'Yellow'};
        List<People_Tracing__c> peopleTraces = [SELECT Id, Person_1__c, Person_2__c 
                                                FROM People_Tracing__c 
                                                WHERE (Person_1__c IN :personIdsSet OR Person_2__c IN :personIdsSet) 
                                                AND Contact_Type__c = 'Other'
                                                AND Contact_Date__c = LAST_N_DAYS:10
                                                AND (Person_1__r.Health_Status__c IN :healthStatuses  OR Person_2__r.Health_Status__c IN :healthStatuses)];
        
        Set<Id> primaryContacts = new Set<Id>();
        for(People_Tracing__c pt : peopleTraces){
            if(!alreadyProcessed.contains(pt.Person_1__c)){
                primaryContacts.add(pt.Person_1__c);
                alreadyProcessed.add(pt.Person_1__c);
            }
            if(!alreadyProcessed.contains(pt.Person_2__c)){
                primaryContacts.add(pt.Person_2__c);
                alreadyProcessed.add(pt.Person_2__c);
            }
        }
        return primaryContacts;
    }

    public static Set<Id> getSecondaryContact(Set<Id> primaryContactIdsSet, Set<Id> alreadyProcessed){
        List<String> healthStatuses  = new List<String> {'Green', 'Yellow'};
        List<People_Tracing__c> peopleTraces = [SELECT Id, Person_1__c, Person_2__c 
                                                FROM People_Tracing__c 
                                                WHERE (Person_1__c IN :primaryContactIdsSet OR Person_2__c IN :primaryContactIdsSet) 
                                                AND Contact_Type__c = 'Other'
                                                AND Contact_Date__c = LAST_N_DAYS:10
                                                AND (Person_1__r.Health_Status__c = 'Green'  OR Person_2__r.Health_Status__c = 'Green')];
        
        Set<Id> secondaryContacts = new Set<Id>();
        for(People_Tracing__c pt : peopleTraces){
            if(!alreadyProcessed.contains(pt.Person_1__c)){
                secondaryContacts.add(pt.Person_1__c);
                alreadyProcessed.add(pt.Person_1__c);
            }
            if(!alreadyProcessed.contains(pt.Person_2__c)){
                secondaryContacts.add(pt.Person_2__c);
                alreadyProcessed.add(pt.Person_2__c);
            }
        }
        return secondaryContacts;
    }
}