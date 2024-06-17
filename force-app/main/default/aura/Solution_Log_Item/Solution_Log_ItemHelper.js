({
    changeStatusOrPriority : function(component,helper, status, priority) {
        var action = component.get('c.changeStatusOrPriorityLog');
        action.setParams({
            'status' : status,
            'priority' : priority,
            'recordId' : component.get("v.log").Id
        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === 'SUCCESS') {
                var result = response.getReturnValue();
                if(result!= null) {
                    if(component.get("v.recordType") == 'batch'){
                        result.Body__c = JSON.parse(result.Body__c);
                        if(result.Body__c != null && result.Body__c.batchInfoList!= null) {
                            result.Body__c.batchInfoList = JSON.parse(result.Body__c.batchInfoList);
                        }else{
                            result.Body__c.batchInfoList = [];
                        }
                    }
                    component.set("v.log", result);
                    helper.colorPriority(component);
                }
            } else {
                console.log("Error request! Response: " + state);
            }
        })
        $A.enqueueAction(action);
    },

    colorPriority : function(component) {
        var priorityVal = component.get('v.log').Priority__c;
        if(priorityVal == 'Low'){
            component.set('v.arrowClass', 'green');
        }else if(priorityVal == 'Medium'){
            component.set('v.arrowClass', 'orange');
        }else if(priorityVal == 'High'){
            component.set('v.arrowClass', 'red');
        }else {
            component.set('v.arrowClass', 'slds-hide');
        }
    },

    setVisibilityBatchInfoList  : function(btn, idLog) {
        var secId = 'bl'+ idLog;
        var componentClass = document.getElementById(secId).getAttribute("class");;
        if(componentClass == 'slds-hide'){
            document.getElementById(secId).setAttribute("class", "");
             btn.set('v.label', 'Hide List');
        }else{
            document.getElementById(secId).setAttribute("class", "slds-hide");
            btn.set('v.label', 'Show List');
        }
    },

    //INT-375
    setVisibilityBatchErrorList  : function(btn, idLog) {
        var secId = 'blr'+ idLog;
        var componentClass = document.getElementById(secId).getAttribute("class");;
        if(componentClass == 'slds-hide'){
            document.getElementById(secId).setAttribute("class", "");
             btn.set('v.label', 'Hide Errors');
        }else{
            document.getElementById(secId).setAttribute("class", "slds-hide");
            btn.set('v.label', 'Show Errors');
        }
    }
})