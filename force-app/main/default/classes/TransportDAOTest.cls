@IsTest
private class TransportDAOTest {
	//1 - DONE
    @IsTest
    static void getNumberOfStopsTest() {
        List <Bus_Stop__c> busStopList = TestDataFactory.createBusStopList(3);
        List <Bus_Route__c> busRouteList = TestDataFactory.createBusRouteList();
        List<Schedule__c> scheduleList = new List<Schedule__c>();
        
        for (Bus_Stop__c st : busStopList) {
           	scheduleList.add(TestDataFactory.createSchedule(busRouteList[0], st));
        }
       
        insert(scheduleList);
        System.assertEquals(3, TransportDAO.getNumberOfStops(busRouteList[0].Id));
    }
    
    //2 - DONE
    @IsTest
    static void getLongestByTimeRouteIdTest() {
        List<Bus_Route__c> busRouteList = TestDataFactory.createBusRouteList();        
        System.assertEquals(busRouteList[1].Id, TransportDAO.getLongestByTimeRouteId());
    }
    
    //3 - DONE
    @IsTest
    static void getSchedulesTest() {
        List <Bus_Stop__c> busStopList = TestDataFactory.createBusStopList(3);
        List <Bus_Route__c> busRouteList = TestDataFactory.createBusRouteList();
        List<Schedule__c> scheduleList = new List<Schedule__c>();
        
        for (Bus_Stop__c st : busStopList) {
           	scheduleList.add(TestDataFactory.createSchedule(busRouteList[0], st));
        }
       
        insert(scheduleList);
        List<Schedule__c> scheduleListWithIds = [SELECT Id 
                                                 FROM Schedule__c 
                                                 ORDER BY Id];

        System.assertEquals(scheduleListWithIds[2].Id, TransportDAO.getSchedules(1,2)[0].Id);
    }
    
    //4 - DONE
    @IsTest
    static void getBusStopsByIdsTest() {
        List <Bus_Stop__c> busStopList = TestDataFactory.createBusStopList(4);

        List<Bus_Stop__c> busStops = [SELECT Id 
                                      FROM Bus_Stop__c 
                                      ORDER BY Id];
        Set<Id> ids = new Set<Id>();
        ids.add(busStops[0].Id);
        ids.add(busStops[3].Id);

        System.assertEquals(2, TransportDAO.getBusStopsByIds(ids).size());
    }
    
    //5 - DONE
    @IsTest
    static void getBusRoutesTest() {
        List <Bus_Stop__c> busStopList = TestDataFactory.createBusStopList(4);
        List <Bus_Route__c> busRouteList = TestDataFactory.createBusRouteList();
        List<Schedule__c> scheduleList = new List<Schedule__c>();
        
        for (Bus_Stop__c st : busStopList) {
           	scheduleList.add(TestDataFactory.createSchedule(busRouteList[0], st));
        }
       
        insert(scheduleList);
        List<Bus_Stop__c> scheduleListWithIds = [SELECT Id 
                                                 FROM Bus_Stop__c 
                                                 ORDER BY Id];
        Set<Id> ids = new Set<Id>();
        ids.add(scheduleListWithIds[0].Id);
        ids.add(scheduleListWithIds[1].Id);
        ids.add(scheduleListWithIds[3].Id);

        System.assertEquals(1, TransportDAO.getBusRoutes(ids).size());
    }
    
    
    // 6 - DONE
    @IsTest
    static void getBusRoutesWithMinTimeTest() {
        List <Bus_Route__c> busRouteList = TestDataFactory.createBusRouteList();
        
        Map<Id, Time> expectedMin = new Map<Id, Time>();
        expectedMin.put(busRouteList[2].Id, Time.newInstance(1, 15, 0, 0));
        expectedMin.put(busRouteList[0].Id, Time.newInstance(1, 30, 0, 0));
        
        System.assertEquals(expectedMin, TransportDAO.getBusRoutesWithMinTime(2));
        System.assertEquals(expectedMin, TransportDAO.getBusRoutesWithMinTime(2));
    }
    
    // 7 - DONE
    @IsTest
    static void getBusRoutesWithMaxTimeTest() {
        List <Bus_Route__c> busRouteList = TestDataFactory.createBusRouteList();
        
        Map<Id, Time> expectedMax = new Map<Id, Time>();
        expectedMax.put(busRouteList[1].Id, Time.newInstance(2, 30, 0, 0));
        expectedMax.put(busRouteList[0].Id, Time.newInstance(1, 30, 0, 0));

        System.assertEquals(expectedMax, TransportDAO.getBusRoutesWithMaxTime(2));
    }
}