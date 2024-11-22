package ph.com.pbcom;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories
public class T24DataValidationApplication {

	public static void main(String[] args) {
		//`SpringApplication.exit()` and `System.exit()` ensure that the JVM exits upon job completion.
		// Referred: https://github.com/spring-guides/gs-batch-processing/pull/41/files#top
		System.exit(SpringApplication.exit(SpringApplication.run(T24DataValidationApplication.class, args)));
	}

}
