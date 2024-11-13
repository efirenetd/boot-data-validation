package ph.com.pbcom.step;

import org.springframework.batch.core.Step;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.ItemWriter;
import org.springframework.batch.item.database.builder.JpaItemWriterBuilder;
import org.springframework.batch.item.file.FlatFileItemReader;
import org.springframework.batch.item.file.mapping.DefaultLineMapper;
import org.springframework.batch.item.file.mapping.FieldSetMapper;
import org.springframework.batch.item.file.transform.DelimitedLineTokenizer;
import org.springframework.batch.item.support.PassThroughItemProcessor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.transaction.PlatformTransactionManager;
import ph.com.pbcom.model.Customer;
import ph.com.pbcom.repository.CustomerRepository;

@Configuration
public class StepConfig {
    @Value("${max.chunk}")
    private int maxChunk;

    @Value("${file.customer1}")
    private String customerFile1;


    @Autowired
    private FieldSetMapper<Customer> customerFieldSetMapper;

    @Bean
    public Step step(JobRepository jobRepository, PlatformTransactionManager transactionManager) {

        return new StepBuilder("step", jobRepository)
                .<Customer, Customer>chunk(maxChunk, transactionManager)
                .reader(reader())
                .processor(new PassThroughItemProcessor<Customer>())
                .writer(e -> {
                    System.out.println("WRITE WRITE");
                })
                .build();
    }
    @Bean
    public FlatFileItemReader<Customer> reader() {
        FlatFileItemReader<Customer> reader = new FlatFileItemReader<>();
        reader.setResource(new ClassPathResource(customerFile1));
        reader.setLinesToSkip(1);

        reader.setLineMapper(new DefaultLineMapper<>() {{
            setLineTokenizer(new DelimitedLineTokenizer("|"));
            setFieldSetMapper(customerFieldSetMapper);
        }});
        return reader;
    }

}
