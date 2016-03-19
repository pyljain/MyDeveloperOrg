global class UpdateContacts implements Database.Batchable<sObject>{
	
	global String scope;
	global String email;
//  global String field = 'Description';
	global string value = 'Please update phone number for this contact';
	public list<contact> contactsToUpdate;
	
	global UpdateContacts(String q)
	{
		scope = q;
	}
	
	global database.Querylocator start(Database.BatchableContext BC)
	{
		//scope = 'SELECT description , email FROM Contact WHERE Phone = null';
		return Database.getQueryLocator(scope);
		
	}

	global void execute(Database.BatchableContext BC, List<sObject> scope)	
	{
		list<contact> contactsToUpdate = new list<contact>();
		System.debug('*****In Execute************');
		
		for(sObject s: scope)
		{
			
			Contact con = (Contact)s;
			con.Description = value;
			contactsToUpdate.add(con);
			
		}
		
	update contactsToUpdate;
	System.debug(contactsToUpdate.size());
	}

	global void finish(Database.BatchableContext BC)
	{	
		String Body = 'This email is to request you to please update your contact information .Thanks';
        String[] toAddress = new string[]{};
		if (contactsToUpdate != null){
			for(Contact a:contactsToUpdate)
			{
				if(a.email != null && a.email != '')
                {
                    toAddress = new String[]{a.Email};
                    System.debug('************Inside for loop' +toAddress);
                }
				
				
			}
			
				Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage() ;
				mail.setToAddresses(toAddress);
				mail.setSubject('Please update details');
				mail.setHtmlBody('Hi' 	
				
				+body+ 
				
				'Thanks');
				
				Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		}
	}
}