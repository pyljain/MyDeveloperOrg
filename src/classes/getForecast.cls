public class getForecast {

    public Map<String, Object> tempHolder;
    
   // @future(callout = true) 
    public static void getTemparature(String City , Id accountId)
    {
        //String c = city;        
       // List<Object> temparature ;
        
       
       // Get Temperature of City
       String temp = String.valueOf(getTemp(city));
       
       // Update Account wih temperature
       updateAccountwithTemp(accountId,temp); 
    }

   public static String getTemp(String city)
	{
		String cityTemp;
		String endpoint = 'http://api.openweathermap.org/data/2.5/weather?q=' + city +'&appid=2de143494c0b295cca9337e1e96b00e0';
		Map <String, object> temp ;
        String tempValue;
        //String endpoint = String.valueOf(endpoint_Partial)+ String.valueOf(City);
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        Http http = new Http();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        res = http.send(req);
        
        return res.getBody();
       		// Map<String,object> responseMap = (Map<String,object>)JSON.deserialize(res.getBody(),Map<String,object>.class);
       		        
      		//Map<String, Object> responseMap = (Map<String,Object>)JSON.deserializeUntyped(res.getbody());
       		// responseMap.get('temp_max');
      		 // temparature = (List<Object>)responseMap.get('main');  
      		//temp = (Map<String, object>)responseMap.get('main');  
      		//tempValue = temp.get('temp');  
       		//System.debug(responseMap);
       		//System.debug(temp.get('temp'));
		
		
		//return (Decimal)temp.get('temp');
	
	}

  public static void updateAccountwithTemp(Id accountId , String temp)
	{

		Account a = [select name , Description from account where id = :accountId];
		a.Description = temp;
		update a;
	}
}