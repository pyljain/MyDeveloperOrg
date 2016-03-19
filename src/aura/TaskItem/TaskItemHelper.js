({
	toggleHidden : function(component) {
		$A.util.toggleClass(component.find('editButton'), 'hidden');
		$A.util.toggleClass(component.find('saveButton'), 'hidden');
	}
})