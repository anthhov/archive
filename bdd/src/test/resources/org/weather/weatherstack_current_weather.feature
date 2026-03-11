Feature: Testing JSON provided by weatherstack API on current weather request.
  User requests current weather in different cities via weatherstack API.
  The JSON result returned by weatherstack server should contain correct values.

  Scenario Outline: Data retrieval from weatherstack
    When We get information about weather in <city>

    Then The request->type from the result should match one in <known_information>
    Then The request->language from the result should match one in <known_information>
    Then The request->query from the result should match one in <known_information>
    Then The request->unit from the result should match one in <known_information>

    Then The location->name from the result should match one in <known_information>
    Then The location->country from the result should match one in <known_information>
    Then The location->region from the result should match one in <known_information>
    Then The location->lat from the result should match one in <known_information>
    Then The location->lon from the result should match one in <known_information>
    Then The location->timezone_id from the result should match one in <known_information>
    Then The location->localtime from the result should match one in <known_information>
    Then The location->localtime_epoch from the result should match one in <known_information>
    Then The location->utc_offset from the result should match one in <known_information>

    Then The current->observation_time from the result should match one in <known_information>
    Then The current->temperature from the result should match one in <known_information>
    Then The current->weather_code from the result should match one in <known_information>
    Then The current->weather_descriptions->0 from the result should match one in <known_information>
    Then The current->wind_speed from the result should match one in <known_information>
    Then The current->wind_degree from the result should match one in <known_information>
    Then The current->wind_dir from the result should match one in <known_information>
    Then The current->pressure from the result should match one in <known_information>
    Then The current->precip from the result should match one in <known_information>
    Then The current->humidity from the result should match one in <known_information>
    Then The current->cloudcover from the result should match one in <known_information>
    Then The current->feelslike from the result should match one in <known_information>
    Then The current->uv_index from the result should match one in <known_information>
    Then The current->visibility from the result should match one in <known_information>
    Then The current->is_day from the result should match one in <known_information>

    # Our goal here is to provide ANY values.
    # In real life we would assert variable parameters (like localtime) match some defined format, not hardcoded values
    Examples:
      | city      | known_information                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
      | New York  | {"request":{"type":"City","query":"New York, United States of America","language":"en","unit":"m"},"location":{"name":"New York","country":"United States of America","region":"New York","lat":"40.714","lon":"-74.006","timezone_id":"America\/New_York","localtime":"2020-01-01 00:00","localtime_epoch":0000000000,"utc_offset":"-4.0"},"current":{"observation_time":"10:42 AM","temperature":19,"weather_code":116,"weather_icons":["https:\/\/cdn.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0002_sunny_intervals.png"],"weather_descriptions":["Partly cloudy"],"wind_speed":6,"wind_degree":60,"wind_dir":"ENE","pressure":1017,"precip":0,"humidity":70,"cloudcover":75,"feelslike":19,"uv_index":5,"visibility":16,"is_day":"yes"}} |
      | Moscow    | {"request":{"type":"City","query":"Moscow, Russia","language":"en","unit":"m"},"location":{"name":"Moscow","country":"Russia","region":"Moscow City","lat":"55.752","lon":"37.616","timezone_id":"Europe\/Moscow","localtime":"2020-01-01 00:00","localtime_epoch":0000000000,"utc_offset":"3.0"},"current":{"observation_time":"01:12 PM","temperature":22,"weather_code":113,"weather_icons":["https:\/\/cdn.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0001_sunny.png"],"weather_descriptions":["Sunny"],"wind_speed":7,"wind_degree":30,"wind_dir":"NNE","pressure":1016,"precip":0,"humidity":29,"cloudcover":0,"feelslike":23,"uv_index":6,"visibility":10,"is_day":"yes"}}                                                              |
      | Hong Kong | {"request":{"type":"City","query":"Hong Kong, Hong Kong","language":"en","unit":"m"},"location":{"name":"Hong Kong","country":"Hong Kong","region":"","lat":"22.283","lon":"114.150","timezone_id":"Asia\/Hong_Kong","localtime":"2020-01-01 00:00","localtime_epoch":0000000000,"utc_offset":"8.0"},"current":{"observation_time":"01:12 PM","temperature":30,"weather_code":116,"weather_icons":["https:\/\/cdn.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0004_black_low_cloud.png"],"weather_descriptions":["Partly cloudy"],"wind_speed":20,"wind_degree":190,"wind_dir":"S","pressure":1006,"precip":0,"humidity":75,"cloudcover":25,"feelslike":40,"uv_index":1,"visibility":10,"is_day":"no"}}                                         |
      | Tallinn   | {"request":{"type":"City","query":"Tallinn, Estonia","language":"en","unit":"m"},"location":{"name":"Tallinn","country":"Estonia","region":"Harjumaa","lat":"59.434","lon":"24.728","timezone_id":"Europe\/Tallinn","localtime":"2020-01-01 00:00","localtime_epoch":0000000000,"utc_offset":"3.0"},"current":{"observation_time":"01:13 PM","temperature":25,"weather_code":113,"weather_icons":["https:\/\/cdn.worldweatheronline.com\/images\/wsymbols01_png_64\/wsymbol_0001_sunny.png"],"weather_descriptions":["Sunny"],"wind_speed":17,"wind_degree":50,"wind_dir":"NE","pressure":1017,"precip":0,"humidity":36,"cloudcover":0,"feelslike":26,"uv_index":6,"visibility":10,"is_day":"yes"}}                                                            |
