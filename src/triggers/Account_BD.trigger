//This trigger prevents deletion of accounts that have associated contacts
trigger Account_BD on Account (before delete) {
    
    // Naive Method
    /**
        for (Account acc: Trigger.Old) {
        	List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId = :acc];
			if (contacts.size() != 0) {
				acc.addError('Cannot Delete Account with Contact');
			}
        }
     */
	// 1. Collect
    Set<Id> accountIds = new Set<Id>();
    
    // The List of Account in Trigger.Old does not contain parent or child entities
    // A1 - 0
    // A2 - 2
    // A3 - 0
    // A4 - 5
    // Trigger.Old = [A1, A2, A3, A4]
    for (Account acc: Trigger.Old) {
        accountIds.add(acc.Id);
    }
    // After loop accountIds = [A1.Id, A2.Id, A3.Id, A4.Id]
    
    // 2. Query
    // Count() is not allowed in this query
    List<Account> accountsWithContact = [SELECT Id, (SELECT Id From Contacts) FROM Account WHERE Id IN :accountIds];
    // After query this list would contain
    // accountsWithContact = [A1(), A2(C1, C2), A3(), A4(C1, C2, C3, C4, C5)]
    
    Set<Id> accountIdsWhichHaveContacts = new Set<Id>();
    
    for (Account accnt: accountsWithContact) {
        // This is a filter to remove accounts which do not have contacts
        if (accnt.contacts.size() != 0) {
            accountIdsWhichHaveContacts.add(accnt.Id);
        }
    }
    // After loop accountIdsWhichHaveContacts = [A2.Id, A4.Id]
    
    
    // 3. Lookup and Update
    // Trigger.Old is still [A1, A2, A3, A4]
    for (Account acc: Trigger.Old) {
        // Check if the Account (in Trigger.Old) is present in the
        // filtered set
        if(accountIdsWhichHaveContacts.contains(acc.Id)) {
            acc.addError('Cannot Delete Contact Present');
        }
    }
}