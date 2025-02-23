package com.techblog.securityconfig;

import java.util.Date;

import javax.crypto.SecretKey;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;

public class JwtUtility {

	private static final String SECURITY_KEY = "YourVerySecretKeyWith32Characters!@#";
	private static final long EXPIRATION_TIME = (30 * 60 * 1000); // MS = M * S * MS

	public static String generateToken(String username) {

		SecretKey key = Keys.hmacShaKeyFor(SECURITY_KEY.getBytes());
		return Jwts.builder()
				.subject(username)
				.issuedAt(new Date())
				.expiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
				.signWith(key)
				.compact();
	}
	
	public static boolean validateToken(String token) {
		try {
			SecretKey key = Keys.hmacShaKeyFor(SECURITY_KEY.getBytes());
			Jwts.parser().verifyWith(key).build().parse(token);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	public static String getUsername(String token) {
		SecretKey key = Keys.hmacShaKeyFor(SECURITY_KEY.getBytes());
		Claims claims = Jwts.parser().verifyWith(key).build().parseSignedClaims(token).getPayload();
		return claims.getSubject();
	}

}
