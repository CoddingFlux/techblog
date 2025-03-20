package com.techblog.securityconfig;

import java.io.FileInputStream;
import java.io.IOException;

import org.slf4j.LoggerFactory;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

import ch.qos.logback.classic.Logger;

public class FirebaseInitializer {

	private static boolean initialized = false;
//	private static String path="E:\\D\\Projects\\3_Java\\3_Java_Servlet\\ServletProject\\PrivateKeys\\TechBlogSecret.json";
	private static String path="/app/PrivateKeys/TechBlogSecret.json";
	private static final Logger logger = (Logger) LoggerFactory.getLogger(FirebaseInitializer.class);

	
	public static void initializeFirebase() {
		
		if(!initialized) {
			try(FileInputStream serviceAccount = new FileInputStream(path)){
				
				FirebaseOptions option;
				option = FirebaseOptions.builder()
						.setCredentials(GoogleCredentials.fromStream(serviceAccount))
						.build();
				FirebaseApp.initializeApp(option);
				initialized=true;
				logger.info("Firebase initialized successfully.");
			} catch (IOException e) {
				logger.error("Error initializing Firebase: {}", e.getMessage(), e);
                throw new RuntimeException("Failed to initialize Firebase.", e);
			}
		}
	}
}
