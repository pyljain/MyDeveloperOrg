<aura:application >
  
    <ltng:require styles="/resource/SLDS0121/assets/styles/salesforce-lightning-design-system-ltng.css" />
    <div class="slds">
        <div class="slds-grid">   
            <div class="slds-col slds-size--1-of-2 slds-medium-size--5-of-6 slds-large-size--8-of-12">
                <c:getAccountList />
            </div>
            <div class="slds-col slds-size--1-of-2 slds-medium-size--1-of-6 slds-large-size--4-of-12">
               <c:OpportunitiesFromAccount />
            </div>
        </div> 
    </div>
</aura:application>