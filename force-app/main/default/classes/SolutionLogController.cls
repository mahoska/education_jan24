/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 05-16-2024
 * @last modified by  : Hanna Makhovska
**/
public without sharing class SolutionLogController {
    @AuraEnabled /*(cacheable=true)*/
	public static  List<Solutions_Log__c> getLogsData(String typeLog, String status, String priority, String timeLine, String startDate, String stopDate) {
		List<Solutions_Log__c> logsList = new List<Solutions_Log__c>();
		Date startDateVal = null, stopDateVal = null;
		DateTime startDateValDT = null, stopDateValDT = null;
		if(timeLine != ''){
			logsList = DataAccessor.getSolutionLogs(typeLog, status, priority, timeLine, startDateValDT, stopDateValDT);
		} else {
			try {
				startDateVal = Date.valueOf(startDate);
				stopDateVal = Date.valueOf(stopDate);
				startDateValDT = Date.valueOf(startDateVal);
				//stopDateValDT = Date.valueOf(stopDateVal);
				stopDateValDT = DateTime.newInstanceGmt(stopDateVal, Time.newInstance(23,59,59,0));
				logsList = DataAccessor.getSolutionLogs(typeLog, status, priority, timeLine,  startDateValDT, stopDateValDT);
			} catch(Exception e) {
				Utills.createErrorLog('SolutionLogController', 'getLogsData', e.getLineNumber(), e.getMessage() );
				//return logsList;
			}
		}

		return logsList;
	}

	@AuraEnabled
	public static  Solutions_Log__c changeStatusOrPriorityLog(Id recordId, String status, String priority) {
		if(status != null || priority != null){
			List<Solutions_Log__c> logs = DataAccessor.getLogItem(recordId);
			if(!logs.isEmpty()){
				Solutions_Log__c log = logs[0];
					log.Status__c = status != null ? status : log.Status__c;
					log.Priority__c = priority != null ? priority : log.Priority__c;
				try{
					update log;
				}catch(DmlException e){
					Utills.createErrorLog('SolutionLogController', 'changeStatusLog', e.getLineNumber(), e.getMessage() );
					return null;
				}
				return log;
			}
		}
		return null;
	}
}