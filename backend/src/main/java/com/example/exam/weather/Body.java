package com.example.exam.weather;

import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
public class Body {
    private String dataType;
    private Items items;
    private int numOfRows;
    private int pageNo;
    private int totalCount;

    @XmlElement(name = "dataType")
    public String getDataType() {
        return dataType;
    }

    @XmlElement(name = "items")
    public Items getItems() {
        return items;
    }

    @XmlElement(name = "numOfRows")
    public int getNumOfRows() {
        return numOfRows;
    }

    @XmlElement(name = "pageNo")
    public int getPageNo() {
        return pageNo;
    }

    @XmlElement(name = "totalCount")
    public int getTotalCount() {
        return totalCount;
    }
}
