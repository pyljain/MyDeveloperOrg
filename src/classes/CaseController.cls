public class CaseController {

    public PageReference checked() {
      if(c.origin == 'Phone')
        {
            checked = true;
        }
        return null;
    }


    public Case c;
    public string filelabel {get;set;}
    public boolean checked {get; set;}

    public CaseController(ApexPages.StandardController controller) {
        this.c = (Case)controller.getRecord();
        checked = false;
    }
    
    public Attachment attachment {
      get {
      if (attachment == null)
        attachment = new Attachment();
      return attachment;
        }
      set;
  }
  
  public PageReference upload() {

    attachment.OwnerId = UserInfo.getUserId();
    attachment.ParentId = c.id;
    attachment.IsPrivate = false;
    attachment.name = filelabel;

    try {
      insert attachment;
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
      return null;
    } finally {
      attachment = new Attachment(); 
    }

    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
    return null;
  }
 
    

}