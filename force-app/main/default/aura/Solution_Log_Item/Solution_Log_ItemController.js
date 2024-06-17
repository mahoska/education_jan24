({
    doInit: function(component, event, helper) {
        helper.colorPriority(component);
    },

    changeStatus : function(component, event, helper) {
        var status = component.find('selectForStatus').get('v.value');
        helper.changeStatusOrPriority(component, helper, status, null);
	},

    changePriority : function(component, event, helper) {
        var priority = component.find('selectForPriority').get('v.value');
        helper.changeStatusOrPriority(component, helper, null, priority);
    },

    showBatchInfoList  : function(component, event, helper) {
        var btn = event.getSource();
        var idLog = btn.get('v.name');
        helper.setVisibilityBatchInfoList (btn, idLog);
    },

    //INT-375
     showBatchErrorsList  : function(component, event, helper) {
         var btn = event.getSource();
         var idLog = btn.get('v.name');
         helper.setVisibilityBatchErrorList (btn, idLog);
     }

})