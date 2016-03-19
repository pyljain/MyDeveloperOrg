({
    send : function(component, event, helper) {
       /* var text = event.source.get("v.phone"); */
        var text = component.find("phone").get("v.value");
        console.log(text);
        $A.get("e.c:PhoneNumberEvent").setParams({
            phone: text
       }).fire();
    }
})