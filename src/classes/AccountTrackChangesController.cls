global class AccountTrackChangesController {
    
    @Future(callout=true)
    public static void createhistory(map<string, string> accountlist)
    {
        for(String a:accountlist.keySet())
        {
            AccountTracking__c at = new AccountTracking__c();
            at.Account_ID__c = a;
            at.Account_Name__c = accountlist.get(a);
            insert at;
        }
        
    }

}