({  
    handleApplicationEvent : function(cmp, event) {  
        var numEventsHandled = parseInt(cmp.get("v.numApplicationEvents")) + 1;
        cmp.set("v.numApplicationEvents", numEventsHandled);
    }    
})