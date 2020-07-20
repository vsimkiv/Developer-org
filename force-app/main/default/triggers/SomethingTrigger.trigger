trigger SomethingTrigger on Something__c (before insert, before update, before delete, after insert,  after update,  after delete, after undelete){
	Pattern_API.executeHandlers('Something__c');
    
    /* Turn off trigger using Custom Metadata as Admin
    if (SomethingTriggerHandler.isActive()){
        if (Trigger.isBefore) { 
            if (Trigger.isInsert) {
            } else if (Trigger.isUpdate) {
            } else if (Trigger.isDelete) {   
            }
        } else if (Trigger.isAfter) {
            if (Trigger.isInsert) {     
            } else if (Trigger.isUpdate) {
            } else if (Trigger.isDelete) {
            } else if (Trigger.isUnDelete) {
            }
        }
    }
	*/
}