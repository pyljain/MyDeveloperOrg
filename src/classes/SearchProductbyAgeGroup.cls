public class SearchProductbyAgeGroup {

//private final Order__c od;
public Order__c od {get; set;}
public String UserString{get; set;}
public String agegroup{get; set;}


    public SearchProductbyAgeGroup(ApexPages.StandardController controller) {
        od = (order__c)controller.getrecord();
        agegroup = od.age_group__c;
    }


   public SearchProductbyAgeGroup ()
    {
        
        List<SelectOption> options = new List<SelectOption>(); 
        List<product2> prd = [SELECT name from product2 where age_group__c = :od.age_group__c];
          for(product2 o: prd)
            {
                options.add(new SelectOption(o.name , o.name));
            }
            
            System.debug('***Inside Constructor***' +agegroup);
         
    }
    
    public PageReference search() {
        //System.debug('***Entered Search***' +agegroup);
        od.age_group__c = agegroup;
        update od;
     //   return new PageReference('/ProductSearchByAgeGroup?id=a019000000BcfHx');
     return new PageReference('/');
       //return new PageReference('/ProductSearchByAgeGroup?id='+od.id);
    // return null;
    }
    public List<SelectOption> getItemsList() {   
            System.debug('*********************' +agegroup);         
            List<SelectOption> options = new List<SelectOption>(); 
           // List<product2> prd = [SELECT name from product2 where age_group__c = :agegroup];   
           List<product2> prd = [SELECT name from product2 where age_group__c = :od.age_group__c];           
            
           for(product2 o: prd)
            {
                options.add(new SelectOption(o.name , o.name));
            }
            
           
            return options;
            
        }
        
    
    public PageReference save() {
        System.debug('*********************Inthesavemethod' +agegroup);
        od.age_group__c = agegroup;
        update od;
        return new PageReference('/ProductSearchByAgeGroup?id=a019000000BcfHx');
    }
    
    public PageReference test() {
        return new PageReference('/');
    }
}