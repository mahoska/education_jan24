/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-29-2024
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
}