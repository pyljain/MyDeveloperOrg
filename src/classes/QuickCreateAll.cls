public class QuickCreateAll {

     public String AccountString{get; set;}
     public String ContactString{get; set;}
     public String OrderString{get; set;}
     public Account acc{get;set;}
     public List<Account> accounts {get; set;}
     
     public QuickCreateAll ()
     {
     
     }
     
     public PageReference save()
     {
      
         Account a = new Account();               
         a.name = AccountString;
         insert a;
         return null;
     }
     
      public PageReference saveContact()
     {
      
         Contact ca = new Contact();               
         ca.lastname = ContactString;
         insert ca;
         return null;
     }
     
     public PageReference saveOrder()
     {
      
         Order__c o = new Order__c();               
         o.name = OrderString;
         insert o;
         return null;
     }
     
     
     
}