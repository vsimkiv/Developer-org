({
    fireApplicationEvent : function(component, event, helper) {
        var appEvent = $A.get("e.c:applicationEvent");
        appEvent.setParams({ "message" : "Application event confirms than Vasia is molodets" });
        appEvent.fire();
    }     
})