package ph.com.pbcom.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import java.util.LinkedList;
import java.util.List;

@Component
@ConfigurationProperties(prefix = "file")
public class AppProperties {

    private LinkedList<String> customerFields;

    private List<String> headers;

    private String outputRecon;

    public List<String> getHeaders() {
        return headers;
    }

    public void setHeaders(List<String> headers) {
        this.headers = headers;
    }

    public String getOutputRecon() {
        return outputRecon;
    }

    public void setOutputRecon(String outputRecon) {
        this.outputRecon = outputRecon;
    }

    public LinkedList<String> getCustomerFields() {
        return customerFields;
    }

    public void setCustomerFields(LinkedList<String> customerFields) {
        this.customerFields = customerFields;
    }
}
