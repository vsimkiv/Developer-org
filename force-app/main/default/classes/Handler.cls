global interface Handler {
	
	void onBeforeInsertFunction();
	
	void onBeforeUpdateFunction();
	
	void onBeforeDeleteFunction();
	
	void onAfterInsertFunction();
	
	void onAfterUpdateFunction();
	
	void onAfterDeleteFunction();

	void onAfterUndeleteFunction();
}