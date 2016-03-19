public class Awesome {
    public Decimal counter {get; set;}
    public List<Account> accounts {get; set;}
    
    public Awesome() {
        accounts = [SELECT Name FROM Account WHERE Name LIKE '%United%'];
    }
    
    public PageReference submit() {
        accounts = [SELECT Name FROM Account];
        return null;
    }
}