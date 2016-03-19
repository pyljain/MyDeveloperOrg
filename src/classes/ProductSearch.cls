public class ProductSearch {

Public String productName {Get;Set;}
public List<Product2> returnproducts {get; set;}
    public PageReference save() {
    String str = '%' + productName + '%'; 
       // returnproducts = [SELECT Name FROM Product2 where NAME LIKE :str];
       System.debug('**************************' +str);
        return new PageReference('https://c.ap1.visual.force.com/apex/ProductResults?query=' +productName);
        
       // return null;
    }



    public ProductSearch()
    {

    }
    



}