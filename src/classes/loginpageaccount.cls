public class loginpageaccount {

public String password { get; set; }
public String accountName{get; set;}
public Account acc{get;set;}

public loginpageaccount() 
{
    
}

 public PageReference save()
     {
      
         List<account> searchaccount = [select id, name , password__c from account where name = :accountName];
         
         
             if(searchaccount.size() == 0)
             {
                 ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'This account does not exist'));
                 System.debug('*********************** Within first if' +accountname);
             }
             
             else 
             {
                for(account acc: searchaccount)
                {
                 if(acc.password__c != password)
                 {
                     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'The password is incorrect'));
                     System.debug('***********************Within first else if - password does not match' +accountname);
                 }
                 
                 else
                 {
                     return new PageReference('https://ap1.salesforce.com/' + acc.id);
                 }
               }
             }
           
         
         
        
         
         
         
         
        //  return new PageReference('https://ap1.salesforce.com/' + a.id);
        return null;  
     }
     
      public PageReference register()
      
      {
          Account a = new Account();
          a.name = accountname;
          a.password__c = password;
          
          insert a;
      
          return null;
      }
}