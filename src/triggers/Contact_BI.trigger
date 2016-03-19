//This trigger is to stamp the account's email(description) on a contact being inserted into Salesforce.Use a map to hold the 
//account Ids and the account object. Then iterate through the trigger items to lookup and update.


trigger Contact_BI on Contact (before insert) {
	
	List<Id> accountIds = new List<Id>(); //To hold the parent Account Ids of the newly created contacts
	
	for (Contact c: Trigger.new) {
		if(c.AccountId != null) {
			accountIds.add(c.AccountId); //Store the Account Ids in the list that was instantiated
		}
	}
	
	List<Account> accounts = [SELECT DESCRIPTION FROM ACCOUNT WHERE ID IN :accountIds]; //Get all the accounts in a list
	Map<Id, Account> accountMap = new Map<Id, Account>(); //Create a map with Ids and Accounts - this acts as a lookup table
	
	for (Account a: accounts) {
		accountMap.put(a.id, a); //Store the accounts from the list in a map
	}
	
	for (Contact c: Trigger.New) {
		if (c.AccountId != null) {
			// Look up Account Description
			if (accountMap.containsKey(c.AccountId)) { // Lookup the contact's account id against the id in the map
				c.Email = accountMap.get(c.AccountId).Description;
			}
		}
	}
}