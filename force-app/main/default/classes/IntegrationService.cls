public class IntegrationService {
    //DONE
    public static String makeCallout(String lastName){
        String toReturn = '';
        
        Http http = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://teammembergenerator.herokuapp.com/teammate');
        req.setMethod('GET');
        req.setHeader('lastName', lastName);
        
        HttpResponse resp = http.send(req);
        if (resp.getStatusCode() == 200) {
            toReturn = resp.getBody();
        }
        
        System.debug(toReturn);
        return toReturn;
    }
    
    //DONE
    public static String getAccessToken () {
        String token = 'no token :(';

        String CLIENT_ID = '3MVG91BJr_0ZDQ4tMApg9CWYF2OK7xqsuYfJ3ztXR02lWx92_cantd4CiXLWg60mez7gHIA3RDwwet3BTuepq';
        String CLIENT_SECRET = 'E7F18C66F4375C86E4E760A201BFCEF8614A70441478F70EB063B034FF481035';
        String USERNAME = 'simkiv.it@gmail.com';
        String PASSWORD = '24ssff06qTCGniH4DETOTQeI7nvg7PdVY';
        
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');  
        req.setHeader('Content-Type','application/x-www-form-urlencoded');
        req.setEndpoint('https://totalizator-dev-ed.my.salesforce.com/services/oauth2/token');
        
         
        req.setBody('grant_type=password' + '&client_id='+CLIENT_ID + 
            '&client_secret='+CLIENT_SECRET + '&username='+USERNAME + '&password='+PASSWORD);
        
        Http http = new Http(); 
        HttpResponse resp = http.send(req);
        
        try {
            String body = resp.getBody();
        	System.debug('Body ' + body);
        	//deserialize JSON    
            Map<String, Object> ssMap = (Map<String, Object>) JSON.deserializeUntyped(body);
            token = (String) ssMap.get('access_token');
        } catch (System.CalloutException e) {
            System.debug(e.getMessage());
        }
        
 		System.debug(token);
        return token;
    }
    
    //DONE
    public static List<Account> getAccounts(String accessToken, Id accountId){
        List<Account> accounts = new List<Account>();
        
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');  
        req.setHeader('Authorization', 'Bearer ' + accessToken);
       
        req.setEndpoint('https://totalizator-dev-ed.my.salesforce.com/services/data/v46.0/sobjects/Account/' + accountId);
        
        Http http = new Http();         	
       	HttpResponse resp = http.send(req);
        
        try	{
            String body = resp.getBody();
        	System.debug(body);
        	//deserialize JSON
        	Account acc = (Account) JSON.deserialize(body, Account.class); 
        	System.debug(acc.Name);
        	accounts.add(acc);
        } catch (System.CalloutException e) {
            System.debug(e.getMessage());
        }
        
        return accounts;
    }
}