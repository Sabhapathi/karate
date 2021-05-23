@ignore
Feature: Create and Delete Article

    Background: Define URL
         * url apiUrl
         * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
         * def dataGenerator = Java.type('helpers.DataGenerator')
         * set articleRequestBody.article.title = __gatling.Title
         * set articleRequestBody.article.description = __gatling.Description
         * set articleRequestBody.article.body = __gatling.Description

         * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
         * def pause = karate.get('__gatling.pause', sleep)
        
     Scenario: Create and Delete article
      #   * def articleValues = dataGenerator.getRandomArticleValues()
         * configure headers = {"Authorization": #('Token ' + __gatling.token)}
         Given path 'articles'
         And request articleRequestBody
         And header karate-name = 'Create Article'
         When method Post
         Then status 200
         * def articleId = response.article.slug
         # And match response.article.title == articleValues.title

         * pause(5000)

         Given path 'articles',articleId
         And header karate-name = 'Delete Article'
         When method Delete
         Then status 200

   