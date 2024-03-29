/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-29-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class CTLocationController {
    
    public static List<Location__c> getRecentStatusChange(){
        return [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c 
        FROM Location__c
        ORDER BY Status_Update_Date__c DESC
        NULLS LAST];
    }

      /**search location by name, zipcode or address
     * @return List<Location__c>
     */
    public static List<Location__c> searchLocations(String searchTerm){
        searchTerm = searchTerm + '%';
        return [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c 
        FROM Location__c
        WHERE Name LIKE :searchTerm
        OR Pincode__c LIKE :searchTerm
        OR Address__c LIKE :searchTerm
        ORDER BY Status_Update_Date__c DESC
        NULLS LAST];
    }

    /**search location by Id
     * @return Location__c
     */
    public static Location__c getLocationById(String locationId){
        List<Location__c> locations =  [SELECT Id, Name, Address__c, Pincode__c, Red_Score__c, Status_Update_Date__c, Status__c 
                                    FROM Location__c
                                    WHERE Id = :locationId];
        if(locations != null && locations.size() > 0){
            return locations[0];
        }

        return null;
    }

    /** get count of locations in each health status
     * @return  Map<String, Integer>
    */
    public static Map<String, Integer> getStatusCount(){
        Map<String, Integer> statusCountMap = new Map<String, Integer>();

        for(AggregateResult result : [SELECT Status__c, Count(Id) countLocation 
                                        FROM Location__c 
                                        GROUP BY Status__c]){
            statusCountMap.put((String)result.get('Status__c'), (Integer)result.get('countLocation'));
        }

        return statusCountMap;

    }
}