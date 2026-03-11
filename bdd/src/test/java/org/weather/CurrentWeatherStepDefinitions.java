package org.weather;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import io.cucumber.java.After;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.fail;

public class CurrentWeatherStepDefinitions {
    private String testedValue;
    private JsonObject rootObject;
    private String currentCity;
    JsonParser jp = new JsonParser();
    private String expectedValue;

    StringBuffer verificationErrors = new StringBuffer();

    @When("We get information about weather in {}")
    public void weGetInformationAboutWeatherIn(String city) throws IOException {
        URL url =new URL("http://api.weatherstack.com/current?" +
                "access_key=a8986a63ae4474d7a8ff511a2be47a2b&query=" + city);
        URLConnection request = url.openConnection();
        request.connect();

        JsonElement root = jp.parse(new InputStreamReader((InputStream) request.getContent()));
        rootObject = root.getAsJsonObject();

        currentCity = city;
    }

    @Then("The request->type from the result should match one in {}")
    public void theRequestTypeFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("request").get("type").getAsString();
        testedValue = rootObject.getAsJsonObject("request").get("type").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected request->type to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The request->language from the result should match one in {}")
    public void theRequestLanguageFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("request").get("language").getAsString();
        testedValue = rootObject.getAsJsonObject("request").get("language").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected request->language to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The request->query from the result should match one in {}")
    public void theRequestQueryFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("request").get("query").getAsString();
        testedValue = rootObject.getAsJsonObject("request").get("query").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected request->query to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The request->unit from the result should match one in {}")
    public void theRequestUnitFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("request").get("unit").getAsString();
        testedValue = rootObject.getAsJsonObject("request").get("unit").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected request->unit to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The location->name from the result should match one in {}")
    public void theLocationNameFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("location").get("name").getAsString();
        testedValue = rootObject.getAsJsonObject("location").get("name").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected location->name to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The location->country from the result should match one in {}")
    public void theLocationCountryFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("location").get("country").getAsString();
        testedValue = rootObject.getAsJsonObject("location").get("country").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected location->country to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The location->region from the result should match one in {}")
    public void theLocationRegionFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("location").get("region").getAsString();
        testedValue = rootObject.getAsJsonObject("location").get("region").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected location->region to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The location->lat from the result should match one in {}")
    public void theLocationLatFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("location").get("lat").getAsString();
        testedValue = rootObject.getAsJsonObject("location").get("lat").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected location->lat to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The location->lon from the result should match one in {}")
    public void theLocationLonFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("location").get("lon").getAsString();
        testedValue = rootObject.getAsJsonObject("location").get("lon").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected location->lon to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The location->timezone_id from the result should match one in {}")
    public void theLocationTimezone_idFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("location").get("timezone_id").getAsString();
        testedValue = rootObject.getAsJsonObject("location").get("timezone_id").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected location->timezone_id to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The location->localtime from the result should match one in {}")
    public void theLocationLocaltimeFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("location").get("localtime").getAsString();
        testedValue = rootObject.getAsJsonObject("location").get("localtime").getAsString();
        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected location->localtime to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The location->localtime_epoch from the result should match one in {}")
    public void theLocationLocaltime_epochFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("location").get("localtime_epoch").getAsString();
        testedValue = rootObject.getAsJsonObject("location").get("localtime_epoch").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected location->localtime_epoch to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The location->utc_offset from the result should match one in {}")
    public void theLocationUtc_offsetFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("location").get("utc_offset").getAsString();
        testedValue = rootObject.getAsJsonObject("location").get("utc_offset").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected location->utc_offset to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->observation_time from the result should match one in {}")
    public void theCurrentObservation_timeFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("observation_time").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("observation_time").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->observation_time to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->temperature from the result should match one in {}")
    public void theCurrentTemperatureFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("temperature").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("temperature").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->temperature to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->weather_code from the result should match one in {}")
    public void theCurrentWeather_codeFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("weather_code").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("weather_code").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->weather_code to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->weather_descriptions->{int} from the result should match one in {}")
    public void theCurrentWeather_descriptionsFromTheResultShouldMatchOneIn(int index, String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current")
                .getAsJsonArray("weather_descriptions").get(index).getAsString();
        testedValue = rootObject.getAsJsonObject("current")
                .getAsJsonArray("weather_descriptions").get(index).getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->weather_description to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->wind_speed from the result should match one in {}")
    public void theCurrentWind_speedFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("wind_speed").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("wind_speed").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->wind_speed to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->wind_degree from the result should match one in {}")
    public void theCurrentWind_degreeFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("wind_degree").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("wind_degree").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->wind_degree to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->wind_dir from the result should match one in {}")
    public void theCurrentWind_dirFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("wind_dir").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("wind_dir").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->wind_dir to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->pressure from the result should match one in {}")
    public void theCurrentPressureFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("pressure").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("pressure").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->pressure to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->precip from the result should match one in {}")
    public void theCurrentPrecipFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("precip").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("precip").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->precip to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->humidity from the result should match one in {}")
    public void theCurrentHumidityFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("humidity").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("humidity").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->humidity to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->cloudcover from the result should match one in {}")
    public void theCurrentCloudcoverFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("cloudcover").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("cloudcover").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->cloudcover to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->feelslike from the result should match one in {}")
    public void theCurrentFeelslikeFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("feelslike").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("feelslike").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->feelslike to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->uv_index from the result should match one in {}")
    public void theCurrentUv_indexFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("uv_index").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("uv_index").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->uv_index to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->visibility from the result should match one in {}")
    public void theCurrentVisibilityFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("visibility").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("visibility").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->visibility to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @Then("The current->is_day from the result should match one in {}")
    public void theCurrentIs_dayFromTheResultShouldMatchOneIn(String knownInformation) {
        JsonElement knownObject = jp.parse(knownInformation);
        JsonObject knownObjectRoot = knownObject.getAsJsonObject();

        expectedValue = knownObjectRoot.getAsJsonObject("current").get("is_day").getAsString();
        testedValue = rootObject.getAsJsonObject("current").get("is_day").getAsString();

        try {
            assertEquals(expectedValue, testedValue);
        } catch(AssertionError ae) {
            verificationErrors.append("INCORRECT VALUE for city ").append(currentCity).append(": expected current->is_day to be ").append(expectedValue)
                    .append(" but actual is ").append(testedValue).append("\n");
        }
    }

    @After
    public void afterScenario() {
        if (!(verificationErrors.length() == 0)) {
            fail(verificationErrors.toString());
        }
    }
}
