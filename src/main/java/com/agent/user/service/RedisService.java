package com.agent.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;

@Service
public class RedisService {

    @Autowired
    RedisTemplate<String, Object> redisTemplate;


    // Add the JWT ID to the blacklist.
    public void blacklistJwt(String jti, long expirationSeconds) {
        // Extract the JTI and Expiration Time (exp) from the JWT
        redisTemplate.opsForValue().set("sc_agent_user:jwt:blacklist:" + jti, "blacklisted", Duration.ofSeconds(expirationSeconds));
    }

    // Check if the JWT ID is blacklisted.
    public boolean isJwtBlacklisted(String jti) {
        return redisTemplate.hasKey(":sc_agent_user:jwt:blacklist:" + jti);
    }
}
