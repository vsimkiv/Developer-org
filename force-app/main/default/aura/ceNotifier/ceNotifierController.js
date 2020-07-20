({
    fireComponentEvent : function(cmp, event) {
        
        var cmpEvent = cmp.getEvent("cmpEvent");
        cmpEvent.setParams({
            "message" : "A component event is recently fired."
        });
        
        cmpEvent.fire();
    },

})