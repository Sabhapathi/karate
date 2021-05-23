Feature: Add likes

    Background: Define URL
        Given url apiUrl
    
    Scenario: Add likes
        And path 'articles',slug,'favorite'
        And request "{}"
        When method Post
        Then status 200
        * def likesCount = response.article.favoritesCount