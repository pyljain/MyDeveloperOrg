({
	changed : function(component, event, helper) {
		var appEvent = $A.get("e.c:MyInputTypedEvent");
        appEvent.setParams({ 
            "message" : event.target.value
        });
		appEvent.fire();
	}
})