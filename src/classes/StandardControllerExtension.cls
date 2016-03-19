public class StandardControllerExtension {

    Account acct;
    public List<opportunity> childOpps= new List<Opportunity>(); 
    public StandardControllerExtension(ApexPages.StandardController std) {
    
        acct = (Account)std.getRecord();
    }
    
     public List<Opportunity> getChildOpps() {
        return [Select Name, Amount, StageName, CloseDate From Opportunity Where AccountId = :acct.Id and (IsWon = true or IsClosed = false)];   } 
        
     private void createTaskOnChildOpps()
     {
         List<task> tasksToInsert = new List<task>();
         for(Opportunity opp: [Select Name, Amount, StageName, isClosed,  CloseDate From Opportunity Where AccountId = :acct.Id])
         {
             
             if(!opp.IsClosed)
             {
                 tasksToInsert.add(
                     new task(WhatId = opp.id,ActivityDate = Date.today() + 3, Status = 'Not Started', Subject = 'Send follow-up email', Priority = 'Normal')
                     );         
             }      
                     
         }         
         
     
       //  if(tasksToInsert.size() > 0)
         insert tasksToInsert;
     }
     
     public PageReference save()
     {
         if(acct.rating == 'Hot')
             {
                createTaskOnChildOpps();
             }
             
         update acct;
         System.debug('********************' +childOpps.size());
         return new PageReference ('/' +acct.id);
         
     
     }
 }