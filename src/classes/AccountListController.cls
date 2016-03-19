public class AccountListController {
    
    @AuraEnabled
    public static List<Account> getfilteredaccountlist(String queryAccounts)
    {
        String likestring ='\'%' + queryAccounts + '%\'';
        String querysoql = 'SELECT NAME FROM ACCOUNT WHERE NAME LIKE '+likestring ;
        List<Account> results = new list<Account>();
        results = Database.query(querysoql);
        return results;
    }
    
    @AuraEnabled
    public static List<Opportunity> getOpportunitiesforaccount(String parentacc)
    {
        List<Opportunity> oppsforaccount = [SELECT NAME, Probability FROM OPPORTUNITY WHERE ACCOUNTID = :parentacc];
        
        return oppsforaccount;
    }
    

}