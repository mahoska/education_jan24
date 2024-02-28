import { LightningElement } from 'lwc';

export default class SetterDemoParentComponent extends LightningElement {
    userDetail={
        'name':'Martin',
        'age':25
    };

    xdata = [{"name":"a"}, {"name":"b"}, {"name":"c"}]
}