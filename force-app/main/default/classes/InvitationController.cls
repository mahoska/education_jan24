/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 07-01-2024
 * @last modified by  : Hanna Makhovska
**/
public without sharing class InvitationController {
    
    //get Invintation details by Id
    @AuraEnabled(cacheable=true)
    public static Invitation__c getInvitationDetailsById(String Id) {
        try{
            return [SELECT Id, Name, Event_Address__c, Event_Date_And_Time__c, Theme__c, Instagram_Url__c, Twitter_Url__c, Facebook_Url__c, 
            Greeting_Message__c, Event_Introduction__c, Invite_URL__c, Event_Participants__c FROM Invitation__c WHERE Id= :Id ];
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //get program details by Invitation Id
    @AuraEnabled(cacheable=true)
    public static List<Program_Detail__c> getProgramDetailsByInvitationId(String InvitationId) {
        try{
            return [SELECT Id, Program_Date__c, Program_End_Time__c, Program_Start_Time__c, Name  FROM Program_Detail__c WHERE Invitation__c= :InvitationId ];
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //get Invintation address by Id
    @AuraEnabled(cacheable=true)
    public static Invitation__c getInvitationAddressById(String Id) {
        try{
            return [SELECT Id, Event_Address__c, Event_Map_URL__c, Contact_Number__c FROM Invitation__c WHERE Id= :Id ];
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //get RSVP details by Id
    @AuraEnabled(cacheable=true)
    public static Invitation__c getRSVPDetails(String Id) {
        try{
            return [SELECT Id, Rsvp_Accept_Message__c, Rsvp_after_date_Message__c, Rsvp_Decline_Message__c, Respond_By__c FROM Invitation__c WHERE Id= :Id ];
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    //get Response picklist values
    @AuraEnabled(cacheable=true)
    public static List<String> getResponsePicklistValues(){
        //retreive the picklist values
        List<String> picklistValues = new List<String>();
        for(Schema.PicklistEntry picklistEntry:Invitation_Response__c.Response__c.getDescribe().getPicklistValues()){
            picklistValues.add(picklistEntry.getValue());
        }
        return picklistValues;
    }

    //Submit invitation Response
    @AuraEnabled
    public static Boolean submitResponse(Id InvitationId, String Name, String Email, String Phone, String Response, String additionalGuests, String additionalComment) {
        try{
            if(InvitationId != null){
                Invitation_Response__c responseRecord = new Invitation_Response__c(
                    Invitation__c = InvitationId,
                    Name__c = Name,
                    Email__c = Email,
                    Phone__c = Phone,
                    Response__c = Response,
                    Number_of_additional_Guests__c = Decimal.valueOf(additionalGuests),
                    Additional_comments__c = additionalComment
                );
                insert responseRecord;
                return true;
            }
            return false;
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}