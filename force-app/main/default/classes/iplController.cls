/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 07-08-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class iplController {

    //Base Url Constant
    private static final String BASE_URl = 'https://raw.githubusercontent.com/karkranikhil/responses/main/';    

    @AuraEnabled(cacheable=true) 
    public static String fetchCricketData(String fileName) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        //set up the request
        request.setEndpoint(BASE_URl+fileName);
        request.setMethod('GET');

        try{
            //Send the HTTP request and get the response
            HttpResponse response  = http.send(request);
            //check the response status code
            if(response.getStatusCode() == 200){
                return response.getBody();
            }else{
                String errorMsg = 'Failed to fetch data. HTTP Status is: '+response.getStatusCode();
                System.debug('Error:'+ errorMsg);
                throw  new AuraHandledException(errorMsg);
            }
        }catch(Exception e){
            //logany exception sthrow during the http request
            String errorMsg = 'Exception occureed while fetching data: '+e.getMessage();
            System.debug('Error:'+ errorMsg);
            throw  new AuraHandledException(errorMsg);
        }
    }
}