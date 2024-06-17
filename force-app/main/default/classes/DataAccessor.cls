/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 05-16-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class DataAccessor {

    public static List<Solutions_Log__c> getSolutionLogs(String typeLog, String status, String priority, String timeLine, DateTime startDateVal, DateTime stopDateVal){
 
        String query = 'SELECT Classes__c, Comment__c, Line__c, Message__c, Method__c, Priority__c, Status__c, Type__c, CreatedDate, Body__c  '+
                'FROM Solutions_Log__c '+
                'WHERE Type__c = \''+String.escapeSingleQuotes(typeLog)+'\' ';
        if(status != '') {
            query += ' AND Status__c = \''+String.escapeSingleQuotes(status)+'\' ';
        }
        if(priority != '') {
            query += ' AND Priority__c = \''+String.escapeSingleQuotes(priority)+'\' ';
        }
        if(timeLine == 'Today') {
            query += ' AND CreatedDate = TODAY ';
        }else if(timeLine == 'Week'){
            query += ' AND CreatedDate >= LAST_WEEK ';
        }else if(timeLine == 'Month'){
            query += ' AND CreatedDate >= LAST_MONTH ';
        }
        if(startDateVal != null && stopDateVal != null){
            query += ' AND CreatedDate >= '+startDateVal.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'')+
                     ' AND CreatedDate <= '+stopDateVal.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'')+' ';
        }
        query += 'ORDER BY CreatedDate DESC LIMIT 50000';
        System.debug(query);
        return  DataAccessorHelper.getDataFromOrg(query);
    }
 
 
    public static List<Solutions_Log__c> getLogItem(Id logId){
        return DataAccessorHelper.getDataFromOrg(
                        'SELECT  Classes__c, Comment__c, Line__c, Message__c, Method__c, Priority__c, Status__c, Type__c, CreatedDate, Body__c '+
                        'FROM Solutions_Log__c '+
                        'WHERE Id = \''+String.escapeSingleQuotes(logId)+'\' '+
                        'LIMIT 1');
    }
}