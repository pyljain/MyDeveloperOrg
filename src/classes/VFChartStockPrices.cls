public class VFChartStockPrices {

   private final Account acct;
   
   public VFChartStockPrices(ApexPages.StandardController ctrl) {
       this.acct = (Account)ctrl.getRecord();
   }
   
       public List<PieWedgeData> getPieData() 
    {  
        List<PieWedgeData> data = new List<PieWedgeData>();
        List<Stock_Prices__c> memb = new List<Stock_Prices__c>();  
        
        memb = [SELECT Price__c, Month__c FROM Stock_Prices__c where price__c != null and month__c != null and account__c = :acct.id];
        for(Stock_Prices__c temp: memb)
        {           
            data.add(new PieWedgeData(temp.price__c,temp.month__c));
        }
        return data;  
    }  
    
    // Wrapper class  
    public class PieWedgeData 
    {  
        public String month{ get; set; }  
        public Decimal data { get; set; }  
        
        public PieWedgeData(Decimal data, String month) 
        {  
            this.month = month;  
            this.data = data;  
        }  
    }

}