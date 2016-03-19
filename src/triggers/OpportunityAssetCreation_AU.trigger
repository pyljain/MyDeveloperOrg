/*This triggers fires upon setting an Opportunity's status to 'Closed Won'. It fetches the opportunity's account
and creates assets for the account based on the products associated with each opportunity
This Trigger has some new techniques that are used:
1. Use of PriceEntry object - the relationshop was not evident and workbench is a handy tool to figure out relationships
Please note that in a SOQL on an object, one can iterate through child relationships i.e. fetch values from lookups
etc that are related to the child. Got the product Id from priceentry while navigating over opty line items
from opty.

Also, used a map. Please remember that while using a map, always use an if-else structure to check whether the 
key already exisits, if it does then add/concatenate the value as needed and if the key does not exist then put 
a new value.
Also, a map can contain lists/maps etc.
You can create a dynamic list to iterate through the elements if needed . See "for (Id prodId: mapofaccountIdsandProducts.get(o.account.id))"
*/
trigger OpportunityAssetCreation_AU on Opportunity (after update) {
	
	//Get opportunity ids for which status has changed in a list
	List<Id> updatedopportunitieswithstatus = new List<Id>();
	
	
	for(opportunity o: trigger.new )
	{
		if(o.StageName == 'Closed Won')
		{
			if(trigger.oldMap.containskey(o.id))
				{
					if(trigger.oldMap.get(o.id).stagename != o.StageName)
					{
						updatedopportunitieswithstatus.add(o.id);
					}
				}
		}			
	}
	
	List<opportunity> opportunitieswithproducts = [select name, Account.Name, (select PricebookEntry.Product2Id from OpportunityLineItems) from opportunity where id in :updatedopportunitieswithstatus];
	
	
	Map <Id,List<Id>> mapofaccountIdsandProducts = new Map <Id, List<Id>>();
	for(opportunity o: opportunitieswithproducts)
	{	
		if(mapofaccountIdsandProducts.containskey(o.Account.id))
		{
			for(OpportunityLineItem oli: o.opportunitylineitems)
			{
				mapofaccountIdsandProducts.get(o.Account.id).add(oli.PricebookEntry.Product2Id);
			}   			
		}
		
		else
		{
			mapofaccountIdsandProducts.put(o.Account.id , new List<Id>());
			for(OpportunityLineItem oli: o.opportunitylineitems)
			{
				mapofaccountIdsandProducts.get(o.Account.id).add(oli.PricebookEntry.Product2Id);
			}
		}
	
	}
	
	
//	List<opportunity product> optyproductswithIds = [select id , product2.Id from opportunity product where opportunityid in :optyIds];
	List<asset> listofassetstobecreated = new List<asset>();
	for(opportunity o: opportunitieswithproducts)
	{
		if(mapofaccountIdsandProducts.containskey(o.account.id))
		{
			Asset a = new Asset();
			//Declared a dynamic list here and used the productids derived in the map to iterate over
			for (Id prodId: mapofaccountIdsandProducts.get(o.account.id)) {
				a.Product2Id = prodId;	
			}
			
			a.AccountId = o.Account.Id;
			a.ParentAccount__c = o.AccountId;
			a.Name = 'AssetCreatedByTriggerFor'+o.Account.Id;
			listofassetstobecreated.add(a);
		}
	
		
	}
	insert listofassetstobecreated; 	

}