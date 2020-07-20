public class Pattern_Mdt_Accessor {
    public static List<TriggerConfig__mdt> getConfigs(String triggerName) {
        return [SELECT Trigger_API_Name__c, Trigger_Handler_API_Name__c, isActive__c
                FROM TriggerConfig__mdt
                WHERE Trigger_API_Name__c =: triggerName
                AND IsActive__c = true];     
    }   
}