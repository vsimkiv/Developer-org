public class TransportServices {
    //1 DONE
    public static SaveResult createStop (String name, String address) {
        SaveResult result = new SaveResult();
         
        try{
            Bus_Stop__c stop = new Bus_Stop__c(Name=name, Address__c=address);   
        	insert(stop);
            result.stopId = stop.Id;
            result.isSuccess = true;
        }catch (DmlException e){
           	result.isSuccess = false;
            result.errorMessage = e.getMessage();
        }
       	
        System.debug(result);
        return result;
    }
    
    //2 DONE
    public static SaveResultAStSh addStopToSchedule (Id busRouteId, Id busStopId, Time timeValue) {
        SaveResultAStSh result = new SaveResultAStSh();
        List<Schedule__c> scheduleList = new List<Schedule__c>();
        
        Schedule__c record = new Schedule__c(Bus_Route__c=busRouteId, Bus_Stop__c=busStopId, Time__c=timeValue);
        scheduleList.add(record);
        
        try{
        	insert(scheduleList);
            result.scheduleId = scheduleList[0].Id;
           	result.isSuccess = true;
        }catch (DmlException e){
            result.isSuccess = false;
            result.errorMessage = e.getMessage();
        }

		System.debug(result);        
        return result;
    }    
    
    //3 DONE
    public static SaveResultUScT updateScheduleTimes(List<ScheduleTimeHelper> helpers){
        SaveResultUScT result = new SaveResultUScT();
        
        //transform list of helper objects into Map
        Map<Id, Time> newValues = new Map<Id, Time> ();
        for (ScheduleTimeHelper sth : helpers){
             newValues.put(sth.scheduleId, sth.timeValue);
        }

        //find records to update
        List<Schedule__c> recordsToUpdate =[SELECT Time__c
                                            FROM Schedule__c 
                                            WHERE Id IN :newValues.keySet()];
        
        
        // fill up oldTimes list
        List<Time> oldTimes = new List<Time>();
        
        for (Schedule__c record : recordsToUpdate) {
        	oldTimes.add(record.Time__c);
            record.Time__c = newValues.get(record.Id);
        }
        
        try{
        	update(recordsToUpdate);
            result.oldTimes = oldTimes;
           	result.isSuccess = true;
        }catch (Exception e){
            result.isSuccess = false;
            result.errorMessage = e.getMessage();
        }
        
        return result;
    }
    
    
    //4 DONE
    public static SaveResultDSt deleteBusStop (Id busStopId ) {
        SaveResultDSt result = new SaveResultDSt();
        List<Schedule__c> schedulesForDelete = [SELECT Id 
                                             	FROM Schedule__c
                                             	WHERE Bus_Stop__c =: busStopId];
        
        Bus_Stop__c stopForDelete = [SELECT Id 
                                     FROM Bus_Stop__c
                                     WHERE Id =: busStopId];
        
        Integer numberOfSchedulesBefore = [SELECT COUNT() FROM Schedule__c];
         
        if (!schedulesForDelete.isEmpty()){
           delete(schedulesForDelete);
           Integer numberOfSchedulesAfter = [SELECT COUNT() FROM Schedule__c]; 
           
            if(stopForDelete != null){
        		try {
            		delete(stopForDelete);
            		result.numberOfDeletedSchedules = numberOfSchedulesBefore - numberOfSchedulesAfter;
           			result.isSuccess = true;
        		}catch (Exception e){
            		result.isSuccess = false;
            		result.errorMessage = e.getMessage();
        		}
        	}else {
            	System.debug('Stop to delete is not found');
        	}
        }else {
            System.debug('No records in schedule to delete');
        }
        
        return result;
    }    
}