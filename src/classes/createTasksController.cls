public class createTasksController {
	@AuraEnabled    
    public static void insertTask(string message){
        Task t = new task();
        t.Subject = message;
   		t.WhoId = '0039000000qTacO';
    	insert t;
    }
   
}