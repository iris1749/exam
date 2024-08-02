package com.example.exam.weather;

import com.example.exam.weather.Item;
import com.example.exam.weather.WeatherResponse;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.http.converter.xml.Jaxb2RootElementHttpMessageConverter;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Service
public class WeatherService {

    @Value("${weather.api.key}")
    private String apiKey;

    @Value("${weather.api.url}")
    private String apiUrl;

    private double currentTemperature;

    @Scheduled(fixedRate = 3600000)
    public void updateWeatherInfo() {
        try {
            RestTemplate restTemplate = new RestTemplate();
            restTemplate.getMessageConverters().add(new Jaxb2RootElementHttpMessageConverter());

            LocalDateTime now = LocalDateTime.now();
            String baseDate = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
            String baseTime = now.format(DateTimeFormatter.ofPattern("HHmm"));

            String url = UriComponentsBuilder.fromHttpUrl(apiUrl)
                    .queryParam("serviceKey", apiKey)
                    .queryParam("numOfRows", "10")
                    .queryParam("pageNo", "1")
                    .queryParam("base_date", baseDate)
                    .queryParam("base_time", baseTime)
                    .queryParam("nx", "55")
                    .queryParam("ny", "127")
                    .queryParam("dataType", "XML")
                    .toUriString();

            HttpHeaders headers = new HttpHeaders();
            headers.set(HttpHeaders.ACCEPT, MediaType.APPLICATION_XML_VALUE);

            HttpEntity<String> entity = new HttpEntity<>(headers);

            ResponseEntity<WeatherResponse> response = restTemplate.exchange(url, HttpMethod.GET, entity, WeatherResponse.class);

            WeatherResponse weatherResponse = response.getBody();

            if (weatherResponse != null && weatherResponse.getBody() != null && weatherResponse.getBody().getItems() != null) {
                for (Item item : weatherResponse.getBody().getItems().getItem()) {
                    if ("T1H".equals(item.getCategory())) {
                        currentTemperature = Double.parseDouble(item.getObsrValue());
                        break;
                    }
                }
            }
        } catch (Exception e) {
            System.err.println("날씨 정보를 가져오는 중 오류 발생: " + e.getMessage());
        }
    }

    public double getCurrentTemperature() {
        return currentTemperature;
    }
}
