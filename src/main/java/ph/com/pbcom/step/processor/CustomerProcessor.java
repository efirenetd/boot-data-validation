package ph.com.pbcom.step.processor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.stereotype.Component;
import ph.com.pbcom.model.Customer;
import ph.com.pbcom.repository.CustomerRepository;

@Component
public class CustomerProcessor implements ItemProcessor<Customer, Customer> {

    private Logger logger = LoggerFactory.getLogger(CustomerProcessor.class);

    private CustomerRepository customerRepository;

    public CustomerProcessor(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    @Override
    public Customer process(Customer item) throws Exception {

        var byId = customerRepository.findById(item.getId());
        if (byId.isPresent()) {
            Customer customer = byId.get();
            logger.info("=================================");
            logger.info("ID [{}] is equal: {} ", item.getId(), item.getId().equals(customer.getId()));
            logger.info("CO_CODE is equal: {} ", item.getCoCode().equals(customer.getCoCode()));
            logger.info("MNEMONIC is equal: {}", item.getMnemonic().equals(customer.getMnemonic()));
            logger.info("SHORTNAME is equal: {}" ,item.getShortName().equals(customer.getShortName()));
            logger.info("NAME1 is equal: {} ",item.getName1().equals(customer.getName1()));
            logger.info("NAME2 is equal: {} ", item.getName2().equals(customer.getName2()));
            logger.info("=================================");
        }
        return item;
    }
}
