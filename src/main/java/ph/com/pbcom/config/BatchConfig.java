package ph.com.pbcom.config;

import org.springframework.batch.core.explore.JobExplorer;
import org.springframework.batch.core.explore.support.JobExplorerFactoryBean;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.repository.support.JobRepositoryFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
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
        return new DataSourceTransactionManager(dataSource);
    }

/*    @Bean
    public JobRepository jobRepository(PlatformTransactionManager transactionManager) throws Exception {
        JobRepositoryFactoryBean jobRepository = new JobRepositoryFactoryBean();
        jobRepository.setDataSource(dataSource);
        jobRepository.setTransactionManager(transactionManager);
        jobRepository.setIsolationLevelForCreate("ISOLATION_READ_COMMITTED");
        jobRepository.setTablePrefix("PBC.BATCH_");
        jobRepository.setMaxVarCharLength(1000);
        jobRepository.afterPropertiesSet();
        return jobRepository.getObject();
    }*/
/*

    @Bean
    protected JobExplorer jobExplorer(PlatformTransactionManager transactionManager) throws Exception {
        JobExplorerFactoryBean jobExplorer = new JobExplorerFactoryBean();
        jobExplorer.setDataSource(dataSource);
        jobExplorer.setTransactionManager(transactionManager);
        jobExplorer.setTablePrefix("PBC.BATCH_");
        jobExplorer.afterPropertiesSet();
        return jobExplorer.getObject();
    }*/
}
