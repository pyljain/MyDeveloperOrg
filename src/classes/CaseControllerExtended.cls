public class CaseControllerExtended {

    public Case c;
    public string filelabel {get;set;}
    public boolean checked {get; set;}
    public string caseId {get;set;}
    public List<attachment> attachments {get; set;}
    public attachment atc;
    public static final Integer NUM_ATTACHMENTS_TO_ADD=5;
    public case cnew {get;set;}
   

    public CaseControllerExtended (ApexPages.StandardController controller) {
        this.c = (Case)controller.getRecord();
        checked = false;
    }
    
    public attachment attachment {
      get {
     // if (attachment == null)
      atc = new Attachment();
      attachments = new list<attachment>();
      return atc;
        }
      set;
  }
  
  public PageReference upload() {

    attachment.OwnerId = UserInfo.getUserId();
    attachment.ParentId = ApexPages.currentPage().getParameters().get('caseId');
    attachment.IsPrivate = false;
    attachment.name = filelabel;

    try {
      insert attachments;
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
      return null;
    } finally {
      attachment = new Attachment(); 
    }

    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
    return null;
  }
  
   public PageReference save() {
      
        Case cnew = new case();
        cnew.id= ApexPages.currentPage().getParameters().get('caseId');
        cnew.description = c.description;
        cnew.subject = c.subject;
        cnew.status = c.status;
        cnew.priority = c.priority;
        cnew.origin = c.origin;
        insert cnew ;
        
           if (atc != null)
            {
                
                                
                    atc.OwnerId = UserInfo.getUserId();
                   atc.ParentId = ApexPages.currentPage().getParameters().get('caseId');
                   // atc.ParentId = cnew.id;
                    atc.IsPrivate = false;
                    atc.name = filelabel;                    
                    insert atc;
                    attachments.add(atc);
                
            try 
            {              
                   
                   If(attachments.size() != 0)
                   {
                       insert attachments;
                   }
            } 
            
            catch (DMLException e) 
            {
              ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
              return null;
            } 
            
          /*  finally 
            {
              attachments = new list<Attachment>(); 
            }
        
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
            return null;*/
            }
        
       PageReference newPage = new PageReference('/' + cnew.id);
       return newPage.setRedirect(true);
  }
  
  public void addMore()
    {
        //Create the case
        if(ApexPages.currentPage().getParameters().get('caseId') == null || ApexPages.currentPage().getParameters().get('caseId') == '')
        {
        Case cnew = new case();
        cnew.id= ApexPages.currentPage().getParameters().get('caseId');
        cnew.description = c.description;
        cnew.subject = c.subject;
        cnew.status = c.status;
        cnew.priority = c.priority;
        cnew.origin = c.origin;
        insert cnew ;
        } 
        
       /* else 
        
        {
            cnew.id = ApexPages.currentPage().getParameters().get('caseId');
        }*/
        //Attaching the attachment to the case
        
       
                
                                
                    atc.OwnerId = UserInfo.getUserId();
                    //attachment.ParentId = ApexPages.currentPage().getParameters().get('caseId');
                    atc.ParentId = cnew.id;
                    //atc.ParentId = ApexPages.currentPage().getParameters().get('caseId');
                    atc.IsPrivate = false;
                    atc.name = filelabel;                    
                    insert atc;
                    attachments.add(atc);
                
            try 
            {              
                   
                   If(attachments.size() != 0)
                   {
                       update attachments;
                   }
            } 
            
            
            
            finally 
            {
              attachments = new list<Attachment>(); 
            }
        
                  
            
        //    Attachments.add(new Attachment());
        
    
    
    for (Integer idx=0; idx<NUM_ATTACHMENTS_TO_ADD; idx++)
        {
            attachments.add(new Attachment());
        }
 
 }
 
 }