package ph.com.pbcom.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;

@Configuration
public class BatchConfig {

    @Autowired
    private DataSource dataSource;

    public BatchConfig() {
    }

    @Bean
    public PlatformTransactionManager transactionManager(){
        return new JpaTransactionManager();
    }

}
