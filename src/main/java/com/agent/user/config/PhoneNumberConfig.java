package com.agent.user.config;

import com.agent.user.utils.PhoneUtil;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

@Component
public class PhoneNumberConfig {

    @Bean
    public PhoneUtil phoneUtil() {
        return new PhoneUtil();
    }
}
