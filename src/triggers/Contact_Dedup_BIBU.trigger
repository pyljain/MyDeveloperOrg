trigger Contact_Dedup_BIBU on Contact (before insert, before update) {
	
	/*Set<ID> ids = Trigger.newMap.keySet();
	public String query;
	for(Contact contactToCheck: trigger.new)
	{
			
		//List<contact> ContactsWithBirthDates = [select id from contact where id in :ids and birthdate != null];
		List<contact> ContactsWithBirthDates = new list<contact>();
		//Get Custom Setting Values		
		Dedup_Object_Fields__c dedupList = Dedup_Object_Fields__c.getInstance('Contact Field 2');
		String FieldName = dedupList.Field_Name__c;
		String objectName = dedupList.Object_Type_c__c;
		
		query = 'select Id , lastname ,'+ FieldName + ' FROM contact where Id in :ids AND ' + FieldName + '!=null';
		ContactsWithBirthDates = Database.query(query);
				
		for(Contact ConToCheck : ContactsWithBirthDates)
		{
			List<Contact> dupes = [select id from contact where lastname = :ConToCheck.LastName and birthdate = :ConToCheck.birthdate];
			
			if(dupes.size() > 0)
			{
				String errorMessage = 'Duplicate Contact Found ';
				errorMessage += ' Record ID is ' +dupes[0].Id;
				contactToCheck.addError(errorMessage);
			}
		}
		
		
	}*/

}