package com.example.exam.weather;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class Response {
    private Header header;
    private Body body;
}