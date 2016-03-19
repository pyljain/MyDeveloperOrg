global with sharing class OrderExtnController {

    private final Order order;

    // The extension constructor initializes the private member
    // variable mysObject by using the getRecord method from the standard
    // controller.
    global OrderExtnController(ApexPages.StandardController stdController) {
        this.order = (Order)stdController.getRecord();
    }

    @RemoteAction
    global static List<String> getRelatedProducts(String name) {
        List<String> results = new List<String>();

        for (Related_Products__c rp : [SELECT Id, Related_Product__r.Name FROM Related_Products__c WHERE Source_Product__r.Name = :name]) {
            results.add(rp.Related_Product__r.Name);
        }

        return results;
    }
}