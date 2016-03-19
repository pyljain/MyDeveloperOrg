public class CreateNominationsController {

public Contact con{get;set;}
public Nominations__c nom{get;set;}
public List<contact> lstContact; 
public Contact currentContact {get;set;}
public Nominations__c newNomination;

    public CreateNominationsController () 
    {
        lstContact = [SELECT ID, LASTNAME , FIRSTNAME , BIRTHDATE , EMAIL, HOMEPHONE, GENDER__C FROM CONTACT WHERE ID = :ApexPages.currentPage().getParameters().get('Id')];
        currentContact = lstContact[0];
        nom = new Nominations__c();
    
    }



    public PageReference submit() {
    
        Nominations__c nomCreateNew = insertnewNomination();
        return new PageReference ('/' +nomCreateNew .id);
      //  return null;
    }
    
    public nominations__c insertnewNomination()
    {
      nominations__c Nomination = new nominations__c();
      Nomination.name = nom.name;
      Nomination.Nominated__c = nom.Nominated__c;
      Nomination.contact__c = currentContact.id;
      Nomination.Reason_for_Nomination__c = nom.Reason_for_Nomination__c;
      
      insert nomination;
      return nomination;
  
  
    }




}