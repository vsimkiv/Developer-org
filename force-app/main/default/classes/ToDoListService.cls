public class ToDoListService {
    //
    public static String getParentStatus(List<Task__c> taskList, Date projectPlannedEndDate){
        Boolean isDraftTaskInList = false;
        Boolean isTaskWithoutStatusInList = false;
        Boolean isOverdueTaskInList = false;
        
        for (Task__c taskItem : taskList){
            if (taskItem.Status__c == 'Started') {
                return 'In Progress';
            }
            if (taskItem.Status__c == 'Draft'){
                isDraftTaskInList = true;
            }
            if (taskItem.Status__c == null) {
                isTaskWithoutStatusInList = true;
            }
            if (taskItem.Status__c == 'Completed' &&
                projectPlannedEndDate != null &&
                taskItem.End_Date__c > projectPlannedEndDate){
                isOverduetaskInList = true;
            }   
        }
        
        if (!isDraftTaskInList && !isTaskWithoutStatusInList){
            if (isOverduetaskInList) {
                return 'Finished with Delay';
            }else {
                return 'Finished In Time';
            }
        } else {
            return 'Draft';
        } 
    }
}