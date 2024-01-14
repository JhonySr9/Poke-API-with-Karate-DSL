Feature: Get a Pokemon

  Background:

    Given url baseUrl

    #Functions
    * def randomNumber =
    """
    function(max)
    { return Math.floor(Math.random() * max) }
    """

    #Paths
    * def pokemonPath = 'pokemon/'
    * def typePath = 'type/'

  @PokemonGet001
  #test
  Scenario Outline: Get a Pokemon by Name
    Given path pokemonPath + '<pokemonName>'
    When method GET
    Then status 200
    And match response.abilities[0].ability.name == '<ability_1>'
    And match response.abilities[1].ability.name == '<ability_2>'
    And match response.types[0].type.name == '<type>'
    And match response.name == '<name>'

    #logs
    * karate.log(response)

    Examples:
      | pokemonName | ability_1 | ability_2     | type     | name      |
      | pikachu     | static    | lightning-rod | electric | pikachu   |
      | pidgeotto   | keen-eye  | tangled-feet  | normal   | pidgeotto |
      | ditto       | limber    | imposter      | normal   | ditto     |
      | charizard   | blaze     | solar-power   | fire     | charizard |

  @PokemonGet002
  Scenario Outline: Get a Pokemon by ID
    #test
    Given path pokemonPath + '<id>'
    When method GET
    Then status 200
    And match response.name == '<name>'
    And match response.id == <id>

    #logs
    * karate.log(response)

    Examples:
      | id  | name       |
      | 25  | pikachu    |
      | 17  | pidgeotto  |
      | 132 | ditto      |
      | 6   | charizard  |
      | 1   | bulbasaur  |
      | 2   | ivysaur    |
      | 3   | venusaur   |
      | 4   | charmander |

  @PokemonGet003
  Scenario: Get all Pokemon Types
    #Pre-condition
    * def testData = read('classpath:pokemon/get/pokemonExamples/types/types.json')

    #Test
    Given path typePath
    When method GET
    Then status 200
    And match response == testData

    #logs
    * karate.log(response)

  @PokemonGet004
  Scenario Outline: Get all Pokemon from <type> type.
    #Pre-condition
    * def <testType> = read('classpath:pokemon/get/pokemonExamples/types/types_' + '<type>' + '.json')

    #Test
    Given path typePath + '<type>'
    When method GET
    Then status 200
    And match response.pokemon == <testType>.pokemon

    #logs
    * karate.log(response)

    Examples:
      | type     | testType       |
      | normal   | types_normal   |
      | fighting | types_fighting |
      | flying   | types_flying   |
      | poison   | types_poison   |
      | ground   | types_ground   |
      | rock     | types_rock     |
      | bug      | types_bug      |

  @PokemonGet005
  Scenario: Get a random Pokemon Type
  # Pre-condition
    * def testData = read('classpath:pokemon/get/pokemonExamples/types/types.json')

  # Functions
    * def randomNumber =
    """
    function(max) {
      return Math.floor(Math.random() * max);
    }
    """

    * def randomIndex = eval(randomNumber + '; randomNumber(testData.results.length)')
    * def randomData = testData.results[randomIndex]

  # Test
    Given path typePath + randomData.name
    When method GET
    Then status 200
    And match response.name == randomData.name
    * def pokemonType = randomData.name


  # Logs
    * karate.log('randomIndex: ' + randomIndex)
    * karate.log('randomData.name: ' + randomData.name)
    * karate.log('response.name: ' + response.name)
    * karate.log(response)

  @PokemonGet006
  Scenario: Use a random Pokemon Type from another Test
  # Pre-condition
    * call read('classpath:pokemon/get/pokemonTests.feature@PokemonGet005')

  # Retrieve the variable from the feature context
    * def testData = read('classpath:pokemon/get/pokemonExamples/types/types.json')
    * def pokemonType = karate.get('pokemonType')

  # Test
    Given path typePath + pokemonType
    When method GET
    Then status 200
    And match response.name == pokemonType

  # Logs
    * karate.log('pokemonType: ' + pokemonType)
    * karate.log('response.name: ' + response.name)
    * karate.log(response)

  @PokemonGet007
  # test
  Scenario Outline: Get an specific ability (cut), to see if <pokemon> can learn it
    Given path pokemonPath + '<pokemonName>'
    When method GET
    Then status 200
    And match response.moves[*].move.name contains "cut"

    # logs
    * karate.log(response)

    Examples:
      | pokemon   | pokemonName |
      | Rattata   | rattata     |
      | Latias    | latias      |
      | Kecleon   | kecleon     |
      | Sableye   | sableye     |
      | Charizard | charizard   |
