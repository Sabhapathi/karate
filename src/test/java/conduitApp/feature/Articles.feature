
Feature: Articles

    Background: Define URL
        * url apiUrl
        * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    Scenario: Create a new article
        And path 'articles'
        And request articleRequestBody
        When method Post
        Then status 200
        And match response.article.title == 'Bla bla'
   