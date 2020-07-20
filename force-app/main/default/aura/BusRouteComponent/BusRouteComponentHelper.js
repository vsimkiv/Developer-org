({
    fetchRoutesHelper : function(component) {
        component.set('v.columns', [{label: 'Bus Route Number', 
                                     fieldName: 'RouteNumber__c', 
                                     type: 'text'
                                    },
                                    {
                                        label: 'Number of Stops', 
                                        fieldName: 'TotalStops__c',
                                        type: 'number'
                                    },
                                    {
                                        label: 'Duration in Minutes', 
                                        fieldName: 'DurationInMinutes__c', 
                                        type: 'number'
                                    },            
                                   ]);
                                    
                                    var action = component.get("c.retrieveRoutes");
                                    
                                    action.setCallback(this, function(response){
                                    var state = response.getState();
                                    if (state === "SUCCESS") {
                                    component.set("v.routes", response.getReturnValue());
                                    }
                                    });
                                    $A.enqueueAction(action);
                                    }
                                    })