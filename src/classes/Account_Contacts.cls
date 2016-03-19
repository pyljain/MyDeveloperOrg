public class Account_Contacts {

    public final Account acct;
    String IdofAccount;
    public boolean updateMode {get; set;}
    
     public PageReference massUpdate() {
        if (updateMode == true) {
            updateMode = false;
        } else {
            updateMode = true;
        }
        return null;
    }
    
    public PageReference saveRecords() {
    
                             
        for(Contact c: acct.contacts)
        {
            update c;
        }
        
        updateMode = false;
        
        return null;
    }


    public Account_Contacts(ApexPages.StandardController controller) {
        this.acct = (Account)Controller.getRecord();
        
        
          // List<contact> accountContacts = [select name, Birthdate , Description from contact where accountId = :IdofAccount];
          //List<account> accountWithContacts = [select name , (select name, birthdate, description from contacts) from account];
    }
    
  
    

}