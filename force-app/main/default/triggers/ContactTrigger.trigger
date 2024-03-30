/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-30-2024
 * @last modified by  : Hanna Makhovska
**/
trigger ContactTrigger on Contact (before insert, after insert, before update, after update, before delete, after delete, after undelete) {
    switch on  Trigger.operationType {
        when BEFORE_INSERT {

        }
        when AFTER_INSERT {
            ContactTriggerHandler.checkActiveContact(Trigger.new);
        }
        when BEFORE_UPDATE{
            
        }
        when AFTER_UPDATE{
            ContactTriggerHandler.afterUpdateContact(Trigger.new, Trigger.oldMap);
        }
        when BEFORE_DELETE{
            
        }
        when AFTER_DELETE{
            ContactTriggerHandler.checkActiveContact(Trigger.old);
        }
        when AFTER_UNDELETE{
            ContactTriggerHandler.checkActiveContact(Trigger.new);
        }
    }
}
            
       