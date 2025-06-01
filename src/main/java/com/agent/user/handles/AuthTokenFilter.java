package com.agent.user.handles;
import com.agent.user.service.RedisService;
import com.agent.user.service.UserRepositoryService;
import com.agent.user.utils.JwtUtils;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;
import java.io.IOException;
import org.springframework.lang.NonNull;

public class AuthTokenFilter extends OncePerRequestFilter {
    @Autowired
    private JwtUtils jwtUtils;

    @Autowired
    private UserRepositoryService  userRepositoryService;
    @Autowired // DI RedisService
    private RedisService redisService;

    private static final Logger logger = LoggerFactory.getLogger(AuthTokenFilter.class);

    @Override
    protected void doFilterInternal(@NonNull  HttpServletRequest request,
                                    @NonNull  HttpServletResponse response,
                                    @NonNull  FilterChain filterChain)
            throws ServletException, IOException {

        try {
            String jwt = parseJwt(request);
            String jti = jwtUtils.getJtiFromJwtToken(jwt);
            if (jwt == null) {
                logger.warn("JWT does not contain jti claim.");
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Error: Invalid token format");
                return;
            }

            // Check if the JWT is on the blacklist.
            if (redisService.isJwtBlacklisted(jti)) {
                logger.warn("Attempted to use a blacklisted JWT: {}", jti);
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Error: Token is blacklisted");
                return; // Prevent further processing.
            }

            String username = jwtUtils.getUserNameFromJwtToken(jwt);
            if (username == null) {
                logger.warn("JWT does not contain username.");
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Error: Invalid token");
                return;
            }


            UserDetails userDetails = userRepositoryService.loadUserByUsername(username);
            if (userDetails == null) {
                logger.warn("User not found: {}", username);
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Error: User not found");
                return;
            }

            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(
                            userDetails,
                            userDetails.getPassword(),
                            userDetails.getAuthorities());
            authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));

            SecurityContextHolder.getContext().setAuthentication(authentication);

        } catch (Exception e) {
            logger.error("Cannot set user authentication", e);
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Error: Authentication failed");
            return;
        }

        filterChain.doFilter(request, response);
    }

    private String parseJwt(HttpServletRequest request) {
        String headerAuth = request.getHeader("Authorization");

        if (StringUtils.hasText(headerAuth) && headerAuth.startsWith("Bearer ")) {
            return headerAuth.substring(7);
        }
        return null;
    }
}