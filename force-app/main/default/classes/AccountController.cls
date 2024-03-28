/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-28-2024
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

   
    /*public static void updateAvgCaseResolutionDays(List<Id> accountIdList){
         // check if there are any accounts
         if(accountIdList.size()>0){
            Map<Id,List<Case>> caseByAccMap =  new  Map<Id,List<Case>>();

            List<Account> accListRes = new List<Account>();
            
            // retrive all the cases for this account
            // get resolution days for each account (ClosedDate - CreatedDate)
            for(Case caseObj : [SELECT Id, CreatedDate, ClosedDate, AccountId  
                                 FROM Case
                                 WHERE IsClosed=true
                                    AND AccountId IN :accountIdList]){

                if(caseByAccMap.containsKey(caseObj.AccountId)) {
                    List<Case> cases = caseByAccMap.get(caseObj.AccountId);
                    cases.add(caseObj);
                    caseByAccMap.put(caseObj.AccountId, cases);
                } else {
                    caseByAccMap.put(caseObj.AccountId, new List<Case>{caseObj});
                }                       
            }    

            for(Id accId : accountIdList){
                Integer totalDays = 0, totalCases = 0;
                 // get list of cases for this account
                //List<Case> caseList = caseByAccMap.get(accId);
                for(Case caseObj : caseByAccMap.get(accId)){
                    // increase number of cases
                    totalCases++;
                    // get duration in days and add it to totalDays
                    totalDays += caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
                }
                Decimal resolutionDays = totalDays/totalCases;
                Account acc = new Account(Id=accId, Avg_Case_Resolution_Days__c = resolutionDays);
                accListRes.add(acc);
            } 
                update accListRes;
            }
          
        }*/
        
        public static void updateAvgCaseResolutionDays(List<Id> accountIds){
            Map<Id, Integer> accountTotalCaseMap = new Map<Id, Integer>();
            Map<Id, Integer> accountTotalCaseDaysMap = new Map<Id, Integer>();
            // retrive all the cases for all accounts
            // get resolution days for each account (ClosedDate - CreatedDate)
            for(Case caseObj : [SELECT Id, AccountId, CreatedDate, ClosedDate
                                 FROM Case
                                 WHERE IsClosed=true
                                  AND AccountId IN :accountIds]){
        
                // if map does not have current account, then add it
                if(! accountTotalCaseMap.containsKey(caseObj.AccountId)){
                    accountTotalCaseMap.put(caseObj.AccountId, 0);
                    accountTotalCaseDaysMap.put(caseObj.AccountId, 0);
                }
        
                // increase number of cases
                Integer totalCases = accountTotalCaseMap.get(caseObj.AccountId);
                accountTotalCaseMap.put(caseObj.AccountId, totalCases+1);
        
                // get duration in days and add it to totalDays
                Integer totalDays = accountTotalCaseDaysMap.get(caseObj.AccountId);
                accountTotalCaseDaysMap.put(caseObj.AccountId, totalDays+caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date()));
            }
            // list of accounts to update
            List<Account> accountsToUpdate = new List<Account>();
        
            // iterate over the map to update all accounts
            for(Id accountId : accountTotalCaseMap.keySet()){
                Decimal resolutionDays = accountTotalCaseDaysMap.get(accountId)/accountTotalCaseMap.get(accountId);
                // update account object
                accountsToUpdate.add(new Account(Id=accountId, Avg_Case_Resolution_Days__c = resolutionDays));
            }
            update accountsToUpdate;
        }
    }

