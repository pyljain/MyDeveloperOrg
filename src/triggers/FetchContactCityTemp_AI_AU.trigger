trigger FetchContactCityTemp_AI_AU on Contact (after insert , after update) {
  
  List<Contact> UpdatedContacts = new list<contact>();
    for (contact c: trigger.new)
        {
            if(c.city__c != null && c.City__c != '') 
                {
                    if(trigger.oldmap.containskey(c.Id))
                    {
                        if(trigger.oldmap.get(c.id).city__c != c.City__c)
                        {
                            UpdatedContacts.add(c);
                        }
                    }
                }
        } //End of For

    for(Contact con: UpdatedContacts)
    {
       // GetCityTemparatureCallOutUP cityTemp = new GetCityTemparatureCallOut();
        GetCityTemparatureCallOutUP.getTemparature(con.City__c , con.Id);
        //con.Temperature__c = temp.get('temp');
    }
}