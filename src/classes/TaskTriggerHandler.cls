public class TaskTriggerHandler {
    
    public static void handleBeforeInsert(List<Task> newTasks) {}
    
    public static void handleBeforeUpdate(List<Task> oldTasks, List<Task> newTasks) {}
    
    public static void handleBeforeDelete(List<Task> oldTasks) {}
    
    public static void handleAfterInsert(List<Task> newTasks) {
        createTaskHistory(newTasks, 'Insert');
    }
    
    public static void handleAfterUpdate(List<Task> oldTasks, List<Task> newTasks) {
        createTaskHistory(newTasks, 'Update');
    }
    
    public static void handleAfterDelete(List<Task> oldTasks) {
        createTaskHistory(oldTasks, 'Delete');
    }
    
    public static void createTaskHistory(List<Task> tasks, String action) {
        
        List<task_history__c> insertTaskHistory = new List<task_history__c>();
        List<Task> tasksInserted = new List<Task>();
        if(tasks != null)
        {
            for(task t : tasks)
            {
                task_history__c insertTHist = new task_history__C();
                insertTHist.Action__c = action;
                insertTHist.Task_D__c = t.id;
                if (t.WhatId != null)
                {
                    Id myId = t.WhatId;
                    String sObjName = myId.getSObjectType().getDescribe().getName();
                    insertTHist.Parent_Name__c = sObjName;
                    insertTHist.Parent_ID__c = t.WhatId;
                }
                else if (t.WhoId != null)
                {
                    Id myId = t.WhoId;
                    String sObjName = myId.getSObjectType().getDescribe().getName();
                    insertTHist.Parent_Name__c = sObjName;
                    insertTHist.Parent_ID__c = t.WhoId;
                }
                
                insertTaskHistory.add(insertTHist) ;
            } //end for
            
            insert insertTaskHistory;
        } //end if
    }
}