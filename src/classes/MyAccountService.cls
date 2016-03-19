public class MyAccountService {
	
    @AuraEnabled
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }
}