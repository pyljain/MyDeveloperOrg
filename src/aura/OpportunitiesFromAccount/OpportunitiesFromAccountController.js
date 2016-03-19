({
	getOpportunities : function(component, event, helper) {
		var parentaccountid = event.getParam("accountIdentity");
        //component.set("v.myText", text);
        
        var action = component.get("c.getOpportunitiesforaccount");
        /*var searchInput = component.find("sample1");
        if(component.find("sample1").getElement() != null) {
       		 var qstring = component.find("sample1").getElement().value;
             console.log("String", qstring);
        }
        else {
            var qstring = '';
        }*/
        
        action.setParams({
            'parentacc': parentaccountid 
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.opportunities" , response.getReturnValue());

                var data = response.getReturnValue().map(function(element) {
                    return {
                        value: element.Probability,
                        label: element.Name
                        
                    };    
                });
                
                var el = component.find("chart").getElement();
   			    var ctx = el.getContext("2d");
                
                if (component.get("v.mychart")) {
                    component.get("v.mychart").destroy();
                }
                
                var myDoughnutChart = new Chart(ctx).Doughnut(data,{segmentStrokeColor : "#fff"});
                component.set("v.mychart", myDoughnutChart);
            }
        });
    	$A.enqueueAction(action);
	}
})