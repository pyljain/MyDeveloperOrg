//This trigger is wriiten to delete nominations when the Delete Nominations flag is checked on contacts 
//either manually or in bulk

trigger Contact_Nominees_Deletion_AU on Contact (after update) {
	
	Set<id> ContactIds = new set<Id>();    //To collect Contact Ids
	List<Nominations__c> NominationIds = new List<Nominations__c>();
	
	for(Contact c: trigger.new)
	{
		if(c.Delete_Nomination__c == true)
		{
			if(trigger.oldMap.containskey(c.id))
			{
				if(trigger.oldmap.get(c.id).Delete_Nomination__c == false)
				{
					ContactIds.add(c.id);
				}
			}
			
		}
		
	}
	
	List<Contact> ContactWithNominations = [select Delete_Nomination__c , (select id from nominations__r) from contact where id in: ContactIds];
	for (contact con: ContactWithNominations)
		{
			if(con.nominations__r.size() != 0)
			{
				for(Nominations__c nom: con.nominations__r)
				{
					NominationIds.add(nom);
				}
			}
			
			
		}
	if(NominationIds.size() > 0)
	{
		delete NominationIds;
	}
}