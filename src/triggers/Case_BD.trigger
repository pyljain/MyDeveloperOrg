trigger Case_BD on Case (before delete) {
	
	//Trigger to check if a case has associated open/in progress tasks
	
	//Step 1 - Collect all cases with or without tasks
	List<Case> CasesWithorWithoutTasks = [select casenumber, (select status, whatid from tasks ) from case where id in:trigger.oldMap.keyset()];
	
	//Step 1a - List for cases with non zero tasks
	List<Case> CasewithNonZeroTasks = new List<Case>();
   // Map<Id,Case> CaseIdswithTasks = new Map<Id,Case>();
   
   //Create a set for Ids of cases where number of tasks >0
   Set<Id> CaseIdwithNonZeroTasks = new Set<Id>();
   
   //This set collects all the cases where the tasks are yet not Completed. This set is used to display an end user error message
   Set<Id> CaseIdswithOpenTasks = new Set<Id>();
   
   //For loop to collect cases with non zero  
	for(Case a:CasesWithorWithoutTasks)
    {
		Boolean foundOpenTask = false;
   		for (Task t: a.tasks) { //for loop to iterate through child tasks of a case
	   		if(t.Status != 'Completed') {
	   			foundOpenTask = true;
	   			break;
	   		}
   		}
	   	if (foundOpenTask) {
	   		CaseIdswithOpenTasks.add(a.id);
	   	}
   }
   
   //Get the tasks based on filter condition in a list - commented this as the above approach is better
   /*List<Task> TasksStillOpen = [SELECT WHATID,ID from TASK WHERE STATUS <> 'Completed' and whatid in:CaseIdwithNonZeroTasks];
   for(Task t:TasksStillOpen)
   {
   	 CaseIdswithOpenTasks.add(t.whatid);
   }*/
   
   //This for loop is to display an error based on whether the filtered list contains a case present in trigger.old
   for(Case c: trigger.old)	
   {
   	if(CaseIdswithOpenTasks.contains(c.id))
   	{
   		c.adderror('Cannot delete the case as open/in progress tasks are associated');
   	}
   }
	

}