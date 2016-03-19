({
	getAccsController : function(component, event, helper) {
        var action = component.get("c.getfilteredaccountlist");
        var searchInput = component.find("sample1");
        if(component.find("sample1").getElement() != null) {
       		 var qstring = component.find("sample1").getElement().value;
             console.log("String", qstring);
        }
        else {
            var qstring = '';
        }
        
        action.setParams({
            'queryAccounts': qstring 
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.accounts" , response.getReturnValue());
                console.log("Accounts Retrieved, " +response.getReturnValue());
                
            }
        });
    	$A.enqueueAction(action);
		
	},
    
    passAccountID : function(component, event, helper) {
       var idty = event.target.getAttribute("data-id");
        console.log("Clicked on", idty);
      //  var idty = event.source.get("v.value");
        $A.get("e.c:AccountSelectedEvent").setParams({
            accountIdentity: idty
       }).fire();
       console.log(idty);
    }

})