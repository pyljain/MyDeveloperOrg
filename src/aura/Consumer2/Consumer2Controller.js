({
	showButton : function(component, event, helper) {
        if (event.getParam('message') == 'Test') {
            component.getElement().style.display ='none';
        }
	}
})