package com.techblog.helper;

import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.GeneralSecurityException;

public class EncoderDecoderProvider {

    private static final String ALGORITHM = "AES";
    private static final String SECRET_KEY = "S3cur3P@ssw0rd!!"; // Store securely!

    private static final ThreadLocal<Cipher> ENCRYPT_CIPHER = ThreadLocal.withInitial(() -> initCipher(Cipher.ENCRYPT_MODE));
    private static final ThreadLocal<Cipher> DECRYPT_CIPHER = ThreadLocal.withInitial(() -> initCipher(Cipher.DECRYPT_MODE));

    private static Cipher initCipher(int mode) {
        try {
            SecretKey secretKey = new SecretKeySpec(SECRET_KEY.getBytes(StandardCharsets.UTF_8), ALGORITHM);
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(mode, secretKey);
            return cipher;
        } catch (GeneralSecurityException e) {
            throw new RuntimeException("Error initializing Cipher", e);
        }
    }

    public static String encrypt(String data) {
        try {
            byte[] encryptedBytes = ENCRYPT_CIPHER.get().doFinal(data.getBytes(StandardCharsets.UTF_8));
            return Base64.getUrlEncoder().encodeToString(encryptedBytes);
        } catch (GeneralSecurityException e) {
            throw new RuntimeException("Encryption failed", e);
        }
    }

    public static String decrypt(String encryptedData) {
        try {
            byte[] decodedBytes = Base64.getUrlDecoder().decode(encryptedData);
            byte[] decryptedBytes = DECRYPT_CIPHER.get().doFinal(decodedBytes);
            return new String(decryptedBytes, StandardCharsets.UTF_8);
        } catch (GeneralSecurityException e) {
            throw new RuntimeException("Decryption failed", e);
        }
    }
}
