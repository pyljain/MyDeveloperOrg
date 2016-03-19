({
	constructArray : function(component, event, helper) {
        var record = component.get('v.record');
        
        var rec = component.get('v.fields').map(function(field) {
        	return record[field];    
        });
        
        component.set('v.rec', rec);
	},
    
    editRecord : function(component, event, helper){
        
        if(event.source.get("v.label") == "Edit")
        {
            component.set('v.editMode', true);
        }
        else if (event.source.get("v.label") == "Save")
        {
            console.log("In the Save event of the child", component.get('v.rec'), component.get('v.record'))
            component.set('v.editMode', false);
            var recordlocal = component.get('v.record');        
            component.getEvent("query_editRecord").setParams({
                editRecord: recordlocal                       
            }).fire();
        }     
                  
    }
    
    

})