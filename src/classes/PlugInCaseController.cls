public class PlugInCaseController {
    
   
    public PlugInCaseController() {}
    
    public String IdParam { get; set; }
    public String fieldName {get; set;}
    
    public List<PieWedgeData> getPieData() 
    {  
        List<PieWedgeData> data = new List<PieWedgeData>();
        List<case> casedata = new List<case>();  
        
        String sql = 'SELECT Status FROM Case where ' + fieldName + ' = \'' + IdParam + '\'';
        casedata = Database.Query(sql);
        Map<String, Decimal> statusWithCounts = new Map<String, Decimal>();
        
        for(case c:casedata)
        {   
            if (statusWithCounts.containsKey(c.status)) {
                Decimal existingValue = statusWithCounts.get(c.status);
                Decimal newValue = existingValue + 1;
                statusWithCounts.put(c.Status, newValue);
            } else {
                statusWithCounts.put(c.Status, 1);
            }
        }
        
        for (String status : statusWithCounts.keySet()) {
            data.add(new PieWedgeData(status, statusWithCounts.get(status)));
        }
        
        return data;  
    }  

     public class PieWedgeData 
    {  
        public String name { get; set; }  
        public Decimal data { get; set; }  
        
        public PieWedgeData(String name, Decimal data) 
        {  
            this.name = name;  
            this.data = data;  
        }  
    }  
    
}