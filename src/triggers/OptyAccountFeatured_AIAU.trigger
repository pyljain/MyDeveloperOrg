/* This trigger fires when a new opportunity is created or updated such that the sum of amounts on opportunities tied to
an account exceeds 3000. If it does , the account status is updated to "Featured".
Have used a new technique to iterate through a map.
*/


trigger OptyAccountFeatured_AIAU on Opportunity (after insert, after update) {
	
/*	List<Id> intialSetOfOptyIds = new List<id>();
	for(opportunity o: trigger.new)
	{
		if(o.amount != 0)
			{
				intialSetOfOptyIds.add(o.id);
				
			}
		
		else if (Trigger.oldMap.containskey(o.id))
			{
				if(Trigger.oldMap.get(o.id).amount != o.amount)
				{
					intialSetOfOptyIds.add(o.id);
				}
			}
	}

List<opportunity> optywithAccountDetails = [select amount , account.id from opportunity where id in: intialSetOfOptyIds];

//Get all opportunities with these acocunts as their associated parent. 

//List<opportunity> allOptysTiedtoAccount = [select id , amount from opportunity where account.Id]
Set<id> accountIds = new set<id>();
for(opportunity o1: optywithAccountDetails)
{
	accountIds.add(o1.account.id); //this set holds account ids
}

List<opportunity> allOptysTiedtoAccount = [select id , amount , account.Id from opportunity where account.Id in: accountIds];
//Map <Id,List<Id>> mapofaccountsandamount = new Map <Id, List<Id>>();
Map <Id,decimal> mapofaccountsandamount = new Map <Id, decimal>();

for(opportunity ord: allOptysTiedtoAccount)
{
	if(mapofaccountsandamount.containskey(ord.account.id))
	{
		mapofaccountsandamount.put(ord.account.id, mapofaccountsandamount.get(ord.account.id) + ord.amount );
	}
	
	else
	{
		mapofaccountsandamount.put(ord.account.id , ord.amount);
	}
}

List<id> accountstoUpdate = new List<id>();
//Iterating over a map
for(Id accountid: mapofaccountsandamount.keyset())
{
	if(mapofaccountsandamount.get(accountid) >= 3000)
	{
		accountstoUpdate.add(accountid);
	}
}

List<account> accountUpdated = [select type from account where id in:accountstoUpdate];

for(account a1:accountUpdated)
{
	a1.Type = 'Featured';
}

update accountUpdated;*/
}