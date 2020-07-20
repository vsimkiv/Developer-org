({
	fireComponentEvent : function(component, event, helper) {
		let cEvent = component.getEvent("componentEvent");
        cEvent.setParams({"message": "Component Event says that Vasia is Molodets"});
        cEvent.fire();
	}
})