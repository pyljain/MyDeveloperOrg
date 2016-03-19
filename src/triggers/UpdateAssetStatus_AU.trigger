trigger UpdateAssetStatus_AU on Asset (after update) {

/*Check if the asset status is 'On Hold' and compare the status to the previous status. If there is a change then
capture the asset Ids in a set*/


Set<Id> assetIdsThatAreUpdatedtoHold = new set<id>();
for(Asset a: trigger.new)
{
	if(a.Status == 'On Hold')
	{
		if(trigger.oldmap.containskey(a.id) && trigger.oldmap.get(a.id).status != 'On Hold')
		{
			assetIdsThatAreUpdatedtoHold.add(a.id);
		}
	}
}

List<asset> getAssetWithProdandAccountId = [select account.id , product2id, Product2.Dependencies__c from asset where id in: assetIdsThatAreUpdatedtoHold];
List<asset> AssetToUpdatewithOnHold = new List<asset>();
for(Asset a:getAssetWithProdandAccountId)
{
	if(a.product2.Dependencies__c != null)
	{
		if(a.Account.assets.size() > 1)
		{
			for(Asset childAsset: a.Account.assets )
			{
				if(childAsset.Product2.Dependencies__c == a.Product2.name)
				{
					childasset.status = 'On Hold';
					AssetToUpdatewithOnHold.add(childasset);
				}
			}
		}
	}
	
}

update AssetToUpdatewithOnHold; 

}