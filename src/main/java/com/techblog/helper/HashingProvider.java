package com.techblog.helper;

import at.favre.lib.crypto.bcrypt.BCrypt;

public class HashingProvider {
    
    // Hash a password using BCrypt with salt factor 12
    public static String hashProvider(String password) {
        return BCrypt.with(BCrypt.Version.VERSION_2A).hashToString(12, password.toCharArray());
    }

    // Verify password against stored hash
    public static boolean hashVerifyer(String password, String storedHash) {
        if (storedHash == null || storedHash.isEmpty()) {
            return false; // Prevent errors when storedHash is null
        }
        BCrypt.Result result = BCrypt.verifyer(BCrypt.Version.VERSION_2A).verify(password.toCharArray(), storedHash);
        return result.verified;
    }
}
