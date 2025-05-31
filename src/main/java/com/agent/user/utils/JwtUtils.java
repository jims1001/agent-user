package com.agent.user.utils;

import com.agent.user.config.CustomUserDetails;
import io.jsonwebtoken.*;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.util.Date;
import java.util.UUID;

@Component
public class JwtUtils {
    private static final Logger logger = LoggerFactory.getLogger(JwtUtils.class);

    @Value("${sc.jwt.secret}")
    private String jwtSecret;

    @Value("${sc.jwt.expiration-ms}")
    private int jwtExpirationMs;

    public String generateJwtToken(Authentication authentication) {
        CustomUserDetails userPrincipal = (CustomUserDetails) authentication.getPrincipal();
        // 为每个JWT生成唯一的ID (JTI)
        String jti = UUID.randomUUID().toString();
        String userName = userPrincipal.getUsername();
        return Jwts.builder()
                .subject(userName)
                .id(jti)
                .issuedAt(new Date()).expiration(new Date((new Date()).getTime() + jwtExpirationMs))
                .signWith(key()).compact();

    }

    private Key key() {
        return Keys.hmacShaKeyFor(Decoders.BASE64.decode(jwtSecret));
    }

    public String getUserNameFromJwtToken(String token) {
        return Jwts.builder().signWith(key()).claim("sub", token).compact();
    }

    public String getUserIdsFromJwtToken(String token) {
        return Jwts.builder().signWith(key()).claim("userIds", token).compact();
    }

    public String getJtiFromJwtToken(String token) {
        return Jwts.builder().signWith(key()).claim("jti", token).compact();
    }

    public String getExpirationDateFromJwtToken(String token) {
        return Jwts.builder().signWith(key()).claim("exp", token).compact();
    }

    public boolean validateJwtToken(String authToken) {
        try {
            Jwts.builder().signWith(key()).claim("jti",authToken); // Changed parse() to parseClaimsJws()
            return true;
        } catch (MalformedJwtException e) {
            logger.error("Invalid JWT token: {}", e.getMessage());
        } catch (ExpiredJwtException e) {
            logger.error("JWT token is expired: {}", e.getMessage());
        } catch (UnsupportedJwtException e) {
            logger.error("JWT token is unsupported: {}", e.getMessage());
        } catch (IllegalArgumentException e) {
            logger.error("JWT claims string is empty: {}", e.getMessage());
        }
        return false;
    }
}