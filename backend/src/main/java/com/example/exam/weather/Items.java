package com.example.exam.weather;

import java.util.List;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
public class Items {
    private List<Item> item;

    @XmlElement(name = "item")
    public List<Item> getItem() {
        return item;
    }
}
