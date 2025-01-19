package co.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;

import static org.springframework.security.config.http.SessionCreationPolicy.STATELESS;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    private static final String[] WHITE_LIST_URL = {
            "/swagger-ui.html"
    };

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http.csrf(AbstractHttpConfigurer::disable);
        http.cors(cors -> cors.configure(http));
        http.authorizeHttpRequests(authorization -> authorization
                .requestMatchers(WHITE_LIST_URL).permitAll()
                .requestMatchers(
                        "/api/v1/users/demo"
                ).permitAll()
                .requestMatchers(HttpMethod.GET , "/api/v1/users").authenticated()
        );

        http.sessionManagement(session -> session.sessionCreationPolicy(STATELESS));
        http.oauth2ResourceServer(oauth2ResourceServer -> oauth2ResourceServer.jwt(Customizer.withDefaults()));
        return http.build();
    }

}

//    private static final String[] WHITE_LIST_URL = {
//            "/v2/api-docs",
//            "/v3/api-docs",
//            "/v3/api-docs/**",
//            "/swagger-resources",
//            "/swagger-resources/**",
//            "/configuration/ui",
//            "/configuration/security",
//            "/swagger-ui/**",
//            "/webjars/**",
//            "/swagger-ui.html",
//            "/api/v2/mappers/display-pdf-file/{fileName}"
//    };
//
//    @Bean
//    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//        return http
//                .csrf(AbstractHttpConfigurer::disable)
//                .cors(AbstractHttpConfigurer::disable)
//                .authorizeHttpRequests(authorize -> authorize
//                        // Allowlisted URLs
//                        .requestMatchers(WHITE_LIST_URL).permitAll()
//
//                        // Template-specific routes
//                        .requestMatchers(HttpMethod.GET, "/api/v1/templates/search").authenticated()
//                        .requestMatchers(HttpMethod.POST, "/api/v1/templates").hasAnyRole("Admin", "Designer")
//                        .requestMatchers(HttpMethod.POST, "/api/v2/formKH/**").hasAnyRole("Admin", "Designer", "System")
//                        .requestMatchers(HttpMethod.PUT, "/api/v1/templates/template-json-data/**").hasAnyRole("Admin", "Designer")
//                        .requestMatchers(HttpMethod.POST, "/api/v1/templates/save-draft/**").hasAnyRole("Admin", "Designer")
//
//                        // All other requests must be authenticated
//                        .anyRequest().authenticated()
//                )
//                .httpBasic(httpBasic -> httpBasic
//                        .authenticationEntryPoint(new HttpStatusEntryPoint(HttpStatus.UNAUTHORIZED)) // Return 401 for unauthorized access
//                )
//                .oauth2ResourceServer(oauth2 -> oauth2
//                        .jwt(jwt -> jwt.jwtAuthenticationConverter(
//                                new JwtAuthenticationConverter()
//                        )) // Default JWT converter
//                )
//                .exceptionHandling(exception -> exception
//                        .authenticationEntryPoint(new HttpStatusEntryPoint(HttpStatus.UNAUTHORIZED)) // Handle unauthorized access
//                        .accessDeniedHandler(customAccessDeniedHandler()) // Handle access denied
//                )
//                .sessionManagement(session -> session
//                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS) // Stateless session management
//                )
//                .build();
//    }
//
//    // Custom AccessDeniedHandler
//    private AccessDeniedHandler customAccessDeniedHandler() {
//        return (request, response, accessDeniedException) -> {
//            response.setStatus(HttpStatus.FORBIDDEN.value());
//            response.getWriter().write("Access Denied!");
//        };
//    }