({
	weathercontroller : function(component, event, helper) {
        
        var accId = component.get('v.accountID');
        
        var action = component.get("c.getAccountWeather");
        action.setParams({
            'accountid': accId 
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var resultObject = JSON.parse(result);
                console.log(result);
                var tempmin = resultObject.main.temp_min;
                var tempmax = resultObject.main.temp_max;
                var Forecast = resultObject.weather[0].description;
                console.log(Forecast);
        		component.set("v.Forecast", Forecast);
                component.set("v.MinTemp", tempmin);
                component.set("v.MaxTemp", tempmax);
            }
        });
        
        $A.enqueueAction(action);
		
	}
})