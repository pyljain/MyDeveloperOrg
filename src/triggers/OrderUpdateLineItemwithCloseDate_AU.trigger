trigger OrderUpdateLineItemwithCloseDate_AU on Order__c (after update) {
	
	//Get orders that have been updated with a Closed Date in a set
	Set<id> orderidstoconsider = new set<id>();
	List<Order_Lineitem__c> olitoupdate = new List<Order_LineItem__c>();
	for(order__c o: trigger.new)
	{
		if(o.Closed_Date__c != null)
		{
			if(trigger.oldMap.containskey(o.id))
			{
				if(trigger.oldmap.get(o.id).closed_date__c != o.Closed_Date__c)
				{
					orderidstoconsider.add(o.id);
				}
			}
			
		}
		
	}
	
	
	List<order__c> getOrderAndOrderLineitems = [select closed_date__c ,(select closed_date__c from Order_Lineitems__r) from order__c where id in:orderidstoconsider];
	for(order__c o1: getOrderAndOrderLineitems)
	{
		if(o1.order_lineitems__r.size() != 0)
		{
			for(Order_Lineitem__c oli: o1.order_lineitems__r)
			{
				oli.Closed_Date__c = o1.Closed_Date__c;
				olitoupdate.add(oli);
				
			}
		}
		
	}
	
	
	
update olitoupdate;

}