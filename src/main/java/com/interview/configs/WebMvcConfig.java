package com.interview.configs;

import org.springframework.context.annotation.Configuration;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.interview.utils.StringToPositionConverter;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @SuppressWarnings("null")
    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addConverter(new StringToPositionConverter());
    }
}