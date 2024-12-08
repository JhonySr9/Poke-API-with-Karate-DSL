Feature: Get a Pokemon

  Background:

    Given url baseUrlPokemon

    # Data
    * def pokemonTypesData = read('classpath:pokemon/get/pokemonExamples/types/types.json')

    # Functions
    * def randomIndex = numbers.randomNumber(pokemonTypesData.results.length);
    * def randomType = pokemonTypesData.results[randomIndex]

    # Paths
    * def pokemonPath = 'pokemon/'
    * def typePath = 'type/'

  @smoke @functional @sanity
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
    * karate.log(response.abilities[0].ability.name)
    * karate.log(response.abilities[1].ability.name)
    * karate.log(response.types[0].type.name)

    Examples:
      | pokemonName | ability_1   | ability_2     | type     | name       |
      | pikachu     | static      | lightning-rod | electric | pikachu    |
      | pidgeotto   | keen-eye    | tangled-feet  | normal   | pidgeotto  |
      | ditto       | limber      | imposter      | normal   | ditto      |
      | charizard   | blaze       | solar-power   | fire     | charizard  |
      | charmeleon  | blaze       | solar-power   | fire     | charmeleon |
      | ekans       | intimidate  | shed-skin     | poison   | ekans      |
      | raichu      | static      | lightning-rod | electric | raichu     |
      | wartortle   | torrent     | rain-dish     | water    | wartortle  |
      | beedrill    | swarm       | sniper        | bug      | beedrill   |
      | pidgeot     | keen-eye    | tangled-feet  | normal   | pidgeot    |
      | caterpie    | shield-dust | run-away      | bug      | caterpie   |
      | rattata     | run-away    | guts          | normal   | rattata    |

  @smoke @functional @sanity
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

  @functional @sanity
  Scenario: Get all Pokemon Types
    #Test
    Given path typePath
    When method GET
    Then status 200
    And match response == pokemonTypesData

    #logs
    * karate.log(response)

  @functional @sanity
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

  @sanity
  Scenario: Get a random Pokemon Type
  # Test
    Given path typePath + randomType.name
    When method GET
    Then status 200
    And match response.name == randomType.name
    * def pokemonType = randomType.name

  # Logs
    * karate.log('randomIndex: ' + randomIndex)
    * karate.log('randomType.name: ' + randomType.name)
    * karate.log('response.name: ' + response.name)

  @sanity
  Scenario: Use a random Pokemon Type from another Test
  # Pre-condition
    * call read('classpath:pokemon/get/pokemonTests.feature@Pokemon_GetARandomPokemon_Type')

  # Retrieve the variable from the feature context
    * def pokemonTypesData = read('classpath:pokemon/get/pokemonExamples/types/types.json')
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

  @sanity
  # test
  Scenario Outline: Get an specific ability (cut), to see if <pokemonName> can learn it
    Given path pokemonPath + '<pokemonName>'
    When method GET
    Then status 200
    And match response.moves[*].move.name contains "cut"

    # logs
    * karate.log(response)

    Examples:
      | pokemonName |
      | rattata     |
      | latias      |
      | kecleon     |
      | sableye     |
      | charizard   |


  @sanity
  Scenario: Get an specific Pokemon using its name from an array
    Given path pokemonPath
    When method GET
    Then status 200
    * def result = $response.results[?(@.name == 'bulbasaur')].url
    * def value = result[0]
    * match value == "https://pokeapi.co/api/v2/pokemon/1/"
    * print result

  @Pokemon_GetARandomPokemon_Type
  Scenario: Pokemon - Call - Get a random Pokemon Type
  # Test
    Given path typePath + randomType.name
    When method GET
    Then status 200
    * def pokemonType = randomType.name
