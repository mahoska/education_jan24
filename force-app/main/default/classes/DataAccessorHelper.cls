/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 05-16-2024
 * @last modified by  : Hanna Makhovska
**/
public  class DataAccessorHelper {
    public static List<SObject> getDataFromOrg(String queryString) {
        SObject[] sobjectList = new SObject[]{};
        try {
 
            sobjectList = Database.query(queryString);
           
            // if(Test.isRunningTest()) {
            //     throw new QueryException('Error for Test');
            // }
        } catch(QueryException exc) {
            /* Can TODO alert email for the Administrator */
            Utills.createConsoleLog('QueryException > DataAccessorHelper.getDataFromOrg() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage() + ' Stack Trace: ' + exc.getStackTraceString());
            Utills.createErrorLog('DataAccessorHelper', 'getDataFromOrg', exc.getLineNumber(), 'Error Message: ' + exc.getMessage());
           
            if ( !Trigger.isExecuting ) {
                throw new AuraHandledException('QueryException > DataAccessorHelper.getDataFromOrg() >>> on line ' + exc.getLineNumber() + ' >>> Error Message: ' + exc.getMessage() + ' Stack Trace: ' + exc.getStackTraceString());
            }
        }
       
        return sobjectList;
    } 
}