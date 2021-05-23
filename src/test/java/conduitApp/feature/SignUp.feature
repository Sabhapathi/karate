Feature: Signup to Conduit
    Background: Preconditions
        * def dataGenerator = Java.type('helpers.DataGenerator')
        * def isValidTime = read('classpath:helpers/timeValidator.js')
        * def randomEmail = dataGenerator.getRandomEmail()
        * def randomUsername = dataGenerator.getRandomUsername()
        Given url apiUrl

    Scenario: New User Signup
        Given path 'users'
        And request 
        """
        {
            "user": {
                "email": #(randomEmail),
                "password": "Karate123",
                "username": #(randomUsername)
            }
        }
        """
        When method Post
        Then status 200
        And match response ==
        """
            {
                "user": {
                "id": "#number",
                "email": #(randomEmail),
                "createdAt": "#? isValidTime(_)",
                "updatedAt": "#? isValidTime(_)",
                "username": #(randomUsername),
                "bio": "##string",
                "image": "##string",
                "token": "#string"
                }
            }
        """

    Scenario Outline: Validate Sign up error messages
            Given path 'users'
            And request 
            """
            {
                "user": {
                    "email": "<email>",
                    "password": "<password>",
                    "username": "<username>"
                }
            }
            """
            When method Post
            Then status 422
            And match response == <errorResponse>
    Examples:
        |email                  | password        | username          | errorResponse                                         |
        |#(randomEmail)         | Karate123       | KarateUser123     | {"errors":{"username":["has already been taken"]}}   |
        | karateUser1@test.com  | Karate123       | #(randomUsername) | {"errors":{"email":["has already been taken"]}}     |
        | KarateUser123         | Karate123       | #(randomUsername) | {"errors":{"email":["is invalid"]}}      |
        | #(randomEmail)        | Karate123       | KarateUser123123123123123123 | {"errors":{"username":["is too long (maximum is 20 characters)"]}}      |
        | #(randomEmail)        | kar             | #(randomUsername) | {"errors":{"password":["is too short (minimum is 8 characters)"]}}      |
        |                       | Karate123       | #(randomUsername) | {"errors":{"email":["can't be blank"]}}      |
        | #(randomEmail)        |                 | #(randomUsername) | {"errors":{"password":["can't be blank"]}} |
        | #(randomEmail)        | Karate123       |                   | {"errors":{"username":["can't be blank","is too short (minimum is 1 character)"]}} |
