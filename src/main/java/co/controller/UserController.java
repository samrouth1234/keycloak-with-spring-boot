package co.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/users")
public class UserController {

    @GetMapping
    public String getUsers() {
        return "Hello World";
    }

    @GetMapping("/demo")
    public String demo() {
        return "Keycloak with spring boot";
    }
}
