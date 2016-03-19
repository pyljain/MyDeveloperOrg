({
	initialize : function(component, event, helper) {
        var left = 0;
        var speed = component.get('v.speed');
        
        setInterval(function() {
            left = left + 10;
            component.getElement().style.left = left + 'px';
        }, speed);
	}
})