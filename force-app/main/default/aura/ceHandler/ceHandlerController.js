({  
    handleComponentEvent : function(cmp, event) {   
        var numEventsHandled = parseInt(cmp.get("v.numComponentEvents")) + 1;
        cmp.set("v.numComponentEvents", numEventsHandled);  
    }   
})