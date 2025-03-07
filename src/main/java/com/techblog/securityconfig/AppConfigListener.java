package com.techblog.securityconfig;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppConfigListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		FirebaseConfigUtil.loadConfig(sce.getServletContext());
		System.out.println("✅ Firebase configuration loaded successfully.");
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		System.out.println("🛑 Application context destroyed.");
	}

	
	
}
