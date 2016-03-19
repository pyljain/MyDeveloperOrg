public class ShowContactChildren {

    public final Account acct {get; set;}
    public boolean checked {get; set;}
    public boolean selectedSize {get; set;}
    public String something {get; set;}
    public List<contactWrapper> ContactList {get; set;}
    public List<contact> allAccountContacts = new List<contact>();
    public List<contact> selectedContact {get; set;}
    List<case> CaseForContact = new List<case>();
     
    public ShowContactChildren(ApexPages.StandardController controller) {
        this.acct = (Account)Controller.getRecord();
        getcontactWrapper();
        selectedContact = new List<contact>();
     // selectedSize = false;
    }
    
/*    public ShowContactChildren()
    {
        allAccountContacts = acct.contacts;
        getcontactWrapper();
        selectedSize = false;
        
    } */
    
    //Create a Wrapper Class that holds contacts & a checkbox
     public class contactWrapper
    {
        public contact c{get; set;}
        public Boolean checked{get; set;}
        public contactWrapper(Contact con)
        {
            c = con;
            checked = false;
        }
    }
    
    //This list will hold all the account contacts 
    public List<contact> allAccountContacts() {
        return (List<contact>) acct.contacts;
    }
    
    //Add all the account's contacts into the wrapper
     public List<contactWrapper> getcontactWrapper()
    {
        ContactList = new List<contactWrapper>();
        
        for(Contact a : [SELECT Id, Name, Description, firstname, salutation, email FROM Contact WHERE AccountId = :acct.Id])
        {
            ContactList.add(new contactWrapper(a));
        }   
        return ContactList;
    }
    
    //Add the selected contact to this list and process for child records
    public PageReference getChildren() {     
       for(contactWrapper instanceWrapper : ContactList) {
           if(instanceWrapper.checked == true)
               selectedContact.add(instanceWrapper.c);                           
                           
             }
               
           if (selectedContact.size() != 0) {
                    selectedSize = true;
                } else {
                selectedSize = false;
                } 
            
             return null; 
       }
       
    public List<case> getCaseForContact()
    {
        List<case> CaseForContact = [SELECT CaseNumber,ContactId,CreatedDate,Description,Origin FROM Case where contactId IN :selectedContact];                   
        return CaseForContact;
    }
    


}