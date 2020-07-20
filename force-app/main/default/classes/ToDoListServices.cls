public class ToDoListServices {
    //methods inserts into DB new Person__c with FName and LName provided in parameters and returns this record
    //DONE
    public static SaveResultCP createPerson (String fName, String lName){
        SaveResultCP result = new SaveResultCP();
        Person__c person = new Person__c(First_Name__c = fname, Last_Name__c = lname);   
        
        try{
            insert(person);
            result.personId = person.Id;
            result.isSuccess = true;
        }catch (DmlException e){
            result.isSuccess = false;
            result.errorMessage = e.getMessage();
        }
        
        System.debug(result);
        return result;
    }
    
    //create new Task with Project and Person shown in parameters, 
    //Start_Day__c must be set today's date, Status - draft (do not insert into DB)
    //WTF
    public static SaveResultSNT startNewTask(Id projectId, Id personId) {
        Task__c newTask = new Task__c();
        newTask.Project__c = projectId;
        newTask.Person__c = personId;
        newTask.Start_Date__c = Date.today();
        newTask.Status__c = 'Draft';
        
        SaveResultSNT result = new SaveResultSNT();
        result.isSuccess = true;
        
        return new SaveResultSNT();
    }
    
    //Update statuses for all tasks of specified project
    public static SaveResultUTSFP updateTaskStatusesForProject(Id projectId, String newStatus) {
        List<Task__c> tasksToUpdate = [SELECT Id, Status__c
                                       FROM Task__c
                                       WHERE Project__c = :projectId];
        for (Task__c taskItem : tasksToUpdate) {
            taskItem.Status__c = newStatus;
        }
        
        SaveResultUTSFP result = new SaveResultUTSFP();
        
        try{
            update(tasksToUpdate);
            result.isSuccess = true;
            result.numberOfUpdatedTasks = tasksToUpdate.size();            
        } catch (DmlException e){
            result.isSuccess = false;
            result.numberOfUpdatedTasks = 0;
            result.errorMessage = e.getMessage();
        }
        return result;
    }
    
    //method deletes Projects with Ids passed in parameters and tasks related to these Projects
    public static SaveResultDP deleteProjects(Set<Id> projectIds) {
        SaveResultDP result = new SaveResultDP();
        List<Project__c> projectsToDelete = [SELECT Id
                                             FROM Project__c
                                             WHERE id IN :projectIds];
        
        Integer numberOfTasksBefore = [SELECT COUNT()
                                       FROM Task__c];
        
        try{
            delete(projectsToDelete);
            result.isSuccess = true;          
        } catch (DmlException e){
            result.isSuccess = false;
            result.errorMessage = e.getMessage();
        }
        
        Integer numberOfTasksAfter = [SELECT COUNT()
                                           FROM Task__c];
        
        result.numberOfDeletedTasks = numberOfTasksBefore - numberOfTasksAfter;
        return new SaveResultDP();
    }
}