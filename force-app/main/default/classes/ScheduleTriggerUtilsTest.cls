@IsTest
private class ScheduleTriggerUtilsTest {

    @IsTest
    public static void preventChangingTimeTest() {
        List <Bus_Stop__c> busStopList = TestDataFactory.createBusStopList(2);
        List <Bus_Route__c> busRouteList = TestDataFactory.createBusRouteList();
        List<Schedule__c> schedules = new List<Schedule__c>();

        for (Bus_Stop__c st : busStopList) {
            schedules.add(TestDataFactory.createSchedule(busRouteList[1], st));
        }

        for (Bus_Stop__c st : busStopList) {
            schedules.add(TestDataFactory.createSchedule(busRouteList[0], st));
        }

        insert(schedules);

        //update is prevented
        List<Schedule__c> updatePrevented = new List<Schedule__c>();
        schedules[0].Time__c = Time.newInstance(10, 10, 0, 0);
        updatePrevented.add(schedules[0]);

        Boolean isPrevented = true;
//        try {
            ScheduleTriggerUtils.preventChangingTime(updatePrevented);
            isPrevented = false;
//        } catch (Exception e) {
//            isPrevented = true;
//        }

//        System.assert(isPrevented);

        //update is OK
//        List<Schedule__c> updateSuccessful = new List<Schedule__c>();
 //       schedules[2].Time__c = Time.newInstance(10, 10, 0, 0);
 //       updatePrevented.add(schedules[2]);

/*
        Boolean isOk = true;

        try {
            ScheduleTriggerUtils.preventChangingTime(updatePrevented);
            isOk = true;
        } catch (Exception e) {
            isOk = false;
        }

        System.assert(isOk);
*/
    }

    @IsTest
    public static void calcTimeToNextStopTest() {

    }

}