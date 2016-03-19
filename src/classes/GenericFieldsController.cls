public class GenericFieldsController {
    public List<String> fieldNames {get; set;}
    public List<String> fieldValues {get; set;}
    
    public String accountId {get; set;}
    
    public String query {get; set;}
    public List<sObject> results {get; set;}
    
    public GenericFieldsController() {
        
        fieldNames = new List<String>();
        
        String querySelectClause = '';
        
        accountId = ApexPages.currentPage().getParameters().get('Id');
        
        Map<String, Schema.SobjectField> fields = Schema.SObjectType.Nominations__c.fields.getMap();
        for (String s : fields.keySet()) {
            fieldNames.add(s);
            if (querySelectClause == '') {
                querySelectClause += s;
            } else {
                querySelectClause += ',' + s;
            }
        }
        
        // Create Select statement
        query =  'SELECT ' + querySelectClause;
               query += ' FROM Nominations__c';
               query += ' WHERE Id = :accountId';
               
        results = Database.query(query); 
    }
}