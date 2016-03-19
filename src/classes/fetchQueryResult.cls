public class fetchQueryResult {

    @AuraEnabled
    public static List<SObject> getresults(String userquery) {
       
        List<SObject> results = new list<SObject>();
        String queryinput = userquery;
        
        results = Database.query(queryinput);
        return results;        
        
    }
    
    @AuraEnabled
    public static List<String> getFields(String userquery) {
        
        List<String> tempResult;
        List<String> fieldset = new List<String>();
        
        Pattern MyPattern = Pattern.compile('SELECT(.+)FROM.+');
        Matcher MyMatcher = MyPattern.matcher(userquery.toUpperCase());
        
        if (MyMatcher.matches()) {
            tempResult = MyMatcher.group(1).split(',');
            
            for (String s : tempResult) {
                fieldset.add(s.trim());
            }
        }
        
        return fieldset;
    }
    
    @AuraEnabled
    public static void updaterecord(SObject rec){
        update rec;
    }

}