public class ScheduleTriggerUtils{
    static final Decimal ROUTE_DURATION_IN_MINUTES_LIMIT = 120;
    public static Boolean isFirstTime  = true;
    
    //1. AFTER
    public static void updateStartEndTimes (List<Schedule__c> inputList){
        
        List<Id> busRouteIdList = new List<Id>();
        for (Schedule__c item : inputList) {
            busRouteIdList.add(item.Bus_Route__c);
        }
        
        List<Bus_Route__c> busRoutesToUpdate = [SELECT StartTime__c, EndTime__c
                                                FROM Bus_Route__c
                                                WHERE Id IN :busRouteIdList];
        
        for (Bus_Route__c item : busRoutesToUpdate) {
            item.StartTime__c = calcStartTime(item.Id);
            item.EndTime__c = calcEndTime(item.Id);
        }
        
        try{
            update(busRoutesToUpdate);
        }catch (DmlException e){
            System.debug(e.getMessage());
        }
    }
    
    //2. BEFORE UPDATE. DISLIKE ACTUAL SOLUTION
    public static void preventChangingTime(List<Schedule__c> inputList) {         	
        Set<Id> busRouteIds = new Set<Id>();
        
        for (Schedule__c item : inputList){
            busRouteIds.add (item.Bus_Route__c);
        }
        
        List<Bus_Route__c> tooLongBusRoutes = [SELECT Name, DurationInMinutes__c
                                               FROM Bus_Route__c
                                               WHERE Id IN :busRouteIds
                                               AND DurationInMinutes__c > :ROUTE_DURATION_IN_MINUTES_LIMIT];
        
        if (!tooLongBusRoutes.isEmpty()) {
            Set<Id> tooLongBusRoutesIds = new Set<Id>();
            for (Bus_Route__c br : tooLongBusRoutes) {
                tooLongBusRoutesIds.add(br.Id);
            }
            for (Schedule__c item : inputList){
                if (tooLongBusRoutesIds.contains(item.Bus_Route__c)){
                    item.addError('Route duration is more than 2 hours');
                }
            }
        }
    }
    
    //3. 
    public static void calcTimeToNextStop(List<Schedule__c> inputList){
        List<Id> busRouteIdList = new List<Id>();
        
        for (Schedule__c item : inputList) {
            busRouteIdList.add(item.Bus_Route__c);
        }
        
        //all schedules which need some updates                                                              
        List<Schedule__c> schedulesToUpdate = [SELECT Id, Time__c, TimeToNextStop__c
                                               FROM Schedule__c
                                               WHERE Bus_Route__c IN :busRouteIdList
                                               AND Time__c != NULL
                                               ORDER BY Time__c];
        
        for (Integer i = 0; i<schedulesToUpdate.size(); i++) { 
            if (i != schedulesToUpdate.size()-1){
                Decimal timeToNextStop = TimeUtils.subtractTimeInMinutesDecimal(
                    schedulesToUpdate[i].Time__c, schedulesToUpdate[i+1].Time__c);
                System.debug(timeToNextStop);
                schedulesToUpdate[i].TimeToNextStop__c = timeToNextStop;
            } else {
                schedulesToUpdate[i].TimeToNextStop__c = 0; //for last stop of route
            }       
        }
        
        try{
            update(schedulesToUpdate);
        }catch (DmlException e){
            System.debug(e.getMessage());
        }
    }
    
    //for ScheduleTriggerUtils - 1
    public static Time calcEndTime(Id busRouteId){      
        Time endTime = [SELECT Time__c
                        FROM Schedule__c
                        WHERE Bus_Route__c =: busRouteId
                        ORDER BY Time__c DESC
                        LIMIT 1].Time__c;
        return endTime;
    }
    
    public static Time calcStartTime(Id busRouteId){
        Time startTime = [SELECT Time__c
                          FROM Schedule__c
                          WHERE Bus_Route__c =: busRouteId
                          ORDER BY Time__c
                          LIMIT 1].Time__c;     
        return startTime;
    }
    
    
    //UTIL for Trigger-2 check if Time__c is changed
    public static List<Schedule__c> checkTimeUpdates (List<Schedule__c> listNew, List<Schedule__c> listOld) {
        List<Schedule__c> listToPreventUpdate = new List<Schedule__c>();
        
        for(Schedule__c itemNew : listNew) {
            for (Schedule__c itemOld : listOld) {
                if ((itemNew.Id == itemOld.Id) && (itemNew.Time__c != itemOld.Time__c)) {
                    listToPreventUpdate.add(itemNew);
                }
            }
        }
        
        return listToPreventUpdate;
    }
}