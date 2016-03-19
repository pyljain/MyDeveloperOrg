// This trigger updates a numeric field on the account with the total number of contacts associated with the account upon contact
//creation or deletion
trigger Contact_ADAI on Contact (after insert , after delete) {
    //Collect
   if(trigger.new != null)
   {
    Set<Id> contactIds = new Set<Id>();
    for(Contact con: trigger.new)
    {
        contactIds.add(con.Id);
    }
    
    
    //Query
    List<Contact> ContactswithAccount = [SELECT ID , ACCOUNTID FROM CONTACT WHERE ID IN :contactIds];
    Set<Id> accountIds = new Set<Id>();
    for(Contact c: ContactswithAccount)
    {
        System.debug('++++++++++++Storing the Account Ids in a Set - for 1'); 
        accountIds.add(c.AccountId);
    }
    System.debug('++++++++++++Outside for 1');
    
    //Lookup and update
	List<Account> AccountstoUpdate = [SELECT NAME , DESCRIPTION , (select name from contacts)FROM ACCOUNT WHERE ID IN :accountIds];
    for(Account aupdate: AccountstoUpdate)
    {
        integer a = aupdate.contacts.size();
        aupdate.NumberofLocations__c = a;
        System.debug('++++++++++++Updating the account with count of contacts - for 2');
    }
    
    update AccountstoUpdate;
     System.debug('++++++++++++Update Complete'); 
   } //End of If
    
    else if (trigger.old != null)
    {
        Set<Id> AccountIdsforContacts = new Set<Id>();
        for(Contact c: trigger.old)
        {
            AccountIdsforContacts.add(c.AccountId);
        }
        
        List<Account>AccountstoUpdate = [SELECT NAME,(SELECT NAME FROM CONTACTS) FROM ACCOUNT WHERE ID IN:AccountIdsforContacts];
        for(Account iterator: AccountstoUpdate)
        {
            integer countContacts = iterator.contacts.size();
            iterator.NumberofLocations__c = countContacts;
        }
        update AccountstoUpdate;
    } //End of Else If
}