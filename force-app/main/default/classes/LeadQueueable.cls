/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-31-2024
 * @last modified by  : Hanna Makhovska
**/
public class LeadQueueable implements Queueable{

    public void execute(QueueableContext context){
        List<Lead> existingRecords = [SELECT Id, LeadSource FROM Lead];
        // write async code
        for(Lead record : existingRecords){
            record.LeadSource = 'Web';
        }
        update existingRecords;

        // you can call another queueable class as well
    }
}
