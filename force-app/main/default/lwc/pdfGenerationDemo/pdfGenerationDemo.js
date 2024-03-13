import { LightningElement, api } from 'lwc';
import generatePDF from '@salesforce/apex/pdfController.generatePDF';
export default class PdfGenerationDemo extends LightningElement {
    @api recordId;
    
    imageUrl = 'https://lh3.googleusercontent.com/fpBE8bfZw1aTBeN3GnlPIfNzw0nLr_sPgh6bgIVvnQ43tzGi9-f1UBzcZXsN2Kl1t2dLywmlqZXGwc3belMNTMmxZLljGWDdU8Fhkb4o=rw-e365-w2880-v1';
    invoiceData = {
        invoiceNo:'123',
        invoiceCreated:'January 1, 2019',
        invoiceDue:'January 10, 2020',
        companyName:'Sparksuite Inc.',
        address1:'12345 Black Road',
        address2:'Blackville, CA 12345'
    };
    clientData={
        client:'Arme Corp',
        userName:'John Doe',
        email:'john@examplle.com'
    };
    services=[
        {name:'Consultant fee', amount:10000.00},
        {name:'Website design', amount:300.00},
        {name:'Hostng (3months)', amount:75.00},
    ];


    get totalAmount(){
        return this.services.reduce((total, service)=>{
            return total = total + service.amount;
        }, 0);
    }

    pdfHandler(){
        let content = this.template.querySelector('.container');
        console.log(content.outerHTML);
        generatePDF( {recordId:this.recordId,  htmlData:content.outerHTML}).then(result=>{
            console.log('attachment id: ', result);
            window.open(`https://platform-innovation-2866-dev-ed.scratch.file.force.com/servlet/servlet.FileDownload?file=${result.Id}`);
        }).catch(error=>{
            console.error(error);
        })
    }
}