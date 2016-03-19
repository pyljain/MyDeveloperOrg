public class DashBoardController {

    public list<AggregateResult> aggregateOpps {
    
        get {
        
            if(aggregateOpps == null)
                {
                    aggregateOpps = new List<AggregateResult>();
                    
                        for(AggregateResult o : [SELECT OWNERID , SUM(AMOUNT) AMT , COUNT(NAME) CNT FROM OPPORTUNITY WHERE CLOSEDATE = THIS_YEAR AND ISWON = TRUE GROUP BY ROLLUP(OWNERID) ORDER BY SUM(AMOUNT) DESC])
                        {
                            if(o.get('OwnerId') != null && o.get('amt') != null && o.get('cnt') != null)
                                {
                                    aggregateOpps.add(o);
                                
                                }
                        
                        }
                
                }
                
             return aggregateOpps;
            
         }
         
         set;
    }
    
    public set<Id> ownerIds
    
        {
        
            get
                {
                
                    if(ownerIds ==null)
                    {
                        ownerIds = new set<id>();
                        
                        for(AggregateResult ar : aggregateOpps)
                            {
                                ownerIds.add(String.valueof(ar.get('ownerid')));                         
                            }
                    
                    }
                 
                 return ownerIds;
                 
                }
    
            set;
            
        }
        
        public map<id, user> salesusers 
        {
        
            get 
                {
            
                    if(salesusers ==null)
                        {
                            salesusers = new map<id, user>();
                            
                            for(User u : [SELECT smallPhotoUrl, NAME , ID FROM USER WHERE ID IN:ownerIds])
                            {
                                salesusers.put(u.id , u);
                            }
                        
                        }
            
                    return salesusers;
            
                }        
      
            set;      
        
        }
        
        public class leaderData {
        
            public string leaderName {get;set;}
            public string leaderPic {get;set;}
            public integer oppCount {get;set;}
            public double oppAmount {get;set;}
            
            public leaderData (string leaderName, string leaderPic , integer oppCount , double oppAmount)
            {
                this.leaderName = leaderName;
                this.leaderPic = leaderPic;
                this.oppCount  = oppCount ;
                this.oppAmount = oppAmount;             
            }
            
         }
         
         public list<leaderData> getLeaders()
         {
             List<leaderData> leaders = new List<leaderData>();
             
             if(aggregateOpps != null && salesusers != null)
             {
                 for(AggregateResult ar: aggregateOpps)
                 {
                        leaders.add(new leaderData(salesUsers.get(String.ValueOf(ar.get('OwnerId'))).Name, salesUsers.get(String.ValueOf(ar.get('OwnerId'))).SmallPhotoUrl, Integer.ValueOf(ar.get('cnt')), Double.ValueOf(ar.get('amt'))));
                 
                 }
                 
             
             }
         
             return leaders;
         }
         
}