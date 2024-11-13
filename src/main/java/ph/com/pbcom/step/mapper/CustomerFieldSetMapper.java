package ph.com.pbcom.step.mapper;

import org.springframework.batch.item.file.mapping.FieldSetMapper;
import org.springframework.batch.item.file.transform.FieldSet;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindException;
import ph.com.pbcom.model.Customer;

@Component
public class CustomerFieldSetMapper implements FieldSetMapper<Customer> {
    @Override
    public Customer mapFieldSet(FieldSet fieldSet) throws BindException {
        Customer customer = new Customer();
        customer.setCoCode(fieldSet.readRawString(0));
        customer.setId(fieldSet.readRawString(1));
        customer.setMnemonic(fieldSet.readRawString(2));
        customer.setShortName(fieldSet.readRawString(3));
        customer.setName1(fieldSet.readRawString(4));
        customer.setName2(fieldSet.readRawString(5));
        return customer;
    }
}
