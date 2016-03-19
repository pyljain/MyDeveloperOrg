({
	getDistance : function(component, event, helper) {
        
      /*  cmp.set("v.googleString", "https://www.youtube.com/embed/"+cmp.get("v.YTVVar.videoId") ) ;*/
        
        if(event.getParam("FromCode")) {
        	var from = event.getParam("FromCode");
        	component.set("v.fromaddress", from);
		}
        
        if(event.getParam("EndCode"))
        {
            var to = event.getParam("EndCode");
       		component.set("v.toaddress", to);
        }
        
        
        console.log("From code" +from);
        console.log("To code" +to);

      /*  component.set("v.googleString", "https://www.google.com/maps/embed/v1/directions?key=AIzaSyBe1qJ7xMRxPm6MhwyFS_tRKCInkphy-Sw&origin=CR0 2FD&destination=EC4") ;*/
        component.set("v.googleString", "https://www.google.com/maps/embed/v1/directions?key=AIzaSyBe1qJ7xMRxPm6MhwyFS_tRKCInkphy-Sw&origin="+component.get("v.fromaddress")+"&destination="+component.get("v.toaddress")) ;
        /* document.getElementById('googleframe').style.display ="block"; */
        
        		
	}
})