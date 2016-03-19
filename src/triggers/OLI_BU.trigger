//This trigger is to prevent the deletion of order line items if the order status is placed. Note that while adding errors you need to
//use trigger.new and not trigger.old as trigger.new holds the altered state. This is true only for updates
//While adding errors for delete or insert you need to use trigger.old


trigger OLI_BU on Order_Lineitem__c (before update) {
	
	//Collect
	Set<Id> OLIParentIds = new Set<Id>();
    Set<Id> PlacedOrders = new Set<Id>();
	for(Order_Lineitem__c oli: trigger.old)
	{
		OLIParentIds.add(oli.ParentOrder__c);
	}
    System.debug('******************************' +OLIParentIds);
	
    List<Order__c> OrdersCollect = [select status__c from order__c where ID in:OLIParentIds];
    for(Order__c o: OrdersCollect)
        {
            if(o.Status__c == 'Placed')
            {
                PlacedOrders.add(o.id);
            }
        }
   for(Order_Lineitem__c oli: trigger.New)
   {
       if (PlacedOrders.contains(oli.ParentOrder__c))
       {
           oli.addError('Cannot update as the order has been placed');
       }
   }         
	

}