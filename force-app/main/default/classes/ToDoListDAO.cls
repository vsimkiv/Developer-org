public class ToDoListDAO {
    //DONE
    public static Person__c getPerson(Id personId){
        return [SELECT Name, First_Name__c, Last_Name__c, Full_Name__c, Total_Amount_Tasks__c, Total_Amount_Projects__c
                FROM Person__c
                WHERE Id = : personId];
    }
    
    //Get overdue tasks for specific people. Result tasks should be grouped by project ids
    //TO TEST
    public static Map<Id, List<Task__c>> getOverdueTasksByProjectIds (Set<Id> personIds) {
        //get all tasks of required persons
        List<Task__c> allTasks = [SELECT Id, Name, End_Date__c, Project__r.Id, Project__r.Actual_End_Date__c 
                                  FROM Task__c
                                  WHERE Person__c IN :personIds
                                  ORDER BY Person__c];
        //fiter overdue tasks
        //get set of projectIds of overdue tasks
        Set<Id> projectIds = new Set<Id>();
        List<Task__c> overdueTasks = new List<Task__c>();
        for (Task__c taskItem : allTasks) {
            if (taskItem.End_Date__c > taskItem.Project__r.Actual_End_Date__c) {
                projectIds.add(taskItem.Project__c);
                overdueTasks.add(taskItem);
            }
        }
        
        Map<Id, List<Task__c>> overdueTasksByProjectIds = new Map<Id, List<Task__c>>();
        
        for (Id idItem : projectIds){
            List<Task__c> currentProjectTasks = new List<Task__c>();
            for (Task__c taskItem : overdueTasks){
                if (idItem == taskItem.Project__c){
                    currentProjectTasks.add(taskItem);
                }
            }
            overdueTasksByProjectIds.put(idItem, currentProjectTasks);
        }
        
        for (Id key : overdueTasksByProjectIds.keyset()){
        	system.debug(overdueTasksByProjectIds.get(key));
        }
        
        return overdueTasksByProjectIds;
    }
    
    //return Map of next format: Id - Person__c.Id, Set<Id> - set of Project__c.Id where Person participated
    //TO TEST
    public static Map<Id, Set<Id>> getProjectsByPersonsIds(Set<Id> personIds) {
        List<Task__c> taskList = [SELECT Project__c, Person__c
                                  FROM Task__c
                                  WHERE Person__c IN :personIds
                                 ];
        
        Map<Id, Set<Id>> personsWithProjects = new Map<Id, Set<Id>>();
        
        for (Id personItem : personIds){
            Set<Id> projectIds = new Set<Id>();
            for (Task__c taskItem : taskList){
                if (taskItem.Person__c == personItem) {
                    projectIds.add(taskItem.Project__c);
                }
            }
            personsWithProjects.put(personItem, projectIds);
        }
        
        return personsWithProjects;
    }
    
    //get 5 Projects of ANY Status with the biggest amount of participated People
    //
    public static List<Project__c> getFiveBiggestProjects () {
        List <AggregateResult> projectsWithNumberOfPersons = [SELECT Project__c, COUNT_DISTINCT(Person__c)
                                                              FROM Task__c
                                                              GROUP BY Project__c
                                                              ORDER BY COUNT_DISTINCT(Person__c) DESC
                                                              LIMIT 5
                                                             ];
        List<Id> fiveBiggestProjectsIds = new List<Id>();        
        for (AggregateResult arItem : projectsWithNumberOfPersons) {
            fiveBiggestProjectsIds.add((Id)arItem.get('Project__c'));
        }

        return [SELECT Id, Name
               FROM Project__c
               WHERE Id IN :fiveBiggestProjectsIds];
    }    
}