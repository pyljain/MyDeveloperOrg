trigger UpdateBioValueOnAcreage_BI on Acreage__c (before insert) {
    
    List<Acreage__c> AcreageWithDetails = new List<Acreage__C>();
    for(Acreage__c a: trigger.new)
    {
        if(a.Account_ID__c != null && a.Account_ID__c != '')
        {
        AcreageWithDetails = [SELECT Crop_Name__c , account_ID__c FROM ACREAGE__c WHERE ID IN :trigger.newmap.keyset()];
        for(Acreage__c ac: AcreageWithDetails)
        {
            List<Bio_Potential__c> BioValues = [SELECT Bio_Value__c FROM Bio_Potential__c where Crop_Name__c = :ac.Crop_Name__c AND Territory__c = :ac.Account_ID__r.territory__c];
            for(Bio_Potential__c b: BioValues)
            {
                ac.Bio_Potential__c = b.Bio_Value__c;
            }
        }
        
        
        }        
    }

}