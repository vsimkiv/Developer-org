public class Pattern_API {
    public static boolean isPatternTurnedOn = true;

	public static List<Handler> getHandlers(String triggerName) {
		List<Handler> handlersList= new List<Handler>();
        	if (isPatternTurnedOn) {
        		handlersList = Pattern_Service.getHandlers(triggerName);
		}
		return handlersList;
	}
	
	public static void executeHandlers(String triggerName) {
		if (isPatternTurnedOn) {
			Pattern_Service.executeHandlers(triggerName);
		}
	}
}