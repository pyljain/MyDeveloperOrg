({
	createQueryClientController : function(component, event, helper) {
        
        var messageEvent = component.getEvent("query_createQueryEvent");
        var userquery = component.find("QueryId").get("v.value");
        messageEvent.setParams({
            "queryString": userquery
        });
        messageEvent.fire();
	}
})