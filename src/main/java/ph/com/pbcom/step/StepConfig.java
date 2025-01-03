package ph.com.pbcom.step;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.ImmutablePair;
import org.springframework.batch.core.Step;
import org.springframework.batch.core.configuration.annotation.StepScope;
import org.springframework.batch.core.repository.JobRepository;
import org.springframework.batch.core.step.builder.StepBuilder;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.batch.item.ItemWriter;
import org.springframework.batch.item.data.RepositoryItemWriter;
import org.springframework.batch.item.file.FlatFileItemReader;
import org.springframework.batch.item.file.FlatFileItemWriter;
import org.springframework.batch.item.file.mapping.DefaultLineMapper;
import org.springframework.batch.item.file.mapping.FieldSetMapper;
import org.springframework.batch.item.file.transform.DelimitedLineTokenizer;
import org.springframework.batch.item.file.transform.LineAggregator;
import org.springframework.batch.item.support.PassThroughItemProcessor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.FileSystemResource;
import org.springframework.transaction.PlatformTransactionManager;
import ph.com.pbcom.config.AppProperties;
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
    private LineAggregator<List<Map<String, ImmutablePair<String, String>>>> customerLineAggregator;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private AppProperties props;

    @Bean
    public Step loadCustomerDataStep(JobRepository jobRepository,
                     PlatformTransactionManager transactionManager,
                     @Value("${file.customer1}") String filePath) {

        return new StepBuilder("loadCustomerDataStep", jobRepository)
                .<Customer, Customer>chunk(maxChunk, transactionManager)
                .reader(customerTransformReader(filePath))
                .processor(new PassThroughItemProcessor<Customer>())
                .writer(write())
                .build();
    }
    @Bean
    public FlatFileItemReader<Customer> customerTransformReader(String path) {
        FlatFileItemReader<Customer> reader = new FlatFileItemReader<>();
        reader.setResource(new FileSystemResource(path));
        reader.setLinesToSkip(1);

        reader.setLineMapper(new DefaultLineMapper<>() {{
            setLineTokenizer(new DelimitedLineTokenizer("|"));
            setFieldSetMapper(customerFieldSetMapper);
        }});
        return reader;
    }

    @Bean
    public FlatFileItemReader<Customer> customerT24Reader(String path) {
        FlatFileItemReader<Customer> reader = new FlatFileItemReader<>();
        reader.setResource(new FileSystemResource(path));
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
                                   FlatFileItemWriter<List<Map<String, ImmutablePair<String, String>>>> customerReconciliationWriter,
                                   @Value("${file.customer2}") String filePath) {

        return new StepBuilder("dataValidationStep", jobRepository)
                .<Customer, List<Map<String, ImmutablePair<String, String>>>>chunk(maxChunk, transactionManager)
                .reader(customerT24Reader(filePath))
                .processor(customerProcessor)
                .writer(customerReconciliationWriter)
                .build();
    }


    @Bean
    public FlatFileItemWriter<List<Map<String, ImmutablePair<String, String>>>> customerReconciliationWriter() {

        FlatFileItemWriter<List<Map<String, ImmutablePair<String, String>>>> writer = new FlatFileItemWriter<>();
        writer.setResource(new FileSystemResource(props.getOutputRecon()));
        String[] headerName = StringUtils.join(props.getHeaders().toArray()).split(",");
        writer.setHeaderCallback(w -> w.write(addQuote(headerName)));
        writer.setLineAggregator(customerLineAggregator);

        return writer;
    }

    private String addQuote(String[] names) {
        StringBuilder sb = new StringBuilder();
        for (String word : names) {
            sb.append("\"").append(word.trim()).append("\",");
        }
        return sb.toString().substring(0, sb.length() - 1); // Remove the trailing comma
    }

}
