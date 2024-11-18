package ph.com.pbcom.step.writer;

import org.apache.commons.lang3.tuple.ImmutablePair;
import org.springframework.batch.item.file.transform.LineAggregator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import ph.com.pbcom.config.AppProperties;

import java.util.List;
import java.util.Map;

@Component
public class CustomerLineAggregator implements LineAggregator<List<Map<String, ImmutablePair<String, String>>>> {

    @Autowired
    private AppProperties appProperties;

    @Override
    public String aggregate(List<Map<String, ImmutablePair<String, String>>> item) {

        StringBuilder sb = new StringBuilder();
        for (Map<String, ImmutablePair<String, String>> entryMap : item) {
            for ( String field : appProperties.getCustomerFields()) {
                ImmutablePair<String, String> pairVal = entryMap.get(field);
                sb.append("\"").append(pairVal.getLeft()).append("\"").append(",").append("\"")
                        .append(pairVal.getRight()).append("\"").append(",")
                        .append(pairVal.getLeft().equals(pairVal.getRight()) ? "\"NO\"" : "\"YES\"")
                        .append(",");
            }
            // Remove the trailing comma
            sb.deleteCharAt(sb.length() - 1);
        }
        return sb.toString();
    }
}