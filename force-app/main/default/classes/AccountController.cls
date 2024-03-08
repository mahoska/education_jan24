/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-08-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class AccountController {
   
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(){
        return [SELECT Id, Name, Type, Industry FROM  Account LIMIT 5]; 
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> filterAccountByType(String type){
        return [SELECT Id, Name, Type, Industry FROM Account WHERE Type=:type LIMIT 5]; 
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey){
        String key = '%'+searchKey+'%';
        return [SELECT Id, Name, Type, Industry FROM Account WHERE Name LIKE :key LIMIT 5]; 
    }

}