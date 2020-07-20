public class BusStopControllerExtension {
    private final Bus_Stop__c busStop;
    
    public BusStopControllerExtension(ApexPages.StandardController stdController) {
        this.busStop = (Bus_Stop__c)stdController.getRecord();
    }
     
    public List<Schedule__c> getSchedule(){
        return TransportDAO.getSchedulesForCurrentBusStop(busStop);
    }
}