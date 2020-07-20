public with sharing class SomethingTriggerHandler extends HandlerImpl {
    
    public static Boolean isActive(){
        List<TriggerConfig__mdt> triggerConfig = [SELECT Trigger_API_Name__c, Trigger_Handler_API_Name__c, isActive__c
                                                  FROM TriggerConfig__mdt
                                                  WHERE Trigger_API_Name__c = 'SomethingTrigger'];
        
        if (triggerConfig.get(0)!= null) {
            return triggerConfig.get(0).isActive__c;
        }else {
            return true;
        }    
    }
    
    public override void onAfterInsertFunction() {
        System.debug('I am something trigger handler function');
    }
}