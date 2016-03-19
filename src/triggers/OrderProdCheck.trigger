//This trigger will fire upon order creation or update if the product associated with the order is out of stock.



trigger OrderProdCheck on Order__c (after insert, before update) {
	
	//Check whether it is insert or update
	Set<Id> OrdersCreatedOrUpdated = new Set<Id>();
	List<Product2> productstocheck = new List<Product2>();
	Map<Id,Decimal> Ordersandstocklevel = new Map<Id, Decimal>();
	Set<Id> displayerrorfortheseorders = new Set<Id>();
	//Set<Id> OrdersUpdated = new Set<Id>();
	
	
	if(trigger.isAfter)
	{
		for(Order__c o: trigger.new)
		{
			OrdersCreatedOrUpdated.add(o.id); //Is this because the id is not available yet in the trigger as it is before?
		}
		System.debug('++++++++++++in the insert trigger');
		System.debug(OrdersCreatedOrUpdated);  
	}
	
	else  if(trigger.IsUpdate)
	{
		for(Order__c o: trigger.new)
		{
			if(trigger.oldMap.containsKey(o.id))
			{
				if(Trigger.OldMap.get(o.id).productname__c != o.productname__c)
				{
					OrdersCreatedOrUpdated.add(o.id);
				}
			}
		}
	}
	List<Order__c> orderswithProducts = [SELECT Id, ProductName__r.Id, ProductName__r.stocklevel__c FROM Order__c WHERE ID IN :OrdersCreatedOrUpdated];
		for(Order__c o: orderswithProducts)	
		{
			Ordersandstocklevel.put(o.id , o.ProductName__r.stocklevel__c);
		}
		
		for (Order__c o1: trigger.new)
		{
			if(Ordersandstocklevel.containskey(o1.id))
			{
				if(Ordersandstocklevel.get(o1.id)<= 0 || Ordersandstocklevel.get(o1.id)== null)
				{
					//displayerrorfortheseorders.add(o1.id);
					o1.adderror('Cannot create an order with this product as the product is out of stock');
				}
			}
		}
		
		/*for(Order__c c: trigger.new)	
   		{
   			if(displayerrorfortheseorders.contains(c.id))
   			{
   				c.adderror('Cannot create an order with this product as the product is out of stock');
   			}
  		 }*/
		
		
	
	//If Insert , then collect the order ids in a list
	//Get the products and check for level
	
	
	//Map orders where product levels are 0 and collect 
	
	
	//Lookup in new trigger and throw and error if the orders are associated to products not in stock
	
	//Create an else loop to compare old and new trigger products and their corresponding levels

}