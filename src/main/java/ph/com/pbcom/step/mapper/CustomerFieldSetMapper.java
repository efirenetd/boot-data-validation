package ph.com.pbcom.step.mapper;

import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import org.springframework.batch.item.file.mapping.FieldSetMapper;
import org.springframework.batch.item.file.transform.FieldSet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindException;
import ph.com.pbcom.config.AppProperties;
import ph.com.pbcom.model.Customer;

import java.util.HashMap;
import java.util.Map;

@Component
public class CustomerFieldSetMapper implements FieldSetMapper<Customer> {

    @Autowired
    private AppProperties props;

    @Override
    public Customer mapFieldSet(FieldSet fieldSet) throws BindException {
        Customer customer = new Customer();
        customer.setCoCode(fieldSet.readRawString(0));
        customer.setId(fieldSet.readRawString(1));
        customer.setMnemonic(fieldSet.readRawString(2));
        customer.setShortName(fieldSet.readRawString(3));
        customer.setName1(fieldSet.readRawString(4));
        customer.setName2(fieldSet.readRawString(5));

        Map<String, String> customerProperties = new HashMap<>();

        for (int i = 6; i < props.getCustomerFields().size() - 6; i++) {
            customerProperties.put(props.getCustomerFields().get(i), fieldSet.readRawString(i));
        }

        customer.setProperties(customerProperties);

        return customer;
    }
}
