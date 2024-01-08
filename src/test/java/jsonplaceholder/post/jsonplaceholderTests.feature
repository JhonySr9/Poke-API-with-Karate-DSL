Feature: Post a Json

  Background:
  Given url baseUrlJson
  Given path 'posts'

  @JsonPostTest001
  Scenario: Post data on Json page
    # Pre-conditions
    * def testData = read('classpath:jsonplaceholder/post/data/jsonData.json')
    And header Content-Type = 'application/json; charset=UTF-8'

    # Test
    When method POST
    And request testData

    # Assert
    Then status 201
    And match response.id == 101

    # Logs
    * karate.log(response)
    * karate.log(testData)

  @JsonPostTest002
  Scenario: Post data on Json page changing the Title
    # Pre-conditions
    * def testData = read('classpath:jsonplaceholder/post/data/jsonData.json')
    And header Content-Type = 'application/json; charset=UTF-8'

    # Modify Data Before Using
    * karate.log(testData)
    * def testDataModified = testData
    * testDataModified.title = "Jose"

    # Test
    When method POST
    And request testDataModified

    # Assert
    Then status 201
    And match response.id == 101

    # Logs
    * karate.log(response)
    * karate.log(testDataModified)