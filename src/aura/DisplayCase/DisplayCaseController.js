({
	getCase : function(component, event, helper) {
        var action = component.get("c.getCaseFromId");
        action.setCallback(this , function(response){
            var state = response.getState();
            console.log(state);
            console.log(response.getReturnValue());
            if(state == "SUCCESS"){
                component.set("v.record" , response.getReturnValue());
            }            
        });
        
        $A.enqueueAction(action);
	}
})