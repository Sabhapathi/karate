
Feature: HomeWork
    Background: preconditions
        * url apiUrl
         * def dataGenerator = Java.type('helpers.DataGenerator')
        * def isValidTime = read('classpath:helpers/timeValidator.js')
        * def randomComment = dataGenerator.getRandomComment()
    Scenario: Get All Articles
        Given path 'articles'
        And params  { limit: 10, offset: 0 }
        When method Get
        Then status 200
        * def articleId = response.articles[0].slug
        Given path 'articles',articleId,'comments'
        When method Get
        Then status 200
        * def initialNoOfComments = response.comments.length
        And match each response.comments ==
        """
            {
                "id": '#number',
                "createdAt": "#? isValidTime(_)",
                "updatedAt": "#? isValidTime(_)",
                "body": "#string",
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "##string",
                    "following": '#boolean'
                }
            }
        """
        * def initialNoOfComments = response.comments.length

        And path 'articles',articleId,'comments'
        And request {"comment": {"body": #(randomComment)}} 
        When method Post
        Then status 200
        * def commentId = response.comment.id
        Given path 'articles',articleId,'comments'
        When method Get
        Then status 200
        * def finalNoOfComments = response.comments.length       
        # And match response.comments.length == initialNoOfComments+1
        
        Given path 'articles',articleId,'comments',commentId
        When method Delete
        Then status 200
        # And match response.comments.length == initialNoOfComments