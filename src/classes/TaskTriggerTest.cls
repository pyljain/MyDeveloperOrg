@istest
public class TaskTriggerTest {
    
    public static Opportunity createOpportunity() {
        Opportunity tstOpty = new Opportunity();
        tstOpty.Name = 'Test Task Trigger';
        tstOpty.CloseDate = Date.today();
        tstOpty.StageName = 'Prospecting';
        insert tstOpty;
        
        return tstOpty;
    }
    
    public static Task createTask(Id optyId) {
       	Task t = new task();
        t.WhatId = optyId;
        t.Subject = 'Created against a trigger test opportunity';
        insert t;
        
        return t;
    }
    
    public static testmethod void tstTaskHistoryCreation()
    {
        
        Opportunity o = createOpportunity();
        
        Test.startTest();
        List<Task_History__c> checkTaskHistory = [SELECT ID FROM TASK_HISTORY__C WHERE PARENT_ID__C = :o.Id];
        System.assertEquals(0, checkTaskHistory.size());
        
        Task t = createTask(o.Id);

        test.stopTest();
        List<Task_History__c> checkTaskHistoryafterTaskCreation = [SELECT ID FROM TASK_HISTORY__C WHERE PARENT_ID__C = :o.Id];
        System.assertEquals(1, checkTaskHistoryafterTaskCreation.size());        
        
    }
	
    public static testmethod void tstTaskHistoryUpdation()
    {
        
        Opportunity o = createOpportunity();
        
        Test.startTest();
        List<Task_History__c> checkTaskHistory = [SELECT ID FROM TASK_HISTORY__C WHERE PARENT_ID__C = :o.Id];
        System.assertEquals(0, checkTaskHistory.size());
        
        Task t = createTask(o.Id);
		t.Subject = 'Something';
        update t;
        
        test.stopTest();
        List<Task_History__c> checkTaskHistoryafterTaskCreation = [SELECT ID FROM TASK_HISTORY__C WHERE PARENT_ID__C = :o.Id];
        System.assertEquals(2, checkTaskHistoryafterTaskCreation.size());        
        
    }
    
    public static testmethod void tstTaskHistoryDeletion()
    {
        
        Opportunity o = createOpportunity();
        
        Test.startTest();
        List<Task_History__c> checkTaskHistory = [SELECT ID FROM TASK_HISTORY__C WHERE PARENT_ID__C = :o.Id];
        System.assertEquals(0, checkTaskHistory.size());
        
        Task t = createTask(o.Id);
		delete t;
        
        test.stopTest();
        List<Task_History__c> checkTaskHistoryafterTaskCreation = [SELECT ID FROM TASK_HISTORY__C WHERE PARENT_ID__C = :o.Id];
        System.assertEquals(2, checkTaskHistoryafterTaskCreation.size());        
        
    }
}