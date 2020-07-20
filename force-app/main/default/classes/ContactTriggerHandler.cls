public class ContactTriggerHandler {
    public static void updateAccountStatus(List<Contact> contacts){
        Set<Id> accIds = new Set<Id>(); 
        
        for (Contact c : contacts) {
            accIds.add(c.AccountId);
        }
        
        Map<Id, Account> accountsToUpdate = new Map<Id, Account> ([SELECT Id, Status__c 
                                                                   FROM Account 
                                                                   WHERE Id IN :accIds]);
        
        
        for (AggregateResult item : [SELECT AccountId, COUNT(Id) 
                                     FROM Contact
                                     WHERE AccountId IN :accIds
                                     GROUP BY AccountId]) {
                                         
                                         Integer numberOfContacts = (Integer)item.get('expr0');
                                         Id accId = (Id)item.get('AccountId');
                                         
                                         if(numberOfContacts > 4) {
                                             accountsToUpdate.get(accId).Status__c = 'Completed';
                                         }else {
                                             accountsToUpdate.get(accId).Status__c = 'Draft';
                                         }
                                     }
        List<Account> l =  accountsToUpdate.values();
        System.debug(l.size());
        for (Account a : l) {
            System.debug(a.Id + '-------' + a.Status__c);
        }
        
        try{
            update(l);
            System.debug('hello for try');
        }catch (DmlException e){
            System.debug(e.getMessage());
        }
        
    }
    
    
    
}