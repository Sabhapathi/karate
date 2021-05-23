Feature: HomeWork
    Background: preconditions
        * url apiUrl
    Scenario: Favorite Articles
        Given path 'articles'
        And params  { limit: 10, offset: 0 }
        When method Get
        Then status 200
        * def articleId = response.articles[0].slug
        * def initialfavCount = response.articles[0].favoritesCount

        And path 'articles',articleId,'favorite'
        And request "{}"
        When method Post
        Then status 200

        Given path 'articles',articleId
        When method Get
        Then status 200
        And match response.article.favoritesCount == initialfavCount + 1
    # Scenario: Unfavorite the article
        Given path 'articles',articleId,'favorite'
        And request "{}"
        When method Post
        Then status 200

    # Scenario: Get all favorite feeds of user
        * def isValidTime = read('classpath:helpers/timeValidator.js')
        Given path 'articles'
        And params  { limit: 10, offset: 0, favorited: "karatesaba1" }
        When method Get
        Then status 200
        And match each response.articles ==
        """
            {
                "title": "#string",
                "slug": "#string",
                "body": "#string",
                "createdAt": "#? isValidTime(_)",
                "updatedAt": "#? isValidTime(_)",
                "tagList": "#array",
                "description": "#string",
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": '#boolean'
                },
                "favorited": '#boolean',
                "favoritesCount": '#number'
            }
        """
        And match response.articles[0].slug == articleId