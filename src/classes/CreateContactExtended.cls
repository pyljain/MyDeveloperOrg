public class CreateContactExtended {

 public String ContactName{get; set;}
 public String Gender{get; set;}
 public String Account{get; set;}
 public Boolean Active{get; set;}
 public String eMail{get; set;}
 public Integer phone{get;set;}
 public Contact con{get;set;}
 
 public CreateContactExtended()
 {
 
 }
 
 public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Male','Male')); 
        options.add(new SelectOption('Female','Female')); 
        return options; 
    }

public List<SelectOption> getItemsList() {            
            List<SelectOption> options = new List<SelectOption>(); 
            List<Account> acc = [SELECT NAME from ACCOUNT];
            for(Account a: acc)
            {
                options.add(new SelectOption(a.name , a.name));
            }
            return options;
        }
        
        public PageReference save()
     {
      
         Contact a = new Contact();               
         a.lastname = ContactName;
         insert a;
         return null;
     }

}