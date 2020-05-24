var Jasmine = require('jasmine'),
    reporters = require('jasmine-reporters');
var junitReporter = new reporters.JUnitXmlReporter({
    savePath: 'target',
    consolidateAll: false
});
var jasmine = new Jasmine();
jasmine.loadConfigFile("jasmine.json");
jasmine.addReporter(junitReporter);
jasmine.defaultTimeoutInterval = 10000;
jasmine.execute();