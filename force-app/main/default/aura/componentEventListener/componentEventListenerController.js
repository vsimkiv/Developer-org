({
	handleComponentEvent : function(component, event, helper) {
		let message = event.getParam("message");
        component.set("v.messageFromComponentEvent", message);
	}
})