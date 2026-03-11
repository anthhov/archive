Feature: Testing Errors provided by weatherstack API on wrong requests.
  User makes a wrong API request.
  The JSON result returned by weatherstack server should contain correct error message.

  Scenario: API request failure
    When User requests current weather for "WrongCity"
    Then User gets error 615

  Scenario: User specifies invalid unit
    When User requests current weather for "Moscow" and sets units to "a"
    Then User gets error 606

  Scenario: User specifies invalid access key
    When User requests current weather for "Moscow" and sets access_key to "wrongkey"
    Then User gets error 101

  Scenario: User uses function unavailable in current subscription plan
    When User with free account requests current weather for "Moscow" and sets language to "ar"
    Then User gets error 105
