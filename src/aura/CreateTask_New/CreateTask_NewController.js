({
	createTaskClientController : function(component, event, helper) {
        var TaskName = component.find("TaskId");
        var action = component.get("c.createTask");
        action.setParams({
             taskName : TaskName.get("v.value")
        });      
       
        action.setCallback(this, function(response){
        var state = response.getState();
        if (state === "SUCCESS") {
            console.log("Task Created, " +response.getReturnValue());
            
        }
    });
    $A.enqueueAction(action);
	$A.get("e.c:TaskCreatedEvent").setParams({
            text: "Y"
       }).fire();


	}
})