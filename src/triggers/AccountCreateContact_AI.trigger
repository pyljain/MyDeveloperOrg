//This triggers automates the creation of a contact upon creation of an account


trigger AccountCreateContact_AI on Account (after insert) {
    
    List<Contact> createcontact = new List<Contact>();
    List<Account> accountcreated = new List<Account>();
    if(trigger.new != null)
    {
     for(Account a: trigger.new)
        {
            accountcreated.add(a);
        }
    }
    
    for(Account acc: accountcreated)
    {
       Contact con = new Contact();
       
       //String[] splitAccountName = acc.Name.split('\\s');
       List<String> splitAccountName = acc.Name.split('\\s');
       con.FirstName = splitAccountName.get(1);
       con.LastName = splitAccountName.get(0);
       con.AccountId = acc.Id;
       System.debug('***********************' +con.LastName);
       con.Description = acc.Description;
       createcontact.add(con);          
    }
    insert createcontact;
}