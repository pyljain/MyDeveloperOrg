({
	calculate : function(component, event, helper) {
		
        var one = component.find("inputOne").get("v.value");
        var two = component.find("inputTwo").get("v.value");
        var three = component.find("inputThree").get("v.value");
        console.log("the difference is" , one);
               
        var diff = parseInt(one) + parseInt(two) - parseInt(three);
        console.log("the difference is" , diff);
        component.find("totalValue").set("v.value" , diff);
       
	}
})