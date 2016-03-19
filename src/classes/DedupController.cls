public class DedupController {

    public PageReference saveSelection() {
        return null;
    }


// Variables to store country and state selected by user
    public String objectSelected { get; set; }
    public String objectField {get; set;}  
    
    // Generates object dropdown from Dedup Objects Settings
    public List<SelectOption> getDedupObjectsSelectList() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- Select One --'));   
        
        // Find all the Dedup Objects in the custom setting
        Map<String, Dedup_Objects__c> DObjects = Dedup_Objects__c.getAll();
        
        // Sort them by name
        List<String> ObjectNames = new List<String>();
        ObjectNames.addAll(DObjects.keySet());
        ObjectNames.sort();
    
     // Create the Select Options.
        for (String ObjName : ObjectNames) {
            Dedup_Objects__c obj = DObjects.get(ObjName);
            options.add(new SelectOption(obj.Object_Type__c, obj.Object_Type__c));
        }
        return options;
    }
    
    // To generate the fields picklist based on the object selected by user.
    public List<SelectOption> getFieldsSelectList() {
        List<SelectOption> options = new List<SelectOption>();
        // Find all the fields we have in custom settings.
        Map<String, Dedup_Object_Fields__c> allfields = Dedup_Object_Fields__c.getAll();

        // Filter fields that belong to the selected country
        Map<String, Dedup_Object_Fields__c> fields = new Map<String, Dedup_Object_Fields__c>();
        for(Dedup_Object_Fields__c field: allfields.values()) {
            if (field.Object_Type_c__c == this.objectSelected) {
                fields.put(field.Field_Name__c, field);
            }
        }
        
        // Sort the states based on their names
        List<String> fieldNames = new List<String>();
        fieldNames.addAll(fields.keySet());
        fieldNames.sort();
        
        // Generate the Select Options based on the final sorted list
        for (String fName : fieldNames) {
            Dedup_Object_Fields__c field = fields.get(fName);
            options.add(new SelectOption(field.Field_Name__c, field.Field_Name__c));
        }
        
        // If no states are found, just say not required in the dropdown.
        if (options.size() > 0) {
            options.add(0, new SelectOption('', '-- Select One --'));
        } else {
            options.add(new SelectOption('', 'Not Required'));
        }
        return options;
    }
}