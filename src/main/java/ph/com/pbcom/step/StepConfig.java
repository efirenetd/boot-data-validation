package ph.com.pbcom.step;

import org.apache.commons.lang3.tuple.ImmutablePair;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.batch.item.ItemWriter;
import org.springframework.batch.item.data.RepositoryItemWriter;
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

import java.util.List;
import java.util.Map;

@Configuration
public class StepConfig {
    @Value("${max.chunk}")
    private int maxChunk;

    @Autowired
    private FieldSetMapper<Customer> customerFieldSetMapper;

    @Autowired
    private ItemWriter<Customer> customerItemWriter;

    @Autowired
    private CustomerRepository customerRepository;

    @Bean
    public Step step(JobRepository jobRepository,
                     PlatformTransactionManager transactionManager,
                     @Value("${file.customer1}") String filePath) {

        return new StepBuilder("step", jobRepository)
                .<Customer, Customer>chunk(maxChunk, transactionManager)
                .reader(reader(filePath))
                .processor(new PassThroughItemProcessor<Customer>())
                .writer(write())
                .build();
    }
    @Bean
    public FlatFileItemReader<Customer> reader(String path) {
        FlatFileItemReader<Customer> reader = new FlatFileItemReader<>();
        reader.setResource(new ClassPathResource(path));
        reader.setLinesToSkip(1);

        reader.setLineMapper(new DefaultLineMapper<>() {{
            setLineTokenizer(new DelimitedLineTokenizer("|"));
            setFieldSetMapper(customerFieldSetMapper);
        }});
        return reader;
    }

    @Bean
    public RepositoryItemWriter<Customer> write() {
        RepositoryItemWriter<Customer> writer = new RepositoryItemWriter<>();
        writer.setRepository(customerRepository);
        return writer;
    }

    @Bean
    public Step dataValidationStep(JobRepository jobRepository,
                                   PlatformTransactionManager transactionManager,
                                   ItemProcessor<Customer, List<Map<String, ImmutablePair<String, String>>>> customerProcessor,
                                   @Value("${file.customer2}") String filePath) {

        return new StepBuilder("dataValidationStep", jobRepository)
                .<Customer, List<Map<String, ImmutablePair<String, String>>>>chunk(maxChunk, transactionManager)
                .reader(reader(filePath))
                .processor(customerProcessor)
                .writer(c -> {
                    System.out.printf("Customer:  "+c);
                })
                .build();
    }



}
