@IsTest
private class TransportServicesTest {
    //1 - DONE
    @IsTest
    static void createStopTest () {
        
        
        System.assert(TransportServices.createStop('A stop', 'A street').isSuccess);
        System.assert(!TransportServices.createStop('too long string value too long string value' +
                                                   'too long string value too long string value' +
                                                   'too long string value too long string value' + 
                                                   'too long string value too long string value' + 
                                                   'too long string value too long string value', 'A street').isSuccess);
    }
    
    //2 - DONE
    @IsTest
    static void addStopToScheduleTest () {
        List<Bus_Stop__c> stops = TestDataFactory.createBusStopList(1);
        List<Bus_Route__c> routes = TestDataFactory.createBusRouteList();
        
        System.assert(TransportServices.addStopToSchedule(routes[0].Id, stops[0].Id, Time.newInstance(5, 55, 0, 0)).isSuccess);
   		System.assert(!TransportServices.addStopToSchedule(Id.valueOf('a023X00001qk9BzQAI'), stops[0].id, Time.newInstance(5, 55, 0, 0)).isSuccess);

    }
    
    //3 - DONE
    @IsTest
    static void updateScheduleTimesTest () {
        List <Bus_Stop__c> busStopList = TestDataFactory.createBusStopList(1);
        List <Bus_Route__c> busRouteList = TestDataFactory.createBusRouteList();
        List<Schedule__c> scheduleList = new List<Schedule__c>();
        
        for (Bus_Stop__c st : busStopList) {
           	scheduleList.add(TestDataFactory.createSchedule(busRouteList[0], st));
        }
        
        insert(scheduleList);
        
        List<ScheduleTimeHelper> helpers = new List<ScheduleTimeHelper>();
        ScheduleTimeHelper h = new ScheduleTimeHelper();
        h.scheduleId = [SELECT Id FROM Schedule__c LIMIT 1].Id;
        h.timeValue = Time.newInstance(22, 22, 22, 0);
        helpers.add(h);
        
    	System.assert(TransportServices.updateScheduleTimes(helpers).isSuccess);
        
    }
    
    //4 - DONE
    @IsTest
    static void deleteBusStop() {
        List <Bus_Stop__c> busStopList = TestDataFactory.createBusStopList(2);
        List <Bus_Route__c> busRouteList = TestDataFactory.createBusRouteList();
        List<Schedule__c> scheduleList = new List<Schedule__c>();

        for (Bus_Stop__c st : busStopList) {
            scheduleList.add(TestDataFactory.createSchedule(busRouteList[0], st));
        }

        insert(scheduleList);

        TransportServices.deleteBusStop(busStopList[0].Id);

        Integer size = [SELECT COUNT()
                        FROM Bus_Stop__c];

        System.assertEquals(1, size);

    }
}