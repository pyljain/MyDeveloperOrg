public class Account360View {
    
    public static void getOpportunitiesByProductLine(ID AID )
    {
       // Set <Opportunity> accountOpportunities = [SELECT ID FROM OPPORTUNITY WHERE ACCOUNTID = :AID];
        set<opportunity> oIds = new set <opportunity> ([select id from opportunity where accountid = :aid]);
        List<AggregateResult> OpportunitiesByProductLines = [SELECT count(OpportunityId) opty, Product2.Family productLine FROM OpportunityLineItem where OpportunityId in : oIds group by product2.family ];
        Map<Integer,string> CountsByProductLine = new Map<Integer,string>();
        for (AggregateResult ag : OpportunitiesByProductLines)
        {
            CountsByProductLine.put((Integer)ag.get('opty'), (String)ag.get('productLine'));
            
        }
        
        System.debug('***************************' +CountsByProductLine);
    }

}