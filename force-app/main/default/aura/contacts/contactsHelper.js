({
   	COLUMNS: [
        { 
            label: 'Contact Full Name', 
            fieldName: 'Name',
            type: 'String',
        },
        { 
            label: 'Account', 
            fieldName: 'AccountName',
            type: 'String',
        },
        { 
            label: 'Email', 
            fieldName: 'Email', 
            type: 'email',
        },
        { 
            label: 'Birthdate', 
            fieldName: 'Birthdate',
            type: 'date',
        },
    ],

	fetchContacts: function(component, event, helper) {
        component.set('v.columns', this.COLUMNS);
        
        let action = component.get("c.retrieveContacts");
        action.setCallback(this, function(response) {
        	if (response.getState() === "SUCCESS") {
            	let allRecords = response.getReturnValue();
 				allRecords.forEach((e)=>{
    				if (e.Account) {
    					e.AccountName = e.Account.Name;
					}
				});
            	component.set("v.allContacts", allRecords);
        		this.paginate(component);
        	}
        });
        $A.enqueueAction(action);
	},
        
    paginate: function(component, event, helper) {
        const PAGE_SIZE = 5;
        
        let allRecords = component.get("v.allContacts");
        let pageNumber = component.get("v.pageNumber");
        
        let pageRecords = allRecords.slice((pageNumber-1)*PAGE_SIZE, pageNumber*PAGE_SIZE);
        let lastPageNumber = Math.ceil(allRecords.length/PAGE_SIZE);
		
        component.set("v.currentPageContacts", pageRecords);
        component.set("v.maxPageNumber", lastPageNumber);
    },
})