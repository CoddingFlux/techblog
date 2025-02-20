package com.techblog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.techblog.dao.UserDao;
import com.techblog.entitties.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.FileManager;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/UpdateProfile")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // Max file size: 5MB
public class UpdateProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(UpdateProfile.class.getName());

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        try (PrintWriter pw = resp.getWriter()) {
            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                pw.print("{\"status\":\"error\", \"message\":\"User session expired. Please log in again.\"}");
                return;
            }

            String name = req.getParameter("user_name").trim();
            String email = req.getParameter("user_email").trim();
            String gender = req.getParameter("user_gender").trim();
            String about = req.getParameter("user_about").trim();
            Part part = req.getPart("user_profile");
            String filename = (part != null) ? part.getSubmittedFileName() : "";

            // Validate input fields
            if (name.isEmpty() || email.isEmpty() || gender.isEmpty()) {
                pw.print("{\"status\":\"error\", \"message\":\"Name, email, and gender are required fields.\"}");
                return;
            }

            // File upload handling
            if (!filename.isEmpty() && isValidImage(filename)) {
                ServletContext context = req.getServletContext();
                String uploadPath = context.getRealPath("assets/pics");

                // Delete old profile picture (if not default)
                if (!user.getuProfile().equals("default.png")) {
                    FileManager.deleteFile(uploadPath + File.separator + user.getuProfile());
                }

                // Save new profile picture
                FileManager.saveFile(part.getInputStream(), uploadPath + File.separator + filename);
                user.setuProfile(filename);
            }

            // Update user details
            user.setuName(name);
            user.setuEmail(email);
            user.setuGender(gender);
            user.setuAbout(about);

            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            boolean isUpdated = userDao.updateUser(user);

            if (isUpdated) {
                pw.print("{\"status\":\"success\", \"message\":\"Profile updated successfully!\"}");
            } else {
                pw.print("{\"status\":\"error\", \"message\":\"Profile update failed. Please try again.\"}");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Profile update error", e);
//            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while updating your profile.");
        }
    }

    private boolean isValidImage(String filename) {
        String lowerName = filename.toLowerCase();
        return lowerName.endsWith(".jpg") || lowerName.endsWith(".jpeg") || lowerName.endsWith(".png");
    }
}
