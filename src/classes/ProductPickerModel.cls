/*
* This is a model for the ProductPickerController. It facilitates product search and selection
*/
public class ProductPickerModel{    
   
    public static List<product2> getproducts(String searchstring)
    {
        String localString = '%' +searchstring+ '%';
        return [select id , name from product2 where name like :localString limit :3];
    }

}