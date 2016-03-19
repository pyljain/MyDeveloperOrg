trigger Contract_Opportunity_Creation_AU on Contract (after update) {
	
	
	Set<id> ContractIds = new Set<id>();   //Collect Contract Ids that have been updated
	Map<Id, string> AccountwithContractName = new Map<Id, string>();
	List<account> accounttoupdate = new list<account>();
	List<opportunity> opportunitytocreate = new list<opportunity>();
	
	for(contract c: trigger.new)
	{
		if(c.OwnerExpirationNotice != '' && c.OwnerExpirationNotice != null )
		{
			if(trigger.oldMap.containskey(c.id))
			{
				if(trigger.oldMap.get(c.id).OwnerExpirationNotice =='' || trigger.oldMap.get(c.id).OwnerExpirationNotice == null )
				{
					ContractIds.add(c.id);
				}
			}
		}
		
		
	}
	
List<contract> contractwithaccount = [select name , account.id , account.Name from contract where id in: ContractIds];

for(contract con:contractwithaccount)
{
	accounttoupdate.add(con.account);
	if(AccountwithContractName.containskey(con.account.id))
	{
		AccountwithContractName.put(con.account.id , con.name + '' + AccountwithContractName.get(con.account.id));
	}
	else
	{
		AccountwithContractName.put(con.account.id , con.name);
	}
}

for(account a: accounttoupdate)
{
	if(AccountwithContractName.containskey(a.id))
	{
		Opportunity o = new Opportunity();
		o.Name = 'Contract Renewal for' + AccountwithContractName.get(a.id);
		o.AccountId = a.id;
		o.Description = 'This is a system generated opportunity for contract renewal';
		o.CloseDate = Date.today() + 10;
		o.StageName = 'Prospecting';
		opportunitytocreate.add(o);
		
	}
}

insert opportunitytocreate; 
}