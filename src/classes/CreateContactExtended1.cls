public class CreateContactExtended1 {

    public PageReference goHome() {
        return null;
    }


 public String ContactName{get; set;}
 public String Gender{get; set;}
 public String AccName{get; set;}
 public Boolean Active{get; set;}
 public String eMail{get; set;}
 public String phone{get;set;}
 public Contact con{get;set;}
 
 public CreateContactExtended1()
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
                options.add(new SelectOption(a.ID , a.name));
            }
            return options;
        }
        
        public PageReference save()
     {
      
         Contact a = new Contact();               
         a.lastname = ContactName;
         a.email = eMail;
         a.HomePhone = phone;
         a.gender__c = Gender;
         System.debug('***********************' +accName);
         a.accountid = accName;
         
         insert a;
         
          return new PageReference('https://ap1.salesforce.com/' + a.id);
          //return new PageReference('https://c.ap1.visual.force.com/apex/CCContactPage1/?=a.id');
     }

}