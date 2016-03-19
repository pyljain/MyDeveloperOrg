public class getAccountList {
    
    @AuraEnabled
    public static list<Account> getAccounts(){
        
        List<Account> allAccounts = [select name, BillingPostalCode from Account limit 25];
        return allAccounts;
    }  

}