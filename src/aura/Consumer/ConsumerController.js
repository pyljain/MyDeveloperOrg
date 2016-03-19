({
	inputChanged : function(component, event, helper) {
        // component.getElement() gets the top level element
		component.getElement().innerText = event.getParam('message');
	}
})