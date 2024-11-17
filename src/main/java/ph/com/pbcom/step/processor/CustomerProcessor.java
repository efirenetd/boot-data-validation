package ph.com.pbcom.step.processor;

import org.apache.commons.lang3.tuple.ImmutablePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.stereotype.Component;
import ph.com.pbcom.model.Customer;
import ph.com.pbcom.repository.CustomerRepository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public class CustomerProcessor implements ItemProcessor<Customer, List<Map<String, ImmutablePair<String, String>>>> {

    private Logger logger = LoggerFactory.getLogger(CustomerProcessor.class);

    private CustomerRepository customerRepository;


    public CustomerProcessor(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    @Override
    public List<Map<String, ImmutablePair<String, String>>> process(Customer item) throws Exception {

        List<Map<String, ImmutablePair<String, String>>> compareList = new ArrayList<>();
        var byId = customerRepository.findById(item.getId());
        if (byId.isPresent()) {
            Customer customer = byId.get();
            Map<String, ImmutablePair<String, String>> result = new HashMap<>();

            result.put("id", ImmutablePair.of(item.getId(), customer.getId()));
            result.put("coCode", ImmutablePair.of(item.getCoCode(), customer.getCoCode()));
            result.put("mnemonic", ImmutablePair.of(item.getMnemonic(), customer.getMnemonic()));
            result.put("shortName", ImmutablePair.of(item.getShortName(), customer.getShortName()));
            result.put("name1", ImmutablePair.of(item.getName1(), customer.getName1()));
            result.put("name2", ImmutablePair.of(item.getName2(), customer.getName2()));

            logger.info("=================================");
            logger.info("ID [{}] is equal: {} ", item.getId(), item.getId().equals(customer.getId()));
            logger.info("CO_CODE is equal: {} ", item.getCoCode().equals(customer.getCoCode()));
            logger.info("MNEMONIC is equal: {}", item.getMnemonic().equals(customer.getMnemonic()));
            logger.info("SHORTNAME is equal: {}" ,item.getShortName().equals(customer.getShortName()));
            logger.info("NAME1 is equal: {} ",item.getName1().equals(customer.getName1()));
            logger.info("NAME2 is equal: {} ", item.getName2().equals(customer.getName2()));
            logger.info("=================================");

            compareList.add(result);
        }
        return compareList;
    }



}
