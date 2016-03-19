public class ContactSearch {

 public String UserString{get; set;}
 public List<Account> accounts {get; set;}
    
   public ContactSearch()
{

}   
    public PageReference submit() {
        String str = '%' + UserString + '%'; 
        accounts = [SELECT Name FROM Account where NAME LIKE :str];
        return new PageReference('https://ap1.salesforce.com/0019000000odQqE');
    }

}