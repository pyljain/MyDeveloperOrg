public class createappointment {

public string slotend {get;set;}
public string slotstart {get;set;}
public final account acc;

    public createappointment(ApexPages.StandardController controller) {
    this.acc = (Account)Controller.getRecord();
    }

 public PageReference bookappt() {
        System.debug(this.acc.name);
        return null;
    }
    
     public List<SelectOption> getItemsList() {   
              
            List<SelectOption> options = new List<SelectOption>();                       
          options.add(new SelectOption('9','9'));
          options.add(new SelectOption('10','10'));
          options.add(new SelectOption('11','11'));
          options.add(new SelectOption('12','12'));
          options.add(new SelectOption('13','13'));
          options.add(new SelectOption('14','14'));
          options.add(new SelectOption('15','15'));
          options.add(new SelectOption('16','16'));
          options.add(new SelectOption('17','17'));
            
           
            return options;
            
        }
        
}