package com.agent.user;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages = "com.agent.user.config")
@ComponentScan(basePackages = "com.agent.user.controllers")
@ComponentScan(basePackages = "com.agent.user.handles")
@ComponentScan(basePackages = "com.agent.user.repository")
@ComponentScan(basePackages = "com.agent.user.repository.entitys")
@ComponentScan(basePackages = "com.agent.user.utils")
@ComponentScan(basePackages = "com.agent.user.service")
@EntityScan("com.agent.user.repository.entitys")
@SpringBootApplication
public class AgentUserApplication {
	public static void main(String[] args) {
		SpringApplication.run(AgentUserApplication.class, args);
	}

}
