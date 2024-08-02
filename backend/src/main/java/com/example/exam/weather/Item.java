package com.example.exam.weather;

import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
public class Item {
    private String baseDate;
    private String baseTime;
    private String category;
    private String nx;
    private String ny;
    private String obsrValue;

    @XmlElement(name = "baseDate")
    public String getBaseDate() {
        return baseDate;
    }

    @XmlElement(name = "baseTime")
    public String getBaseTime() {
        return baseTime;
    }

    @XmlElement(name = "category")
    public String getCategory() {
        return category;
    }

    @XmlElement(name = "nx")
    public String getNx() {
        return nx;
    }

    @XmlElement(name = "ny")
    public String getNy() {
        return ny;
    }

    @XmlElement(name = "obsrValue")
    public String getObsrValue() {
        return obsrValue;
    }
}
