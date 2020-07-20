public class TaskTriggerUtils {
    // Accumulate total amount of related Tasks and Projects in fields 
    // Total_Amount_Tasks__c and Total_Amount_Projects__c on Person__c object
    
    //1 AFTER
    //combined
    public static void caltTotalAmountTaskAndProjects (List<Task__c> inputList) {
        calcTotalAmountTasks(inputList);
        calcTotalAmountProjects(inputList);
    }
    //amount of tasks
    public static void calcTotalAmountTasks(List<Task__c> inputList){
        List<Person__c> personsToUpdate = new List<Person__c>();
        
        List<Id> personsIdsToUpdate = new List<Id>();
        for (Task__c taskItem : inputList) {
            personsIdsToUpdate.add(taskItem.Person__c);
        }
        
        List<AggregateResult> results = [SELECT Person__c, COUNT_DISTINCT(id) 
                                         FROM Task__c 
                                         WHERE Person__c IN :personsIdsToUpdate
                                         GROUP BY Person__c];
        for(AggregateResult resultItem : results) {
            Id personId = (Id)resultItem.get('Person__c');
            Integer amount = (Integer)resultItem.get('expr0');
            
            Person__c person = new Person__c();
            person.Id = personId;
            person.Total_Amount_Tasks__c = amount;
            personsToUpdate.add(person);
        }
        System.debug(personsToUpdate.size());
        
        try{
            update(personsToUpdate);
        }catch (DmlException e){
            System.debug(e.getMessage());
        }        
    }
    
    //amount of projects
    public static void calcTotalAmountProjects(List<Task__c> inputList){
        List<Person__c> personsToUpdate = new List<Person__c>();
        
        List<Id> personsIdsToUpdate = new List<Id>();
        for (Task__c taskItem : inputList) {
            personsIdsToUpdate.add(taskItem.Person__c);
        }
        
        List<AggregateResult> results = [SELECT Person__c, COUNT_DISTINCT(Project__c) 
                                         FROM Task__c 
                                         WHERE Person__c IN :personsIdsToUpdate
                                         GROUP BY Person__c];
        for(AggregateResult resultItem : results) {
            Id personId = (Id)resultItem.get('Person__c');
            Integer amount = (Integer)resultItem.get('expr0');
            
            Person__c person = new Person__c();
            person.Id = personId;
            person.Total_Amount_Projects__c = amount;
            personsToUpdate.add(person);
        }
        
        try{
            update(personsToUpdate);
        }catch (DmlException e){
            System.debug(e.getMessage());
        }    
    }
    
    //Prevent changing Person on Task object when Status is Completed
    //2. BEFORE UPDATE (works ok)
    public static void preventUpdateCompletedTask(List<Task__c> inputList) {
        for (Task__c taskItem : inputList){
            if (taskItem.Status__c == 'Completed'){
                taskItem.addError('You can not update Person, when Status of Task is Completed');   
            }
        }
    }
    //remove 2nd loop
    public static List<Task__c> getTasksWithUpdatedPerson (List<Task__c> newTasks, List<Task__c> oldTasks) {
        List<Task__c> tasksWithUpdatedPerson = new List<Task__c>();
        
        for(Task__c itemNew : newTasks) {
            for (Task__c itemOld : oldTasks) {
                if ((itemNew.Id == itemOld.Id) && (itemNew.Person__c != itemOld.Person__c)) {
                    tasksWithUpdatedPerson.add(itemNew);
                }
            }
        }
        
        return tasksWithUpdatedPerson;
    }
    
    //3
    public static void updateProjectStatus (List<Task__c> inputList) {
        Set<Id> projectsIds = new Set<Id>();
        for (Task__c taskItem : inputList) {
            projectsIds.add(taskItem.Project__c);
        }
        
        List<Project__c> projectsToUpdate = [SELECT Id, Status__c, Actual_End_Date__c, (SELECT Id, End_Date__c, Status__c 
                                                                                        From Tasks__r)
                                             FROM Project__c
                                             WHERE Id in :projectsIds
                                            ];
        
        for (Project__c projectItem : projectsToUpdate) {
            String newStatus = ToDoListService.getParentStatus(projectItem.Tasks__r, projectItem.Actual_End_Date__c);
            projectItem.Status__c = newStatus;   
        }
        
        try{
            update(projectsToUpdate);
        }catch (DmlException e){
            System.debug(e.getMessage());
        }     
    }
}