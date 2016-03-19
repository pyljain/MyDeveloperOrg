global class ContactEmailHandler implements Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
    Messaging.InboundEnvelope envelope)
  {
      Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
      String incomingEmailAddress = envelope.fromaddress;
      List<contact> ContactExists = [select email from contact where email =:incomingEmailAddress];
      if(ContactExists.size() != 0)
      {
          if(email.binaryattachments !=null && email.binaryattachments.size() > 0)
          {
              for(Contact con: ContactExists)
              {                 
                      for(integer i = 0; i < email.binaryattachments.size(); i++)
                  		{
                          Attachment a = new attachment();
                          a.parentid = con.Id;
                          a.Name = email.binaryattachments[i].filename;
                          a.Body = email.binaryattachments[i].body;                          
                          insert a;
                  		}
              }
          }
          
      }
      
      else
      {      
      
          Contact c = new contact();
          c.firstname = email.fromname.substring(0, email.fromname.indexof(' '));
          c.LastName = email.fromname.substring (email.fromname.indexof(' '));
          c.Email = envelope.fromaddress;
          insert c;
          
          System.debug('*********CONTACT CREATED' +c.Id);
          
          if(email.binaryattachments !=null && email.binaryattachments.size() > 0)
          {
              for(integer i = 0; i < email.binaryattachments.size(); i++)
              {
                  Attachment a = new attachment();
                  a.parentid = c.Id;
                  a.Name = email.binaryattachments[i].filename;
                  a.Body = email.binaryattachments[i].body;
                  insert a;
              }
          }
      
      }
      
     return result; 
  }
    

}