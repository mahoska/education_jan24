({
    getDataFromController : function(component, helper) {
        helper.toggleSpinner(component);
        var recordTypeFlag = component.get("v.recordTypeFlag");

        var action = component.get("c.getLogsData");
        action.setParams({
             typeLog : recordTypeFlag,
             status : component.get("v.status"),
             priority : component.get("v.priority"),
             timeLine : component.get("v.timeLine"),
             startDate : component.get("v.startDate"),
             stopDate : component.get("v.stopDate")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            helper.toggleSpinner(component);
            if(state == "SUCCESS"){
                var respData =  response.getReturnValue();
                if(respData.length != 0){
                    if(recordTypeFlag == 'batch'){
                        respData.forEach(function(element){
                            element.Body__c = JSON.parse(element.Body__c);
                             if(element.Body__c != null && element.Body__c.batchInfoList!= null) {
                                 element.Body__c.batchInfoList = JSON.parse(element.Body__c.batchInfoList);
                             }else{
                                 element.Body__c.batchInfoList = [];
                             }

                             // add update error
                             if(element.Body__c != null && element.Body__c.batchErrorResult!= null) {

                                  element.Body__c.batchErrorResult = JSON.parse(element.Body__c.batchErrorResult);

                              }else{

                                  element.Body__c.batchErrorResult = [];

                              }
                        });
                    }
                    component.set("v.isShow", true);
                }else{
                    component.set("v.isShow", false);
                }
                component.set("v.logsData", respData);
            }else if(state == "ERROR"){
                component.set("v.isShow", false);
            }
        });
        $A.enqueueAction(action);
    },

    checkDates : function(component) {
        var startDate = component.get("v.startDate");
        var stopDate = component.get("v.stopDate");
        var now = new Date();
        var nowParse = Date.parse(now);
        var startParse = Date.parse(startDate);
        var stopParse = Date.parse(stopDate);
        if(startParse > nowParse || stopParse > nowParse){
            component.set("v.showErrorDateDuration", true);
            component.set("v.errorMessageDateDuration", "You have indicated a date that has not yet come.");
            return false;
        }else if(startDate > stopDate){
            component.set("v.showErrorDateDuration", true);
            component.set("v.errorMessageDateDuration", "The first date must be grater than second date.");
            return false;
        }else if(startDate == '' || stopDate == ''){
            component.set("v.showErrorDateDuration", true);
            component.set("v.errorMessageDateDuration", "To apply the filter, you must specify two dates.");
            return false;
        }else {
            component.set("v.showErrorDateDuration", false);
            component.set("v.errorMessageDateDuration", "");
            return true;
        }
    },

    toggleSpinner : function(component) {
        var componentClass = component.find('spinner').get('v.class');
        if(componentClass == 'slds-hide'){
            component.find('spinner').set('v.class','')
        }else{
            component.find('spinner').set('v.class','slds-hide')
        }
    }
})