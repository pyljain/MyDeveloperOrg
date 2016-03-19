trigger AccountTrackChanges_AU on Account (after update) {

    List<account> updatedAccounts = [SELECT ID, NAME FROM ACCOUNT WHERE ID IN :trigger.newmap.keyset()];
    Map<String, String> AccountMap = new map<String, String>();
    for(account a:updatedAccounts)
    {
   		 
   		 AccountMap.put(a.id, a.name);
    }
     AccountTrackChangesController.createhistory(AccountMap);
}