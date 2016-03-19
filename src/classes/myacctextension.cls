public class myacctextension {
    
    private final Account acct;
     public String UserString{get; set;}
     public List<Account> accounts {get; set;}

    public myacctextension(ApexPages.StandardController controller) {
     this.acct = (Account)Controller.getRecord();

    }
  
    public PageReference submit() {
        System.debug(this.acct.name);
        return null;
    }
}