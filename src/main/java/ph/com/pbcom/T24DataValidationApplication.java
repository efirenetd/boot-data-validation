package ph.com.pbcom;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories
public class T24DataValidationApplication {

	public static void main(String[] args) {
		SpringApplication.run(T24DataValidationApplication.class, args);
	}

}
