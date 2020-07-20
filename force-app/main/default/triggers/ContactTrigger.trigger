trigger ContactTrigger on Contact (before insert, before update, 
                                   after insert, after update, after delete, after undelete) {
    if (Trigger.isBefore && Trigger.isUpdate) {
        System.debug('Hello from Trigger');
        ContactTriggerHandler.updateAccountStatus(Trigger.new);
    }

}