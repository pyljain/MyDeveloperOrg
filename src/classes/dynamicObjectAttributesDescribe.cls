public class dynamicObjectAttributesDescribe {

    public dynamicObjectAttributesDescribe() 
    {
       //Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(+objectNameString).getDescribe().fields.getMap();
       //strList = new List<String>(objectFields.keySet());
    }
    
    public string objectNameString {get; set;}
    public list<string> labels = new list<string>();
    //public List<String> strList { get;set; }
    
    public List<String> getStrList() {
    
       Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectNameString).getDescribe().fields.getMap();
       for(String fieldname: objectFields.keySet())
       {
           String fieldlabel;
           fieldlabel = objectFields.get(fieldname).getdescribe().getlabel();
           labels.add(fieldlabel);
       }
      // return new List<String>(objectFields.keySet());
      return labels;
    }
}