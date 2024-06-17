({
    doInit : function(component, event, helper) {
        if(component.get("v.timeLine")!='' ||  !component.get("v.showErrorDateDuration")){
            helper.getDataFromController(component, helper);
        }
	},

    changePriority : function(component, event, helper) {
        helper.getDataFromController(component, helper);
    },

    changeStatus : function(component, event, helper) {
        helper.getDataFromController(component, helper);
    },

    changeTimeLine : function(component, event, helper) {
        if(component.get("v.toggleVal")) {
            helper.getDataFromController(component, helper);
        }
    },

    changeDuration : function(component, event, helper) {
        var isDatesValid = helper.checkDates(component);
        if(isDatesValid) {
            helper.getDataFromController(component, helper);
        }
    },

})