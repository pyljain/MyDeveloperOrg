public class UpdateLeadOwnerBatch implements Database.Batchable<Lead> {
    
    public Id ownerId;
    
    public UpdateLeadOwnerBatch(Id ownerId) {
        this.ownerId = ownerId;
    }
    
    public Iterable<Lead> start(Database.BatchableContext context) {
        return [SELECT Id, LeadSource FROM Lead WHERE OwnerId = :OwnerId];
    }
    
    public void execute(Database.BatchableContext context, List<Lead> lst) {
        for (Lead l : lst) {
            l.LeadSource = 'Web';
        }    
        
        update lst;
    }
    
    public void finish(Database.BatchableContext context) {}
}