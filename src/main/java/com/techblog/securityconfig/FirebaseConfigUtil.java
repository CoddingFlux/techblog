package com.techblog.securityconfig;

import java.io.InputStream;
import java.util.Properties;

import jakarta.servlet.ServletContext;

public class FirebaseConfigUtil {

    private static final Properties PROPERTIES = new Properties();

    // Load configuration using ServletContext
    public static void loadConfig(ServletContext context) {
        try {
            // Get config file path from context-param
            String configFilePath = context.getInitParameter("configFilePath");
            if (configFilePath == null) {
                throw new RuntimeException("Context parameter 'configFilePath' is not defined");
            }

            try (InputStream input = context.getResourceAsStream(configFilePath)) {
                if (input == null) {
                    throw new RuntimeException("Sorry, unable to find config.properties at " + configFilePath);
                }
                PROPERTIES.load(input);
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to load Firebase configuration", e);
        }
    }

    // Retrieve property values by key
    public static String get(String key) {
        return PROPERTIES.getProperty(key);
    }
}
