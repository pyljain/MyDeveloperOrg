({
	computeQuery : function(component, event, helper) {
        
        var q = event.getParam("queryString");
        var action = component.get("c.getresults");
        action.setParams({
     		 "userquery": q
  });
        action.setCallback(this, function(response){
	        var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.fields", helper.getFields(q));
                component.set("v.records", response.getReturnValue());
                console.log(response.getReturnValue());
            }
        });
     $A.enqueueAction(action);
		
	},
    
    makeedit : function(component, event, helper){
        
        console.log("In Main - event called");
        var rec = event.getParam("editRecord");
        console.log(rec);
        var action = component.get("c.updaterecord");
        action.setParams({
     		 "rec": rec
  });
        action.setCallback(this, function(response){
	        var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Successfully Updated");
            }
        });
     $A.enqueueAction(action);
        
        
    }
    
})