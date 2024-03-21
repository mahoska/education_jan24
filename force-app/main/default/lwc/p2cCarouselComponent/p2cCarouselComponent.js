import { LightningElement, api } from 'lwc';

export default class P2cCarouselComponent extends LightningElement {
    @api carouselItems;
    @api cardHeading;
}