public class productcomparison {

    public product2 prd {get;set;}
    public String prod1{get; set;}
    public String prod2{get; set;}
   public list<product2> prods {get;set;}
   public string inputstring{get;set;}
  Set<string> records {get;set;}

    public productcomparison(ApexPages.StandardController controller) {
        prd = (product2)controller.getrecord();
        inputstring = ApexPages.currentPage().getParameters().get('prod12');
     //   List<Product2> prods = [select name , ProductCode , Description from product2 where name in :inputstring];
        
        
    }
    
    
    public List<SelectOption> getItemsList() {   
           // System.debug('*********************' +prod1);         
            List<SelectOption> options = new List<SelectOption>(); 
            List<product2> prd = [SELECT name from product2];           
            
           for(product2 o: prd)
            {
                options.add(new SelectOption(o.name , o.name));
            }
            
           
            return options;
            
        }
        
        public PageReference compare()
        {
        
             Set<String> records = new Set<String>{ prod1,prod2};  
             System.debug('*********************' +records);   
          /*  List<Product2> prods = [select name , ProductCode , Description from product2 where name in:records];
           return null;*/
           return new PageReference('https://c.ap1.visual.force.com/apex/ProductComparison?prod12=' +records);
        }
        
      
    
}