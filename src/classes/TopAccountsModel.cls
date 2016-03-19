/**
  * This is the Account Model Class for the TopAccounts Controller
 */
public class TopAccountsModel {
	
    /**
	  * Function returns the top n Accounts ordered by the Annual Revenue field
	  * @param pageNumber This is the page number to be retrieved - Starts from 0
	  * @param pageSize This is the number of records to be returned for the page
      * return A list of accounts with the name, AnnualRevenue and Opportunity details
     */
    public static List<Account> getTopAccounts(Integer pageNumber, Integer pageSize) {
        Integer offset = pageNumber * pageSize;
        return [SELECT Id, Name, AnnualRevenue, (SELECT Id, Name, StageName FROM Opportunities) FROM Account WHERE AnnualRevenue > 0 ORDER BY AnnualRevenue DESC LIMIT :pageSize OFFSET :offset];
    }
}