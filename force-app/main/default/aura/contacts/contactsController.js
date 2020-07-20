({
    init: function(component, event, helper) {
        helper.fetchContacts(component);
    },
    
    renderPage: function(component, event, helper) {
        helper.paginate(component);
    }, 
});