public class Account_WeatherController {
    
    @AuraEnabled
    public static String getAccountWeather(String accountid) {
        
        List<String> weatherinputs = new List<String>();
        String site;
        Account acc = [SELECT ShippingCity, ShippingPostalCode FROM account WHERE ID = :accountid];  
        site = acc.ShippingCity;
        return getforecast.getTemp(site);
    }
    

}