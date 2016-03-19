public class ProjectCreateExtension {
    
    private ApexPages.StandardController sc;
    public Sprint__c sprint {get; set;}
    public Story__c story{get; set;}
    public List<Sprint__C> sprints {get; set;}
    public List<Story__c> stories{get; set;}
    public string selectedSprint{get;set;}
    public Project__c project {get;set;}
    
    public ProjectCreateExtension(ApexPages.StandardController controller) {
    
        sc = controller; //What is the purpose of declaring a private StandardController instance?
        sprint = new Sprint__c();
        Story = new story__c();
    }
    
    public PageReference ToPage2()
    {
        if(ApexPages.CurrentPage().GetURL().ToLowerCase().StartsWith('/apex/projectcreat1'))
        {
            sc.save();
            project = (Project__c)sc.getRecord();
            sprints = [SELECT ID, NAME , START_DATE__c FROM SPRINT__C WHERE PROJECT__C = :project.ID];
        }
        
        return Page.ProjectCreat2;
    }
    
    public PageReference ToPage1()
    {
        return Page.ProjectCreat1;
    }

    public PageReference SaveSprint()
    {
        Sprint__c sp = new Sprint__c();
        //Project__c project = (Project__c)sc.getRecord(); //Talk about typecasting
        sp.Project__c = project.id;   
        sp.name = sprint.name;
        sp.start_date__c = sprint.start_date__C;    
        insert sp;
        //sprints = new List<Sprint__c>();
        sprints.add(sp);
        sprint = new Sprint__c();     
        return null;  
    
    }
    
     public PageReference ToPage3()
    {
        stories = [SELECT ID, THEME__C , NAME , POINTS__C FROM STORY__C WHERE SPRINT__C = :selectedSprint];
        return Page.ProjectCreat3;
    }

    public PageReference SaveStory()
    {
        Story__c s = new Story__c();
        
        s.Sprint__c = selectedSprint;
        s.name = story.name;
        s.points__c = story.points__c;
        insert s;
        
        stories.add(s);
        story = new Story__c();
        return null;
    }
    

}