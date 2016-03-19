public class GetAssetsController {

    public Case c;
    public boolean checked {get; set;}
    public String accountid {get; set;}
    public List<Asset> assetRecords {get; set;}
    
    public List<assetwrapper> assetList {get; set;}
    List<Asset> selectedAssets = new List<Asset>();
    
    public List<assetwrapper> getAssetsWrapper()
    {
        assetList = new List<assetwrapper>();
        
        for(Asset a : AccountAssetsModel.getallAssets(accountid))
            assetList.add(new assetwrapper(a));
            
        return assetList;
    }

public List<Asset> GetSelectedAssets()
    {
        if(selectedAssets.size()>0)
        return selectedAssets;
        else
        return null;
    } 

    public GetAssetsController(ApexPages.StandardController controller) {
        this.c = (Case)controller.getRecord();
        
        Id caseId = c.id;
            for (Case ca: [SELECT accountId FROM Case WHERE Id = :caseId]) {
            accountid = ca.accountid;
           // assetRecords = AccountAssetsModel.getallAssets(accountid);
        } 
    }
    
    public PageReference getassets () { 
    
           getAssetsWrapper();
           return null;
    }
    
    public PageReference createactivity() { 
    
       for(assetwrapper asswrapper : assetList) {
           if(asswrapper.checked == true)
               selectedAssets.add(asswrapper.ass);
       }
       
       System.debug(assetList);
       System.debug(selectedAssets);
            
        for(Asset sel: selectedAssets)
        {
           Task a = new Task();
        //a.Owner = 'Payal Jain';
          a.Subject = 'New Task';
          a.Status = 'In Progress';
          a.WhatId = sel.id;
          a.Priority = 'Normal';
          insert a;
        }
        
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