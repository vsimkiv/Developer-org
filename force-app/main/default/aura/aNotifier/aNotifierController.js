({
    fireApplicationEvent : function(cmp, event) { 
        var appEvent = $A.get("e.c:aEvent");
        appEvent.setParams({
            "message" : "An application event is recently fired." });
        
        appEvent.fire();
    }
})