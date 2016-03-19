/*
 * This is the model for the getAssets controller. It retrieves the assets that belong to the case's account
*/

public class AccountAssetsModel{
    public static List<Asset> getallAssets (String caseaccountId)
    {
        String idvalue = caseaccountId;
        return [SELECT Name, Description FROM Asset WHERE AccountId = :idvalue];
    }
}