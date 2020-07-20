public virtual class HandlerImpl implements Handler {
	
	public virtual void onBeforeInsertFunction() {
	}
	
	public virtual void onBeforeUpdateFunction() {
	}
	
	public virtual void onBeforeDeleteFunction() {
	}
	
	public virtual void onAfterInsertFunction() {
        System.debug('I am handler impl function');
	}
	
	public virtual void onAfterUpdateFunction() {
	}
	
	public virtual void onAfterDeleteFunction() {
	}
	
	public virtual void onAfterUndeleteFunction() {
	}
}