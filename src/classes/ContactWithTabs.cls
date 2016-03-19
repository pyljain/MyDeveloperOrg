public class ContactWithTabs {
    private final Contact con;
    public ContactWithTabs(ApexPages.StandardController controller) {
    
        this.con = (Contact)Controller.getRecord();

    }

}