@REQ_BTPMCDP-001 @HU001 @consultar_todos_los_personajes @marvel @Agente2 @E2 @iniciativa_marvel
Feature: BTPMCDP-001 Consultar todos los personajes de Marvel (microservicio para obtener personajes)
  Background:
    # Creación previa de personaje para pruebas
    * def random = java.util.UUID.randomUUID().toString().substring(0, 5)
    * def characterCreation = read('classpath:data/marvel/character_creation.json')
    * set characterCreation.name = characterCreation.name + ' _ ' + random
    * url 'https://bp-se-test-cabcd9b246a5.herokuapp.com/ddalmach'
    * path '/api/characters'
    Given request characterCreation
    When method POST
    * print response
    * def createdId = response.id
    * print createdId
    Then status 201
    * path '/api/characters'

  @id:1 @consultarPersonajes @solicitudExitosa200
  Scenario: T-API-BTPMCDP-001-CA01-Consultar todos los personajes exitosamente 200 - karate
    When method GET
    Then status 200
    * print response

  @id:2 @consultarPersonajesPorId
  Scenario: T-API-BTPMCDP-001-CA02-Consultar personajes por Id - karate
    Given path createdId
    When method GET
    Then status 200

  @id:3 @consultarPersonajesPorId @error404
  Scenario: T-API-BTPMCDP-001-CA03-Consultar personajes por id no existente - karate
    Given path 0
    When method GET
    Then status 404

  @id:4 @crearPersonaje @solicitudExitosa200
  Scenario: T-API-BTPMCDP-001-CA01-Crear personaje exitosamente 200 - karate
   * set characterCreation.name = characterCreation.name + ' _ ' + random
    Given request characterCreation
    When method POST
    Then status 201
    * print response

  @id:5 @crearPersonaje @badRequest400
  Scenario: T-API-BTPMCDP-001-CA02-Crear personaje duplicado - karate
    * set characterCreation.name = characterCreation.name + ' _ ' + random
    Given request characterCreation
    When method POST
    Then status 201
    * print response
    Given request characterCreation
    And path '/api/characters'
    When method POST
    Then status 400

  @id:6 @crearPersonaje @badRequest400
  Scenario: T-API-BTPMCDP-001-CA03-Crear personaje faltan campos obligatorios - karate
    * def incompleteCharacter = read('classpath:data/marvel/missing_fields_creation.json')
    Given request incompleteCharacter
    When method POST
    Then status 400

  @id:7 @actualizarPersonaje @exito200
  Scenario: T-API-BTPMCDP-001-CA03-ActualizarPersonaje - karate
    * def random = java.util.UUID.randomUUID().toString().substring(0, 5)
    * def characterCreation = read('classpath:data/marvel/character_creation.json')
    * set characterCreation.name = characterCreation.name + ' _ ' + random
    Given request characterCreation
    When method POST
    Then status 201
    * def createdId = response.id
    * def characterUpdate = read('classpath:data/marvel/update_character.json')
    * set characterUpdate.name = response.name + ' _ ' + random
    Given request characterUpdate
    And path '/api/characters/' + createdId
    When method PUT
    Then status 200

  @id:8 @actualizarPersonaje @notfound404
  Scenario: T-API-BTPMCDP-001-CA03-ActualizarPersonaje no exitoso - karate
    * def random = java.util.UUID.randomUUID().toString().substring(0, 5)
    * def characterCreation = read('classpath:data/marvel/character_creation.json')
    * set characterCreation.name = characterCreation.name + ' _ ' + random
    Given request characterCreation
    When method POST
    Then status 201
    * def nonId = response.id +1
    * def characterUpdate = read('classpath:data/marvel/update_character.json')
    * set characterUpdate.name = characterUpdate.name + ' _ ' + random
    Given request characterUpdate
    And path '/api/characters/' + nonId
    When method PUT
    Then status 404

  @id:9 @eliminarPersonaje @exito200
  Scenario: T-API-BTPMCDP-001-CA03-Borrar personaje - karate
    * def random = java.util.UUID.randomUUID().toString().substring(0, 5)
    * def characterCreation = read('classpath:data/marvel/character_creation.json')
    * set characterCreation.name = characterCreation.name + ' _ ' + random
    Given request characterCreation
    When method POST
    Then status 201
    * def createdId = response.id
    Given  path '/api/characters/' + createdId
    When method DELETE
    Then status 204

  @id:10 @eliminarPersonaje @notfound404
  Scenario: T-API-BTPMCDP-001-CA03-Borrar personaje no existente - karate
    * def random = java.util.UUID.randomUUID().toString().substring(0, 5)
    * def characterCreation = read('classpath:data/marvel/character_creation.json')
    * set characterCreation.name = characterCreation.name + ' _ ' + random
    Given request characterCreation
    When method POST
    Then status 201
    * def nonId = response.id + 1
    Given  path '/api/characters/' + nonId
    When method DELETE
    Then status 404


