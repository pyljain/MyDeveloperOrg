trigger CreateTaskHistory_AfterInsert on Task (after insert, after update, after delete, before insert, before update, before delete) {
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            TaskTriggerHandler.handleAfterInsert(Trigger.New);
        } else if (Trigger.isUpdate) {
            TaskTriggerHandler.handleAfterUpdate(Trigger.Old, Trigger.New);
        } else if (Trigger.isDelete) {
            TaskTriggerHandler.handleAfterDelete(Trigger.Old);
        } 
    } else if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            TaskTriggerHandler.handleBeforeInsert(Trigger.New);
        } else if (Trigger.isUpdate) {
            TaskTriggerHandler.handleBeforeUpdate(Trigger.Old, Trigger.New);
        } else if (Trigger.isDelete) {
            TaskTriggerHandler.handleBeforeDelete(Trigger.Old);
        } 
    }
}