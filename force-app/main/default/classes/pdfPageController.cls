/**
 * @description       : 
 * @author            : Hanna Makhovska
 * @group             : 
 * @last modified on  : 03-12-2024
 * @last modified by  : Hanna Makhovska
**/
public with sharing class pdfPageController {
    public String pdfText{get;set;}
    public pdfPageController() {
        pdfText = String.escapeSingleQuotes(
            ApexPages.currentPage().getParameters().get('pdfText')
        );
    }
}