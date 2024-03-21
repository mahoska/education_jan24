import { LightningElement } from 'lwc';
import CAROUSEL_IMAGES from '@salesforce/resourceUrl/carousel';
export default class CustomCarouselWrapper extends LightningElement {

    slides = [
        {
            image:`${CAROUSEL_IMAGES}/carousel/photo1.jpg`,
            heading:'Caption one',
            description:'You can add description of first slide'
        },
        {
            image:`${CAROUSEL_IMAGES}/carousel/photo2.jpg`,
            heading:'Caption two',
            description:'You can add description of second slide'
        },
        {
            image:`${CAROUSEL_IMAGES}/carousel/photo3.jpg`,
            heading:'Caption three',
            description:'You can add description of third slide'
        },
    ]
}