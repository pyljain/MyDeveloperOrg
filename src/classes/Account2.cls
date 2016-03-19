public class Account2
{
    public void getAccounts()
    {
        List<Account> recordset = [SELECT ID , NAME , TOUCHED__C FROM ACCOUNT];
        for (Account a:recordset)
        {
        	a.touched__c = true;
        }
        
        update recordset;
        
        
    }
//To get all the contacts tied to an account
public void ContactCount()
{
	List<Account> Accounts = [SELECT ID, NAME , (SELECT NAME FROM CONTACTS) FROM ACCOUNT];
	
	for(Account a2: Accounts)
	{
		a2.NumOfContacts__c = a2.Contacts.size();
	}
	 update Accounts;		
}
}