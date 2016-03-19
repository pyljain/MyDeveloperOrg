({
	init : function(component, event, helper) {
        var action = component.get('c.getAccounts');
        // action.setParams('Id', myId);
        action.setCallback(this, function(response) {
            if (response.state == "SUCCESS") {
            	component.set('v.accounts', response.getReturnValue());   
            }
        });
        
        $A.enqueueAction(action);
	}
})