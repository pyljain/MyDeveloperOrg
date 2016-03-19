//This trigger checks to see if the OLIs for an order are submitted , if not it prevents the order status from getting 
//updated to 'Placed'

//When comparing something in a new trigger - use Ids to uniquely compare the presence of an object in a trigger to 
//display an error

trigger OrderStatus_BU on Order__c (before update) {
	
	List<Id> OrdersWithStatusChanged = new List<Id>();
	Set<Id> OrderswithUnsubmittedOLIs = new Set<Id>();
	
	for(Order__c o: trigger.new)
	{
		if(o.Status__c == 'Placed')
		{
			if(Trigger.oldMap.containskey(o.id))
			{
				if(Trigger.oldmap.get(o.id).status__c != o.status__c)
				{
					OrdersWithStatusChanged.add(o.id);
				}
			}
		}
	}
	
	List<order__c> OrderwithLineItems = [select status__c, (select status__c , parentorder__c from Order_Lineitems__r) from order__c where Id in: OrdersWithStatusChanged];
	
	for(Order__c o1: OrderwithLineItems)
	{
		if(o1.order_lineitems__r.size() != 0)
		{
			for(Order_Lineitem__c ol: o1.order_lineitems__r)
			{
				if(ol.Status__c != 'Submitted')
				{
					OrderswithUnsubmittedOLIs.add(ol.ParentOrder__c);
				}
			}
		}
	}

//Set<order__c>	ordertodisplayerrors = new Set<order__c>([select id, status__c from order__c where id in: OrderswithUnsubmittedOLIs]);
//This shows that you should not use a set which does not have Ids - as objects may not be uniquely identified if IDs are not used.
	for(order__c o2: trigger.new)
	{
		if(OrderswithUnsubmittedOLIs.contains(o2.Id))
		{
			o2.addError('Cannot change status as the Order has unsubmitted items');
		}
	}

}