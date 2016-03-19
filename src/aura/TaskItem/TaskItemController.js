({
	editTask : function(component, event, helper) {
        component.set('v.editMode', true);
	},
    saveTask : function(component, event, helper) {
        component.set('v.editMode', false);
        
        var task = component.get('v.task');
        task.Subject = component.find('editText').get('v.value');
        
		var action = component.get("c.updateTask");
        action.setParams({
            't': task 
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
        		$A.get("e.c:TaskCreatedEvent").fire();
            }
        });
        
        $A.enqueueAction(action);
	},
    delTask : function(component, event, helper) {
        var task = component.get('v.task');
        
        var action = component.get("c.deleteTask");
        action.setParams({
            't': task 
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
        		$A.get("e.c:TaskCreatedEvent").fire();
            }
        });
        
        $A.enqueueAction(action);
	}
})