public with sharing class Pattern_Service {
	public static List<Handler> getHandlers(String triggerName) {
		
		List<Handler> handlersList = new List<Handler>();
		Type tmpType;
		Handler handler;
		
		// Retrieve Trigger Handler Assignments
		List<TriggerConfig__mdt> configList = Pattern_Mdt_Accessor.getConfigs(triggerName);
		
		// Create valid handler instances
		for(TriggerConfig__mdt configItem : configList){
			tmpType = Type.forName( configItem.Trigger_Handler_API_Name__c);
			handler = (Handler) tmpType.newInstance();
			handlersList.add(handler);
		}
		
		return handlersList;
	}
	
	public static void executeHandlers(String objectName) {
	
		List<Handler> handlerList = getHandlers(objectName);
		
		for(Handler handler : handlerList) {
			if (Trigger.isBefore ) {
				if (Trigger.isInsert ) {
					handler.onBeforeInsertFunction();
				}
				if (Trigger.isUpdate ) {
					handler.onBeforeUpdateFunction();
				}
				if (Trigger.isDelete ) {
					handler.onBeforeDeleteFunction();
				}
			}
			
			if (Trigger.IsAfter ) {
				if (Trigger.isInsert ) {
					handler.onAfterInsertFunction();
				}
				if (Trigger.isUpdate ) {
					handler.onAfterUpdateFunction();
				}
				if (Trigger.isDelete ) {
					handler.onAfterDeleteFunction();
				}
				if (Trigger.isUnDelete ) {
					handler.onAfterUndeleteFunction();
				}
			}
		}
	}
}