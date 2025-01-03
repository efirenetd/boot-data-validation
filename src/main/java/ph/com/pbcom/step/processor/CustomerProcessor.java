package ph.com.pbcom.step.processor;

import org.apache.commons.lang3.tuple.ImmutablePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.item.ItemProcessor;
import org.springframework.stereotype.Component;
import ph.com.pbcom.config.AppProperties;
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

    private AppProperties props;

    public CustomerProcessor(CustomerRepository customerRepository, AppProperties props) {
        this.customerRepository = customerRepository;
        this.props = props;
    }

    @Override
    public List<Map<String, ImmutablePair<String, String>>> process(Customer item) throws Exception {

        List<Map<String, ImmutablePair<String, String>>> compareList = new ArrayList<>();
        var byId = customerRepository.findById(item.getId());
        if (byId.isPresent()) {
            Customer newcustomer = byId.get();
            Map<String, ImmutablePair<String, String>> result = new HashMap<>();

            result.put("id", ImmutablePair.of(item.getId(), newcustomer.getId()));
            result.put("coCode", ImmutablePair.of(item.getCoCode(), newcustomer.getCoCode()));
            result.put("mnemonic", ImmutablePair.of(item.getMnemonic(), newcustomer.getMnemonic()));
            result.put("shortName", ImmutablePair.of(item.getShortName(), newcustomer.getShortName()));
            result.put("name1", ImmutablePair.of(item.getName1(), newcustomer.getName1()));
            result.put("name2", ImmutablePair.of(item.getName2(), newcustomer.getName2()));

/*
            for (int i = 6; i < props.getCustomerFields().size() - 6; i++) {
                String key = props.getCustomerFields().get(i);
                result.put(key, ImmutablePair.of(item.getProperties().get(key), newcustomer.getProperties().get(key)));
            }
*/

            logger.debug("=================================");
            logger.debug("ID [{}] is equal: {} ", item.getId(), item.getId().equals(newcustomer.getId()));
            logger.debug("CO_CODE is equal: {} ", item.getCoCode().equals(newcustomer.getCoCode()));
            logger.debug("MNEMONIC is equal: {}", item.getMnemonic().equals(newcustomer.getMnemonic()));
            logger.debug("SHORTNAME is equal: {}" ,item.getShortName().equals(newcustomer.getShortName()));
            logger.debug("NAME1 is equal: {} ",item.getName1().equals(newcustomer.getName1()));
            logger.debug("NAME2 is equal: {} ", item.getName2().equals(newcustomer.getName2()));
            logger.debug("=================================");

            compareList.add(result);
        }
        return compareList;
    }



}
