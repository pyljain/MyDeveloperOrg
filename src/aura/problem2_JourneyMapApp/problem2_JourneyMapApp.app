<aura:application >
    <ltng:require styles="/resource/bootstrap" scripts='/resource/jquery,/resource/bootstrapjs' afterScriptsLoaded="{!c.jsLoaded}" />
	
    	<div class="col-md-3">
            <c:problem2_accountList type="source" />
        
        </div>
        <div class="col-md-6" style="height:100%">
        	<c:problem2_googleMap />
        
        </div>
        <div class="col-md-3">
        	<c:problem2_accountList type="destination" />
        
        </div>
    
    
    
    
</aura:application>