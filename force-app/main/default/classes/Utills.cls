/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 05-16-2024
 * @last modified by  : Hanna Makhovska
**/
public  class Utills {
    public static Boolean isTriggerExecuted = false;

	/**
	* Method for create an info log.
	* @parameter className - Classes where the event occcurs.
	* @parameter method - Method where the event occcurs.
	* @parameter line - Line where the event occcur.
	* @parameter message - Event message.
	* @parameter type - Event type.
	*/

	
	public static void createLog(String className, String method, Integer line, String message, String type) {
		Solutions_Log__c newLog = new Solutions_Log__c(
				Classes__c = className,
				Method__c = method,
				Line__c = line,
				Message__c = message,
				Type__c = type,
				Status__c = 'New'
		);

		try {

			insert newLog;

		} catch (DmlException exc) {
			/* Can TODO alert email for the Administrator */
			Utills.createConsoleLog('DmlException > Utills.createLog() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage());
		}
	}

	/**
	* Method for create an error log.
	* @parameter className - Classes where the error occcurs.
	* @parameter method - Method where the error occcurs.
	* @parameter line - Line where the error occcur.
	* @parameter message - Error message.
	*/
	public static void createErrorLog(String className, String method, Integer line, String message) {
		Utills.createLog(className, method, line, message, 'ERROR');
	}

	/**
	* Method for create an info log.
	* @parameter className - Classes where the info occcurs.
	* @parameter method - Method where the info occcurs.
	* @parameter line - Line where the info occcur.
	* @parameter message - Information message.
	*/
	//Not used now
	// public static void createInfoLog(String className, String method, Integer line, String message) {
	//     Utills.createLog(className, method, line, message, 'INFO');
	// }

	public static void createConsoleLog(String message) {
		System.debug(message);
	}

}
