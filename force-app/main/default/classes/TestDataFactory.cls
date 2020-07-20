@IsTest
public class TestDataFactory {
    
    public static Bus_Stop__c createBusStop (String name, String address) {
        Bus_Stop__c bs = new Bus_Stop__c();
        bs.Name = name;
        bs.Address__c = address;
        return bs;
    }
    
    public static List<Bus_Stop__c> createBusStopList (Integer size) {
        List<Bus_Stop__c> busStopList = new List<Bus_Stop__c>();
        
        Integer currentSize = 0;
        
        while (currentSize < size) {
            busStopList.add(createBusStop('Test name' + currentSize, 'Test address' + currentSize));
            currentSize++;
        }
        
        insert(busStopList);
        
        return busStopList;
    }
    
    public static Bus_Route__c createBusRoute (String routeNumber, Time startTime, Time endTime) {
        Bus_Route__c br = new Bus_Route__c();
        br.RouteNumber__c = routeNumber;
        br.StartTime__c = startTime;
        br.EndTime__c = endTime;
        return br;
    }
    
    public static List<Bus_Route__c> createBusRouteList () {
        List<Bus_Route__c> busRouteList = new List<Bus_Route__c>();
        
        busRouteList.add(createBusRoute('1',
                                        Time.newInstance(6, 0, 0, 0),
                                        Time.newInstance(7, 30, 0, 0)));
        
        busRouteList.add(createBusRoute('2',
                                        Time.newInstance(7, 0, 0, 0),
                                        Time.newInstance(9, 30, 0, 0)));
        
        busRouteList.add(createBusRoute('3A',
                                        Time.newInstance(10, 0, 0, 0),
                                        Time.newInstance(11, 15, 0, 0)));
        busRouteList.add(createBusRoute('54', 
                                        null, 
                                        null));
        
        insert(busRouteList);

        return busRouteList;
    }
        
    public static Schedule__c createSchedule (Bus_Route__c bRoute, Bus_Stop__c bStop) {
        Schedule__c record = new Schedule__c();
        record.Bus_Route__c = bRoute.Id; 
        record.Bus_Stop__c = bStop.Id;
        return record;
    }

    
    
    //just for fun methods
    public static List<Bus_Route__c> createBusRouteListForFun (Integer size) {
        List<Bus_Route__c> busRouteList = new List<Bus_Route__c>();
        
        Integer currentSize = 0;
        
        while (currentSize < size) {
            busRouteList.add(createBusRoute((
                currentSize + 100) + 'N', 
               	generateRandomTime(),
                generateRandomTime()
                                            .addHours(Integer.valueOf((Math.random() * 4)))
                                            .addMinutes(Integer.valueOf((Math.random() * 59)))));
            currentSize++;
        }
        
        insert(busRouteList);

        return busRouteList;
    }

    //XZ
    public static void generateAllTestData() {
        List <Bus_Stop__c> busStopList = createBusStopList(3);
        List <Bus_Route__c> busRouteList = createBusRouteList();
        List<Schedule__c> scheduleList = new List<Schedule__c>();
        
        for (Bus_Stop__c st : busStopList) {
           	scheduleList.add(TestDataFactory.createSchedule(busRouteList[0], st));
        }
       
        insert(scheduleList);
        
    }
    
    public static Time generateRandomTime () {
        Integer randomHour = Integer.valueOf((Math.random() * 24));
        Integer randomMinute = Integer.valueOf((Math.random() * 60));
        Integer randomSecond = Integer.valueOf((Math.random() * 60));
        Integer randomMillisecond = Integer.valueOf((Math.random() * 1000));
        
        return Time.newInstance(randomHour, randomMinute, randomSecond, randomMillisecond);
    }
    
    public static List<Time> createTimeList(Integer size) {
        List<Time> timeList = new List<Time>();
        
        Integer currentSize = 0;
        
        while (currentSize < size) {
            timeList.add(generateRandomTime());
            currentSize++;
        }
        
        for (Time item : timeList) {
            System.debug(item);
        }
        
        return timeList;
    }
}