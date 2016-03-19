public class TopAccountsController {

    public String num { get; set; }
    
    /**
      * This function fetches the previous page by calling the same page with a decremented page number
     */
    public PageReference previousPage() {
        return new PageReference('https://c.ap1.visual.force.com/apex/TopAccounts?pageNum=' + (pageNumber - 1));
    }

    
    /**
      * This function fetches the next page by calling the same page with incremented page number
     */
    public PageReference nextPage() {
        return new PageReference('https://c.ap1.visual.force.com/apex/TopAccounts?pageNum=' + (pageNumber + 1));
    }
    
    // An integer containing the current page number as passed in the query parameters of the page
    public Integer pageNumber {get; set;}
    
    // The list of accounts to show on the page
    public List<Account> records {get; set;}
    
    // Constant Page Size
    private static final Integer PAGE_SIZE = 3;
    
    /**
      * Constructor which fetches the data from the model for the current page.
      * If no page number is passed then it defaults to page 0
     */
    public TopAccountsController() {
        String pageNum = ApexPages.currentPage().getParameters().get('pageNum');
        pageNumber = 0;
        
        if (pageNum != null) {
            pageNumber = Integer.valueOf(pageNum);
        }
        
        records = TopAccountsModel.getTopAccounts(pageNumber, PAGE_SIZE);
    }
}