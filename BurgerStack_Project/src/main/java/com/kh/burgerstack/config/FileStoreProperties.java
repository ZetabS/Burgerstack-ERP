package com.kh.burgerstack.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component
@ConfigurationProperties(prefix = "burgerstack.file-store")
public class FileStoreProperties {
    private String root;
}
