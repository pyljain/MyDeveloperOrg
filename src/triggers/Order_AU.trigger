//This trigger was written to update the product reward points on the Account record once the Order is placed. Its a good example of
//how trigger.old and trigger.new are used together and how once needs to compare values in the
//old and new trigger

trigger Order_AU on Order__c (after update) {
	
	// Collect a list of Products for Orders for which the status has been changed to Placed
	List<Product2> productsToUpdate = new List<Product2>();
	List<Id> listOfOrdersForWhichTheStatusHasBeenUpdated = new List<Id>();
	
	for (Order__c o: Trigger.New) {
		if (o.Status__c == 'Placed') {
			if (Trigger.OldMap.containsKey(o.Id)) {
				// Compare to previous status
				if (Trigger.OldMap.get(o.id).Status__c != o.Status__c) {
					listOfOrdersForWhichTheStatusHasBeenUpdated.add(o.Id);
					System.debug('++++++++++++++++In the productsToUpdate condition++++++++++++ ');
				}
			}	
		}
	}
	
	
	
	// Query For those Products
	List<Order__c> orders = [SELECT Id, ProductName__r.Id, ProductName__r.TotalCount__c FROM Order__c WHERE ID IN :listOfOrdersForWhichTheStatusHasBeenUpdated];
	
	for (Order__c o: orders) {
		productsToUpdate.add(o.ProductName__r);
	}
	
	System.debug(productsToUpdate);
	
	// Decrement count for each of the products and do a batch save
	for (Product2 prod: productsToUpdate) {
		prod.TotalCount__c = prod.TotalCount__c - 1; 
		System.debug('++++++++++++++++Decrementing Product Count++++++++++++ ');
	}
	
	update productsToUpdate;
	
/*
//Collect
Set<Id> getOrderIdsfromTriggerOld = new Set<id>(); //Collect Order Ids from Old Trigger
for(Order__c OrderTO: trigger.old)
{
    getOrderIdsfromTriggerOld.add(OrderTO.id);     
    
}
Set<Id> getOrderIdsfromTriggerNew = new Set<Id>(); //Collect Order Ids after update
for(Order__c OrderTN:trigger.new)
{
	getOrderIdsfromTriggerNew.add(OrderTN.id);
}

 //  Query
 List<Order__c> beforetriggervalue = [SELECT STATUS__C , PRODUCTname__r.ID FROM ORDER__c where ID in:getOrderIdsfromTriggerOld];
 List<Order__c> aftertriigervalue =  [SELECT STATUS__C , PRODUCTname__r.ID FROM ORDER__c where ID in:getOrderIdsfromTriggerNew];
 Set<Id> ProductIds = new Set<Id>();
 for(Order__c beforeorder:beforetriggervalue)
 {
 	for(Order__c afterupdate:aftertriigervalue)
 {
 	string beforestatus = afterupdate.status__c;
 	stringafter afterstatus = afterupdate.status__c;
 	
 }
 }
 }
  */  
}