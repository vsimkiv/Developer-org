public class PaginationUtils {
    static Integer batchNumber = 1;
    static final Integer BATCH_SIZE = 50;
    
    public static List<Contact> getOneBatch() { 
        Integer offset = (batchNumber-1) * BATCH_SIZE;
        
        List<Contact> batch =  [SELECT Name, Account.Name, Email, Birthdate 
                                FROM Contact
                                ORDER BY Name
                                LIMIT :BATCH_SIZE
                                OFFSET :offset];
        
        if (batch.size() != 0) {
            batchNumber++;
        }
        
        return batch;
    }
}