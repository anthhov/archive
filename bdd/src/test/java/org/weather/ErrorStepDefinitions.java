package org.weather;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ErrorStepDefinitions {
    private JsonObject rootObject;
    JsonParser jp = new JsonParser();

    @When("User requests current weather for {string}")
    public void userRequestsCurrentWeatherFor(String city) throws IOException {
        URL url =new URL("http://api.weatherstack.com/current?" +
                "access_key=a8986a63ae4474d7a8ff511a2be47a2b&query=" + city);
        URLConnection request = url.openConnection();
        request.connect();

        JsonElement root = jp.parse(new InputStreamReader((InputStream) request.getContent()));
        rootObject = root.getAsJsonObject();
    }

    @When("User requests current weather for {string} and sets units to {string}")
    public void userRequestsCurrentWeatherForAndSetsUnitsTo(String city, String units) throws IOException {
        URL url =new URL("http://api.weatherstack.com/current?" +
                "access_key=a8986a63ae4474d7a8ff511a2be47a2b&query=" + city + "&units=" + units);
        URLConnection request = url.openConnection();
        request.connect();

        JsonElement root = jp.parse(new InputStreamReader((InputStream) request.getContent()));
        rootObject = root.getAsJsonObject();
    }

    @When("User requests current weather for {string} and sets access_key to {string}")
    public void userRequestsCurrentWeatherForAndSetsAccess_keyTo(String city, String access_key) throws IOException {
        URL url =new URL("http://api.weatherstack.com/current?" +
                "access_key=" + access_key + city);
        URLConnection request = url.openConnection();
        request.connect();

        JsonElement root = jp.parse(new InputStreamReader((InputStream) request.getContent()));
        rootObject = root.getAsJsonObject();
    }

    @When("User with free account requests current weather for {string} and sets language to {string}")
    public void userWithFreeAccountRequestsCurrentWeatherForAndSetsLanguageTo(String city, String language) throws IOException {
        URL url =new URL("http://api.weatherstack.com/current?" +
                "access_key=a8986a63ae4474d7a8ff511a2be47a2b&query=" + city + "&language=" + language);
        URLConnection request = url.openConnection();
        request.connect();

        JsonElement root = jp.parse(new InputStreamReader((InputStream) request.getContent()));
        rootObject = root.getAsJsonObject();
    }

    @Then("User gets error {int}")
    public void userGetsErrorAndJSON(int errorCode) {
        int actualResponse = rootObject.getAsJsonObject("error").get("code").getAsInt();
        assertEquals(errorCode, actualResponse);
    }
}
