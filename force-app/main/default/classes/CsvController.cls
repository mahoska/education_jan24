/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-13-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class CsvController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        return [SELECT Id, Name, Phone, AnnualRevenue, Industry FROM Account];
    }
}