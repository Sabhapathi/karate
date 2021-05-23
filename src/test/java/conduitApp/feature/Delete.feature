@wip
Feature: Delete Article

    Background: Define URL
         * url apiUrl
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
        * def dataGenerator = Java.type('helpers.DataGenerator')
     
        
        Scenario: Delete an article
        * def articleValues = dataGenerator.getRandomArticleValues()
        And path 'articles'
        And request 
        """
           {
               "article": {
                  "tagList": [],
                  "title": #(articleValues.title),
                  "description": #(articleValues.description),
                  "body": #(articleValues.body)
               }
            }
                     
        """
        When method Post
        Then status 200
        And match response.article.title == articleValues.title
        * def articleId = response.article.slug

        And path 'articles',articleId
        When method Delete
        Then status 200

   