({
	doInit: function(component, event, helper) {
        var action = component.get("c.getAccounts");
        action.setCallback(this, function(result) {
            var records = result.getReturnValue();
            component.set("v.allAccounts", records);
            component.set("v.maxPage", Math.ceil(records.length/10));
            helper.sortBy(component, "Name");
        });
        $A.enqueueAction(action);
	},
    sortByName: function(component, event, helper) {
        helper.sortBy(component, "Name");
    },
    sortByIndustry: function(component, event, helper) {
        helper.sortBy(component, "Industry");
    },
    sortByAnnualRevenue: function(component, event, helper) {
        helper.sortBy(component, "AnnualRevenue");
    },
    renderPage: function(component, event, helper) {
        helper.renderPage(component);
    },
})