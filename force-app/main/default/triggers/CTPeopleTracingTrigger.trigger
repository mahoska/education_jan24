/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-30-2024
 * @last modified by  : Hanna Makhovska
**/
trigger CTPeopleTracingTrigger on People_Tracing__c (before insert) {
    switch on  Trigger.operationType {
        when BEFORE_INSERT{
            CTPeopleTracingTriggerHandler.beforeInsert(Trigger.new);
        }
    }
}