package com.example.exam.weather;

import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
public class Header {
    private String resultCode;
    private String resultMsg;

    @XmlElement(name = "resultCode")
    public String getResultCode() {
        return resultCode;
    }

    @XmlElement(name = "resultMsg")
    public String getResultMsg() {
        return resultMsg;
    }
}
