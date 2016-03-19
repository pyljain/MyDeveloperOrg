public class ProductsPickerController {
    
    public final order__c controllerOrder {get; set;}
    public string searchproduct {get;set;} //This string holds the product search input
    public List<product2> records {get; set;}
    public string selectproduct {get; set;}
    
    
    public PageReference searchinmodel() {
        records = ProductPickerModel.getproducts(searchproduct); 
        return null;
    }
    
      public PageReference pickproduct() {
      if(controllerorder.id !=null)
      {
        controllerorder.ProductName__c = selectproduct;
        update controllerorder;
       }
        
        return null;
    }
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        for(product2 p: records)
        {
        options.add(new SelectOption(p.id,p.name)); 
       
        }
        return options; 
    }
    
    
    public ProductsPickerController(ApexPages.StandardController controller) {
     
     controllerOrder = (order__c)controller.getrecord();
     records = ProductPickerModel.getproducts(searchproduct);        //This is the method call to retrive the products
    
    }

}