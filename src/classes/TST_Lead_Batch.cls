@isTest
public class TST_Lead_Batch {
    
   public static testmethod void testLeadAssignment_withASingleLeadAssignedToUser() {
       Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
       User u = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='dodgy@testorg.com');
       insert u;
       
       Lead l = new lead();
       l.LastName = 'Test';
       l.Company = 'Tesrt';
       l.OwnerId = u.Id;
       insert l;
       
       Test.startTest();
       UpdateLeadOwnerBatch batch = new UpdateLeadOwnerBatch(u.Id);
       Database.executeBatch(batch);
       Test.stopTest();
       
       l = [SELECT Id, LeadSource FROM Lead WHERE id= :l.Id];
       System.assertEquals('Web', l.LeadSource);
   }
    
   public static testmethod void testLeadAssignment_withASingleLeadAssignedToDifferentUser() {
       Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
       User u1 = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='dodgy@testorg.com');
       insert u1;
       
       User u2 = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='wodgy@testorg.com');
       insert u2;
       
       Lead l = new lead();
       l.LastName = 'Test';
       l.Company = 'Tesrt';
       l.OwnerId = u2.Id;
       insert l;
       
       Test.startTest();
       UpdateLeadOwnerBatch batch = new UpdateLeadOwnerBatch(u1.Id);
       Database.executeBatch(batch);
       Test.stopTest();
       
       l = [SELECT Id, LeadSource FROM Lead WHERE id= :l.Id];
       System.assertEquals(null, l.LeadSource);
   }
}