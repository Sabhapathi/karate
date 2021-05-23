@ignore
Feature: Connecting with SQL DB
    Background: connect to DB
        * def dbHandler = Java.type('helpers.DBHandler')
    Scenario: Seeed Database with a new job
        * eval dbHandler.addNewJobWithName("QA5")
    Scenario: Get Levels for job
        * def level = dbHandler.getMinAndMaxLevelsForJob("QA5")
        * print level.minLvl
        * print level.maxLvl
        And match level.minLvl == '50'
        And match level.minLvl == '100'