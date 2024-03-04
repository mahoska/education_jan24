import { LightningElement } from 'lwc';
import LOCALE from '@salesforce/i18n/locale';
import CURRENCY from '@salesforce/i18n/currency';
import DIR from '@salesforce/i18n/dir';
export default class Internationalization extends LightningElement {
    number = 6575557.86;
    dir = 'rtl';//DIR;
    formattedNumber = new Intl.NumberFormat(LOCALE, {
        style:'currency',
        currency:CURRENCY,
        currencyDisplay:'symbol'
    }).format(this.number);
    formattedNumber1 = new Intl.NumberFormat('ar-EG', {
        style:'currency',
        currency:'USD',
        currencyDisplay:'symbol'
    }).format(this.number);
}