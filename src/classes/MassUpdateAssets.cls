public class MassUpdateAssets {

    public PageReference massUpdate() {
        if (updateMode == true) {
            updateMode = false;
        } else {
            updateMode = true;
        }
        return null;
    }


    public PageReference saveRecords() {
        for(assetwrapper asswrapper : assetList) {
            if(asswrapper.checked == true)
                selectedAssets.add(asswrapper.ass);
        }
               
        for(Asset sel: selectedAssets)
        {
            update sel;
        }
        
        return null;
    }


    private final Asset ast;
    public boolean checked {get; set;}
    List<Asset> allassets = new List<Asset>();
    List<Asset> selectedAssets = new List<Asset>();
    public List<assetwrapper> assetList {get; set;}
    
    public boolean updateMode {get; set;}
       
    public MassUpdateAssets () {
        allassets = [SELECT id, name, Description , status FROM Asset];
        getAssetsWrapper();
        updateMode = false;
    }
    
    
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT id, name, Description , status FROM Asset]));
            }
            return setCon;
        }
        set;
    }
    
    public List<asset> allassets() {
        return (List<asset>) setCon.getRecords();
    }
    
    
    public List<assetwrapper> getAssetsWrapper()
    {
        assetList = new List<assetwrapper>();
        
        for(Asset a : allassets )
            assetList.add(new assetwrapper(a));
            
        return assetList;
    }

    public void getAllassets() {
       // return null;
    }
    
     public PageReference updaterecords() { 
    
       for(assetwrapper asswrapper : assetList) {
           if(asswrapper.checked == true)
               selectedAssets.add(asswrapper.ass);}
               
          for(Asset sel: selectedAssets)
            {
                  sel.status= 'Obsolete';
                  update sel;
            }
               return null; 
       }
    
    public PageReference updateAssets() { 
    
           getAssetsWrapper();
           return null;
    }
    
    
    
    public class assetwrapper
    {
        public Asset ass{get; set;}
        public Boolean checked{get; set;}
        public assetwrapper(Asset a)
        {
            ass = a;
            checked = false;
        }
    }

}