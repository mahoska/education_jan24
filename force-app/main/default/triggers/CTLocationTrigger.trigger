/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-30-2024
 * @last modified by  : Hanna Makhovska
**/
trigger CTLocationTrigger on Location__c (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    switch on  Trigger.operationType {
        when BEFORE_INSERT {
            CTLocationTriggerHandler.beforeInsert(Trigger.new);
        }
        when AFTER_INSERT {
           
        }
        when BEFORE_UPDATE{
            CTLocationTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
        }
        when AFTER_UPDATE{
            CTLocationTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
        when BEFORE_DELETE{
            
        }
        when AFTER_DELETE{
           
        }
        when AFTER_UNDELETE{
            
        }
    }
}