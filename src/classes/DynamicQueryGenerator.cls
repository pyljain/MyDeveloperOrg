public class DynamicQueryGenerator {

    public List<SObject> results { get; set; }

    public String query {
    get; set; }
    
    public DynamicQueryGenerator() {
        query = '';
    }
    
    public PageReference run() {
        results = Database.query(query);
        return null;
    }


    public String getRun() {
        return null;
    }

    public List<String> getFields() {
        
        List<String> tempResult;
        List<String> result = new List<String>();
        
        Pattern MyPattern = Pattern.compile('SELECT(.+)FROM.+');
        Matcher MyMatcher = MyPattern.matcher(query.toUpperCase());
        
        if (MyMatcher.matches()) {
            tempResult = MyMatcher.group(1).split(',');
            
            for (String s : tempResult) {
                result.add(s.trim());
            }
        }
        
        return result;
    }
   
}