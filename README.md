This is a karate sample project to run functional and performance tests

PRE-REQUISITE install npm

Clone https://github.com/gothinkster/angular-realworld-example-app Install by 'yarn install'

run this service by 
 'npm start'

- FUNCTIONAL TESTS: From this karate test suite run following

To tests all functional tests

  mvn test

To test only cases taged with @wip and test environment as 'dev'

  mvn test -Dkarate.options="--tags @wip" -Dkarate.env="dev"

  mvn test -Dkarate.options="--tags @wip" -Dkarate.env="performance"

- Performance TESTS:

To run performance tests

  mvn clean test-compile gatling:test

- DOCKER The Docker commands to run the tests

To Start

  docker-compose up --build
To Stop

  docker-compose down      
