@istest
public class AccountTrackChangesTest {
    
    public static testmethod void tstAccountTracking()
    {
        account tstAccount = new account(Name = 'Script Test Account');
        insert tstAccount;
        Test.startTest();
        List<AccountTracking__c> checkForEntry = [SELECT NAME FROM AccountTracking__c WHERE ACCOUNT_NAME__c = 'Script Test Account'];
        System.assertEquals(0, checkForEntry.size());      
        
       // Retrieve the account
       tstAccount = [SELECT ID, NAME , OWNER.ID , OWNER.NAME FROM account WHERE ID = :tstAccount.Id];
       tstAccount.Description = 'This description is updated by the test class';
       update tstAccount;
       
       test.stopTest();
       
       List<AccountTracking__c> checkForEntry1 = [SELECT NAME, Account_Name__c FROM AccountTracking__c WHERE ACCOUNT_NAME__c = 'Script Test Account'];
       System.assertEquals(1, checkForEntry1.size());
       System.assertEquals('Script Test Account', checkForEntry1.get(0).account_name__c); 
    }

}