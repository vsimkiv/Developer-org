trigger ScheduleTrigger on Schedule__c (after insert, before update, after update, after delete) {
    if (Trigger.isBefore) { 
        if (Trigger.isInsert) {
        } else if (Trigger.isUpdate) {
            ScheduleTriggerUtils.preventChangingTime(ScheduleTriggerUtils.checkTimeUpdates(Trigger.new, Trigger.old));
        } else if (Trigger.isDelete) {
            
        }
        
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            ScheduleTriggerUtils.updateStartEndTimes(Trigger.new);
            if (ScheduleTriggerUtils.isFirstTime) {
                ScheduleTriggerUtils.isFirstTime=false;
                ScheduleTriggerUtils.calcTimeToNextStop(Trigger.new);
            }
            
        } else if (Trigger.isUpdate) {
            ScheduleTriggerUtils.updateStartEndTimes(Trigger.new);
            if (ScheduleTriggerUtils.isFirstTime) {
                ScheduleTriggerUtils.isFirstTime=false;
                ScheduleTriggerUtils.calcTimeToNextStop(Trigger.new);
            }
        } else if (Trigger.isDelete) {
            ScheduleTriggerUtils.updateStartEndTimes(Trigger.old);
            if (ScheduleTriggerUtils.isFirstTime) {
                ScheduleTriggerUtils.isFirstTime=false;
                ScheduleTriggerUtils.calcTimeToNextStop(Trigger.old);
            }
        }
    }
}