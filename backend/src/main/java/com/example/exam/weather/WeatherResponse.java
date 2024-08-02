package com.example.exam.weather;

import lombok.Setter;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAccessType;

@Setter
@XmlRootElement(name = "response")
@XmlAccessorType(XmlAccessType.FIELD)
public class WeatherResponse {
    private Header header;
    private Body body;

    @XmlElement(name = "header")
    public Header getHeader() {
        return header;
    }

    @XmlElement(name = "body")
    public Body getBody() {
        return body;
    }
}
