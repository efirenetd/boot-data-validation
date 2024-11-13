package ph.com.pbcom.step.writer;

import org.springframework.batch.item.Chunk;
import org.springframework.batch.item.ItemWriter;
import org.springframework.stereotype.Component;
import ph.com.pbcom.model.Customer;
import ph.com.pbcom.repository.CustomerRepository;

@Component
public class CustomerItemWriter implements ItemWriter<Customer> {

    private CustomerRepository customerRepository;

    public CustomerItemWriter(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    @Override
    public void write(Chunk<? extends Customer> chunk) throws Exception {

    }
}
