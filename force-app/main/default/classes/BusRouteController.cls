public class BusRouteController {
    @AuraEnabled
    public static List<Bus_Route__c> retrieveRoutes() {
        return TransportDAO.getAllBusRoutes();
    }
}