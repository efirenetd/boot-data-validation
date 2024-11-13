package ph.com.pbcom.job;

import org.springframework.batch.core.Job;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.job.builder.JobBuilder;
import org.springframework.batch.core.launch.support.RunIdIncrementer;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class JobConfig {


    @Bean
    public Job job(JobRepository jobRepository, Step step) {
        return new JobBuilder("dataValidateJob", jobRepository)
                .start(step)
                .incrementer(new RunIdIncrementer())
                //.listener(jobListener)
                .build();
    }

}