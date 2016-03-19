public class newTaskController {
    
    @AuraEnabled
    public static Task createTask(String taskName) {
     
        Task t = new task();
        t.Description = 'Created through Lightning';
        t.Subject = taskName;
        t.WhoId = '0039000000qTacO';
        
        
        insert t;

        // Perform isAccessible() check here 
        return t;
    }
    
    @AuraEnabled
    public static list<Task> getTasks(){
        
        List<task> allTasks = [select description , subject , whoid from task where whoid = '0039000000qTacO'];
        return allTasks;
    }
    
    @AuraEnabled
    public static void updateTask(Task t){
        update t;
    }
    
    @AuraEnabled
    public static void deleteTask(Task t){
        delete t;
    }
    
}