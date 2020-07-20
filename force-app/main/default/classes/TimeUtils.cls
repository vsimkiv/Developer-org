public class TimeUtils {
    public static Time calculateMinimumTime(List<Time> timeList){
        Time minTime = timeList[0];
        for (Time item : timeList) {
            if (item < minTime) {
                minTime = item;
            }
        }
        
        return minTime;  
    }
    
    public static Time calculateMaximumTime(List<Time> timeList){
        Time maxTime = timeList[0];
        for (Time item : timeList) {
            if (item > maxTime) {
                maxTime = item;
            }
        }
        
        return maxTime;  
    }
    
    //for TransportDAO 6-7 
    public static Time convertMinutesToTime(Decimal minutes) {
        Time t = Time.newInstance(0, Integer.valueOf(minutes), 0, 0);
        return t;
    }

    //for ScheduleTriggerUtils - 3
    public static Decimal subtractTimeInMinutesDecimal (Time earlier, Time later ) {
        Integer ea = earlier.hour()*60 + earlier.minute();
        Integer la = later.hour()*60 + later.minute();
        
        return la - ea;
    }
}