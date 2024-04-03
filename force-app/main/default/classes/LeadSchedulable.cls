/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-31-2024
 * @last modified by  : Hanna Makhovska
**/
public class LeadSchedulable implements Schedulable{

    public void execute(SchedulableContext sc){
        // write your code here
        List<Lead> existingRecords = [SELECT Id, LeadSource FROM Lead];
        // write async code
        for(Lead record : existingRecords){
            record.LeadSource = 'Web';
        }
        update existingRecords;
    }
}
