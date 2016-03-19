public class results {

public List<Product2> returnproducts {get; set;}
public String valuestr = ApexPages.currentPage().getParameters().get('query');
String str = '%' + valuestr + '%'; 
String imageURL='/servlet/servlet.FileDownload?file=';

public results()
{
    System.debug('**************************' +ApexPages.currentPage().getParameters().get('query'));
    System.debug('**************************' +str);

    returnproducts = [SELECT Name , ProductCode , (select id, name from attachments) FROM Product2 where NAME LIKE :str];
    for(Product2 a: returnproducts)
    {
        if (a.attachments.size() > 0)
        {
            imageURL = imageURL + a.attachments.get(0).id;
        }
    }
}

}