package com.agent.user.service;

import com.agent.user.config.CustomUserDetails;
import com.agent.user.repository.UserRepository;
import com.agent.user.repository.entitys.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Limit;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserRepositoryService implements UserDetailsService {

    @Autowired
     UserRepository userRepository;


    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        Optional<Object> userObj = userRepository.findUserByUsername(userName);
        if (userObj.isEmpty()) {
            return null;
        }
        User user = (User) userObj.orElse(null);
        return new CustomUserDetails(user.getUsername(), user.getUsername(), user.getPasswordHash(), null);
    }

}