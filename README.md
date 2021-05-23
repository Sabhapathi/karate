# karate

This is a karate sample project to run functional and performance tests

PRE-REQUISITE
install npm

Clone https://github.com/gothinkster/angular-realworld-example-app
Install by 'yarn install'

run this service by 'npm start'


FUNCTIONAL TESTS:
From this karate test suite run following
1. To tests all functional tests
    mvn test 
2. To test only cases taged with @wip and test environment as 'dev'
    mvn test -Dkarate.options="--tags @wip" -Dkarate.env="dev"
    
    
Performance TESTS:
To run performance tests
    mvn clean test-compile gatling:test
