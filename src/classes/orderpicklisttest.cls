public class orderpicklisttest {

 public final Order__c currentOrder;
 public String statusstring{get; set;}
 public String statusdepstring{get; set;}
 public final List_of_Values__c LOV;
 public string OrderId{get;set;}
 public String currentOrderStatus {get; set;}

    public orderpicklisttest(ApexPages.StandardController controller) {
        currentOrder = (Order__c)controller.getRecord();
        currentOrderStatus  = currentorder.StatusFromObject__c;
         OrderId = System.currentPageReference().getParameters().get('id');
    }
    
  
     public List<SelectOption> getItemsList() {            
            List<SelectOption> options = new List<SelectOption>(); 
            List<order__c> ord = [SELECT StatusFromObject__c from order__c where id = :OrderId];
            List<List_of_Values__c> listofvalues = [SELECT SubStatusLOV__c from List_of_Values__c where StatusLOV__c = :currentOrderStatus];
            
            
           
            for(List_of_Values__c o: listofvalues)
            {
                options.add(new SelectOption(o.SubStatusLOV__c , o.SubStatusLOV__c));
            }
            return options;
            
        }
    
 
}