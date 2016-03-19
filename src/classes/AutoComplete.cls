global class AutoComplete {

    public PageReference refreshListOfAccounts() {
        String queryStr = nameQuery + '%';
        similarAccounts = [SELECT Name FROM Account WHERE Name LIKE :queryStr];
        return null;
    }


    public String result { get; set; }
    public String nameQuery {get;set;}
    public List<Account> similarAccounts {get;set;}
    
    public AutoComplete() {}
    
    //Search
    public pagereference executeSearch()
    {
        
        return null;
    
    }
    
    @RemoteAction
    global static List<String> getAccounts(String searchString) {
        List<String> result = new List<String>();
        List<Account> similarAccounts = new List<Account>();
        String queryStr= searchString + '%';
        for (Account acc : [SELECT Name FROM Account WHERE Name LIKE :queryStr]) {
            result.add(acc.Name);
            similarAccounts.add(acc);
        }
        
        return result;
    }
}