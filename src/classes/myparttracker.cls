public class myparttracker {

  private final Part_Tracker__c ptracker;
     public Part_Tracker__c pt{get;set;}
     public String UserString{get; set;}
     public List<Part_Tracker__c> pts {get; set;}

    public myparttracker(ApexPages.StandardController controller) {
     this.ptracker = (Part_Tracker__c)Controller.getRecord();

    }
    
    public PageReference commitAction() 
    {
       
       pt = [SELECT NAME FROM PART_TRACKER__C WHERE ID =:ApexPages.currentPage().getParameters().get('id')];
       pt.commited__c = 'Y';
       update pt; 
       return null;
    }

}