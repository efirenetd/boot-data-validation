package ph.com.pbcom.job;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.JobExecutionListener;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class JobConfig {


    @Bean
    public Job job(JobRepository jobRepository,
                   Step loadCustomerDataStep,
                   Step dataValidationStep,
                   JobExecutionListener customerJobListener) {
        return new JobBuilder("dataValidateJob", jobRepository)
                .start(loadCustomerDataStep).next(dataValidationStep)
                .incrementer(new RunIdIncrementer())
                .listener(customerJobListener)
                .build();
    }

}