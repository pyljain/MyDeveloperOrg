public class getassets {

public final case c;
public string accountid {get;set;}
 public List<asset> records {get; set;}

    public getassets(ApexPages.StandardController controller) {
        this.c = (Case)controller.getRecord();
        accountid = c.accountid;
        records = AccountAssetsModel.getallAssets(accountid); 
    }
    
    public PageReference getassets () {
         
    return null;
    }

}