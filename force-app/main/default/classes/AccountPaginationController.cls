global class AccountPaginationController {
    @AuraEnabled 
    global static Account[] getAccounts() {
        return [SELECT Name, Industry, AnnualRevenue 
                FROM Account
                ORDER BY Name
                LIMIT 200];
    }
}