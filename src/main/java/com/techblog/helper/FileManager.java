package com.techblog.helper;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;


import ch.qos.logback.classic.Logger;
import org.slf4j.LoggerFactory;


public class FileManager {

	private static final Logger logger = (Logger) LoggerFactory.getLogger(FileManager.class);

	// Delete a file at a given path
	public static boolean deleteFile(String path) {
		File file = new File(path);
		if (file.exists()) {
			boolean deleted = file.delete();
			if (!deleted) {
				logger.error("Failed to delete file: {}", path);
			}
			return deleted;
		}
		logger.error("File not found: {}", path);
		return false;
	}

	// Save a file from InputStream to a given path
	public static boolean saveFile(InputStream inputStream, String path) {
		File targetFile = new File(path);

		try {
			// Create parent directories if they don't exist
			Files.createDirectories(targetFile.toPath().getParent());

			// Use Buffered Streams for efficient writing
			try (BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(targetFile))) {
				byte[] buffer = new byte[8192]; // 8KB buffer
				int bytesRead;
				while ((bytesRead = inputStream.read(buffer)) != -1) {
					bos.write(buffer, 0, bytesRead);
				}
				bos.flush();
			}
			logger.info("File saved successfully: {}", path);
			return true;
		} catch (IOException e) {
			logger.error("Error saving file: {} : {}", path, e);
			return false;
		}
	}
}
