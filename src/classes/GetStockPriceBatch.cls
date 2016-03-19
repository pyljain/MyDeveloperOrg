global class GetStockPriceBatch implements Database.Batchable<sObject>,Database.AllowsCallouts {

    public String query = 'Select ID, Name , Stock_Code__c from Account where Stock_Code__c != null';
    Map<Id, Decimal> AccountStockPrices = new map<Id, Decimal>();
    List<Stock_Prices__c> HistoricalSPrices = new List<Stock_Prices__c>();
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
    	return Database.getQueryLocator(query);
 	}
    global void execute(Database.BatchableContext BC, List<Account> records)
    {
        wsCdyneCom.DelayedStockQuoteSoap WS = new wsCdyneCom.DelayedStockQuoteSoap();
        {
            for (Account a: records)
            {
                Decimal result = WS.GetQuickQuote(a.Stock_Code__c, '0');
                AccountStockPrices.put(a.Id, result);
            }
        }
        //for (Id AccountId : AccountStockPrices.keySet())
        for (Account a : records)
        {
        	if(AccountStockPrices.containsKey(a.Id))
            {
            Stock_Prices__c SP = new Stock_Prices__c();
            SP.Account__c = a.Id;
            Sp.Price__c = AccountStockPrices.get(a.Id);
            sp.Stock_Code__c = a.Stock_Code__c;
            HistoricalSPrices.add(SP);
            }
            
        }
        
        insert HistoricalSPrices;
    }
    global void finish(Database.BatchableContext BC)
    {
       //you can also do some after-the-job-finishes work here  
    }
    
    
}