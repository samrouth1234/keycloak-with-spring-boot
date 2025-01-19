package co;

import co.utilits.DotenvUtil;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class KeycloakBasicApplication {

	public static void main(String[] args) {
		DotenvUtil.loadEnvProperties();
		SpringApplication.run(KeycloakBasicApplication.class, args);
	}

}
