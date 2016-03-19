//This trigger is written to update the account with reward points when an order is placed.Learnings:
//Remember to put account and rewards in a map and within the map first check if the account needs to be updated with points from 2
//orders. In that case, you'll need to have an if-else in the map as below
trigger OrderAccountUpdate_AU on Order__C (after update) {
	
	List<Product2> OrderProducts = new List<Product2>();
	List<Account> OrderAccounts = new List<Account>();
	List<id> OrdersThatHaveBeenUpdated = new List<Id>();
	Map<Id, Decimal> AccountsToUpdate = new Map<Id, Decimal>();
	
	for(Order__c o: trigger.new){
		if (o.Status__c == 'Placed')
		{
			if(trigger.oldMap.containsKey(o.id))
			{
			if (Trigger.OldMap.get(o.id).Status__c != o.Status__c)
				{
					OrdersThatHaveBeenUpdated.add(o.id);
				}
			}
		}
		
	} //End of For
	
List<Order__c> getUpdatedOrders = [SELECT ID , PRODUCTNAME__R.ID , PRODUCTNAME__R.REWARDS__c , PARENTACCOUNT__R.ID , PARENTACCOUNT__R.Total_Points__c FROM ORDER__c WHERE ID IN:OrdersThatHaveBeenUpdated];

for(Order__c o1:getUpdatedOrders )
{
	OrderProducts.add(o1.productname__r);
	OrderAccounts.add(o1.ParentAccount__r);
	if (AccountsToUpdate.containsKey(o1.ParentAccount__r.id)) {
		//add points together incase the map already has the account. Use this technique to check if the map already has the key
		AccountsToUpdate.put(o1.ParentAccount__r.id, AccountsToUpdate.get(o1.ParentAccount__r.id) + o1.productname__r.rewards__c);
	} else {
		AccountsToUpdate.put(o1.ParentAccount__r.id,o1.productname__r.rewards__c);	
	}
	
}

for(Account ao: OrderAccounts)
	{
		if(AccountsToUpdate.containskey(ao.id))
		{
			if (ao.Total_Points__c != null)
				ao.Total_Points__c = ao.Total_Points__c + AccountsToUpdate.get(ao.id);
		}
	}

update OrderAccounts;


}