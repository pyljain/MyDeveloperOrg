({
	getAccountsClientController : function(component, event, helper) {
        var action = component.get("c.getAccounts");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accounts" , response.getReturnValue());
                console.log("Accounts Retrieved, " +response.getReturnValue());
                
            }
        });
    	$A.enqueueAction(action);
	},
    handleSelection: function(component, event, helper) {
        console.log(event.getSource().getElement());
        var btn = event.getSource().getElement();
        var parenttd = btn.parentNode;
        var index = parseInt(parenttd.dataset.index);

        var postalCode = component.get('v.accounts')[index].BillingPostalCode;
        
        if (component.get("v.type") == "source") {
            $A.get("e.c:AddressPinCodeEvent_1").setParams({
            	FromCode: postalCode
       		}).fire();
        } else {
            $A.get("e.c:AddressPinCodeEvent_1").setParams({
            	EndCode: postalCode
       		}).fire();
            console.log(component.get("v.type"));
        }
    }
   

})