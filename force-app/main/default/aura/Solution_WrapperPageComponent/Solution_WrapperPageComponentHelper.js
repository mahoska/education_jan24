({
    setTimeLine : function(component){
        var val = component.get("v.val");
        if(val==0){
            component.set("v.timeLine", "Today");
        }else if(val==50){
            component.set("v.timeLine", "Week");
        }else {
            component.set("v.timeLine", "Month");
        }
    },

    setTimeInterval : function(component) {
        var componentClass = document.getElementById("durationWrapper").getAttribute("class");

        if(componentClass == 'slds-hide'){
            document.getElementById("durationWrapper").setAttribute("class", "");
            document.getElementById("timeLineWrapper").setAttribute("class", "slds-hide");
            component.set("v.timeLine", "");
            component.set("v.startDate", "");
            component.set("v.stopDate", "");
        }else{
            document.getElementById("durationWrapper").setAttribute("class", "slds-hide");
            document.getElementById("timeLineWrapper").setAttribute("class", "");
            component.set("v.startDate", "");
            component.set("v.stopDate", "");
            component.set("v.timeLine", "Today");
            component.set("v.val", 0);
        }
    }
})