package com.techblog.helper;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.Map;

import org.slf4j.LoggerFactory;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.techblog.securityconfig.FirebaseConfigUtil;

import ch.qos.logback.classic.Logger;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

public class FileManager {

	private static final Logger logger = (Logger) LoggerFactory.getLogger(FileManager.class);

	private static final String CLOUD_NAME = FirebaseConfigUtil.get("CLOUDINARY_CLOUD_NAME");
	private static final String API_KEY = FirebaseConfigUtil.get("CLOUDINARY_API_KEY");
	private static final String API_SECRET = FirebaseConfigUtil.get("CLOUDINARY_API_SECRET");

	private static final Cloudinary cloudinary = new Cloudinary(
			ObjectUtils.asMap("cloud_name", CLOUD_NAME, "api_key", API_KEY, "api_secret", API_SECRET));

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

	public static String saveGoogleProfileImage(HttpServletRequest req, String uprofile, String uemail) {

		try {
			String fileName = uemail.replaceAll("[^a-zA-Z0-9]", "_") + ".jpg";
			String uploadDir = "assets/pics/"; // Relative to project root

			// Get absolute path of the `assets/pics/` folder

			;
			String absoluteUploadDir = req.getServletContext().getRealPath("/") + uploadDir;
			Path uploadPath = Path.of(absoluteUploadDir);
			Path filePath = uploadPath.resolve(fileName);
//			System.out.println("My path : " + filePath);

			// Ensure directory exists
			if (!Files.exists(uploadPath)) {
				Files.createDirectories(uploadPath);
			}

			// Check if the file already exists
			if (!Files.exists(filePath)) {
				HttpClient client = HttpClient.newHttpClient();
				HttpRequest request = HttpRequest.newBuilder().uri(URI.create(uprofile)).GET().build();

				HttpResponse<byte[]> response = client.send(request, HttpResponse.BodyHandlers.ofByteArray());

				if (response.statusCode() == 200) { // HTTP 200 OK
					Files.write(filePath, response.body(), StandardOpenOption.CREATE,
							StandardOpenOption.TRUNCATE_EXISTING);
					logger.info("✅ Profile image saved: " + filePath.toString());
				} else {
					logger.warn("⚠️ Failed to download profile image. HTTP Status: " + response.statusCode());
				}
			} else {
				logger.info("🖼️ Profile image already exists: " + filePath.toString());
			}

			// Update user profile to use the local path
			return fileName;

		} catch (IOException | InterruptedException e) {
			logger.error("❌ Failed to download profile image: {}", e.getMessage(), e);
		}
		return null;
	}

	public static String uploadImgOnCloudinary(String imageUrl, Part filePart,String dirName) {
		try {
            Map<String, Object> uploadResult;

            if (imageUrl != null && !imageUrl.isEmpty() && imageUrl.startsWith("https")) {
                // ✅ Upload directly using the image URL (Cloudinary will fetch it)
                uploadResult = cloudinary.uploader().upload(imageUrl, ObjectUtils.asMap("folder", dirName));
            } else if (filePart != null) {
                // ✅ Upload file directly from InputStream (without saving locally)
            	byte[] fileBytes = filePart.getInputStream().readAllBytes();
                uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.asMap("folder", dirName));
            
            } else {
                System.err.println("⚠️ No valid input provided (URL or File Part required)");
                return null;
            }

            return uploadResult.get("secure_url").toString(); // ✅ Return Cloudinary URL

        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
	}
}