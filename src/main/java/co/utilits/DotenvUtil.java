package co.utilits;

import io.github.cdimascio.dotenv.Dotenv;
import lombok.experimental.UtilityClass;

@UtilityClass
public class DotenvUtil {
    public static void loadEnvProperties() {
        Dotenv dotenv = Dotenv.configure().ignoreIfMalformed().load();
        dotenv.entries().forEach(entry -> System.setProperty(entry.getKey(), entry.getValue()));
    }
}