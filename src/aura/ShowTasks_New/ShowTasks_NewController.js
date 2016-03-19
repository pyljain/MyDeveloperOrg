({
	getTasksClientController : function(component, event, helper) {
		
        var action = component.get("c.getTasks");
        action.setCallback(this, function(response){
        var state = response.getState();
        if (state === "SUCCESS") {
            component.set("v.tasks" , response.getReturnValue());
            console.log("List Retrieved, " +response.getReturnValue());
            
        }
    });
    $A.enqueueAction(action);
	}
    
 /*   var output =  $A.get("c:TaskCreatedEvent").getParam("text");
	if(output == "Y")
    {
    	//$A.enqueueAction(action);
	}*/
})