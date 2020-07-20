@IsTest
private class TimeUtilsTest {
    @IsTest
    static void calculateMinimumAndMaximumTimeTest(){
        Time time1 = Time.newInstance(22, 10, 12, 555);
        Time time2 = Time.newInstance(23, 11, 22, 355);
        Time time3 = Time.newInstance(1, 9, 21, 455);
        Time time4 = Time.newInstance(0, 0, 0, 1);

        List<Time> timeList = new List<Time>();
        timeList.add(time1);
        timeList.add(time2);
        timeList.add(time3);
        timeList.add(time4);

        System.assertEquals(time4, TimeUtils.calculateMinimumTime(timeList));
        System.assertEquals(time2, TimeUtils.calculateMaximumTime(timeList));
    }
    
    @IsTest
    static void subtractTimeInMinutesDecimalTest () {
        //case 1: 2nd time parameter is later
        Time time1 = Time.newInstance(10, 30, 0, 0);
        Time time2 = time1.addMinutes(10);
        System.assertEquals(10, TimeUtils.subtractTimeInMinutesDecimal(time1, time2));
        
        //case 2: 2nd time parameter is earlier 
        System.assertEquals(-10, TimeUtils.subtractTimeInMinutesDecimal(time2, time1));
    } 
}