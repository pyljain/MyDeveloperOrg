({
	changed : function(component, event, helper) {
		var appEvent = $A.get("e.c:MyInputTypedEvent");
        console.log(event.target.value);
        appEvent.setParams({ 
            "message" : event.target.value
        });
		appEvent.fire();
	}
})