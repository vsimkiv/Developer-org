public class TransportDAO {
    
    // 1. DONE
    public static Integer getNumberOfStops(Id busRouteId){
		Integer numberOfStops = [SELECT COUNT() 
                                 FROM Schedule__c 
                                 WHERE Bus_Route__r.Id =: busRouteId];
       	return numberOfStops;
    }
    
    // 2. DONE
    public static Id getLongestByTimeRouteId(){
		Id longestByTimeRouteId = [SELECT Id, Name, DurationInMinutes__c 
                                        FROM Bus_Route__c
                                        WHERE DurationInMinutes__c != NULL
                                       	ORDER BY DurationInMinutes__c DESC
            							LIMIT 1].Id;
        return longestByTimeRouteId;
	}
    
    // 3. DONE
    public static List<Schedule__c> getSchedules(Integer lim, Integer offset){
		List<Schedule__c> schedules = [SELECT Bus_Route__r.Name, Bus_Stop__r.Name
                                       FROM Schedule__c
                                       ORDER BY Id
                                       LIMIT :lim 
                                       OFFSET :offset];
        return schedules;
	}
    
    // 4. DONE
    public static List<Bus_Stop__c> getBusStopsByIds(Set<Id> busStopIds){
        List<Bus_Stop__c> busStops = [SELECT Name
                                    FROM Bus_Stop__c 
                                    WHERE Id IN :busStopIds];
        return busStops;
    }
        
    //5. DONE
    public static List<Bus_Route__c> getBusRoutes (Set<Id> busStopIds) {      
		// a) get set of BusRoute ids
        List<Schedule__c> scheduleRecords = [SELECT Bus_Route__r.Id
                                             FROM Schedule__c 
                                             WHERE Bus_Stop__r.Id IN :busStopIds];
        
        Set<Id> busRouteIds = new Set<Id>();
        
        for (Schedule__c s : scheduleRecords) {
            busRouteIds.add(s.Bus_Route__r.Id);
        }
        
        // b) get list of BusRoutes using set of ids
        List<Bus_Route__c> busRoutes = [SELECT Id, Name, StartTime__c, EndTime__c
                                       FROM Bus_Route__c
                                       WHERE Id IN :busRouteIds];
        return busRoutes;        
    }
       
    // 6. DONE
    public static Map<Id, Time> getBusRoutesWithMinTime(Integer lim){
        List<Bus_Route__c> busRoutes = [SELECT DurationInMinutes__c 
                                        FROM Bus_Route__c
                                        WHERE DurationInMinutes__c != NULL
                                        ORDER BY DurationInMinutes__c
                                        LIMIT :lim];
        
        Map<Id, Time> resultMap = new Map<Id, Time>();
        
       	for (Bus_Route__c br : busRoutes) {
                resultMap.put(br.Id, TimeUtils.convertMinutesToTime(br.DurationInMinutes__c));
        	}
        
        return resultMap;  
    }
    
    // 7. DONE
    public static Map<Id, Time> getBusRoutesWithMaxTime(Integer lim){
        List<Bus_Route__c> busRoutes = [SELECT DurationInMinutes__c 
                                        FROM Bus_Route__c
                                        WHERE DurationInMinutes__c != NULL
                                        ORDER BY DurationInMinutes__c DESC
                                        LIMIT :lim];
        
        Map<Id, Time> resultMap = new Map<Id, Time>();
   		
        for (Integer i = 0; i < lim; i++) {
             resultMap.put(busRoutes[i].Id, TimeUtils.convertMinutesToTime(busRoutes[i].DurationInMinutes__c));
        }

        return resultMap;
    }
    
    //for VisualForce page
    public static List<Schedule__c> getSchedulesForCurrentBusStop(Bus_Stop__c busStop){
		List<Schedule__c> schedules = [SELECT Name, Bus_Route__r.RouteNumber__c, Time__c
                                       FROM Schedule__c
                                       WHERE Bus_Stop__c =: busStop.Id
                                       ORDER BY Time__c];
        return schedules;
	}
    
    
    //for Lightning component
    public static List<Bus_Route__c> getAllBusRoutes() {
        List<Bus_Route__c> routes = [SELECT RouteNumber__c, TotalStops__c, DurationInMinutes__c 
                                     FROM Bus_Route__c
                                    ORDER BY DurationInMinutes__c];
        return routes;
    }
}