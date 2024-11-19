package ph.com.pbcom.model;

import io.hypersistence.utils.hibernate.type.json.JsonType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import org.hibernate.annotations.Type;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

@Entity
public class Customer implements Serializable {

    public Customer() {
    }

    @Id
    private String id;

    private String coCode;

    private String mnemonic;
    private String shortName;
    private String name1;
    private String name2;

    @Type(JsonType.class)
    @Column(columnDefinition = "json")
    private Map<String, String> properties = new HashMap<>();

    public String getCoCode() {
        return coCode;
    }

    public void setCoCode(String coCode) {
        this.coCode = coCode;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMnemonic() {
        return mnemonic;
    }

    public void setMnemonic(String mnemonic) {
        this.mnemonic = mnemonic;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public String getName1() {
        return name1;
    }

    public void setName1(String name1) {
        this.name1 = name1;
    }

    public String getName2() {
        return name2;
    }

    public void setName2(String name2) {
        this.name2 = name2;
    }

    public Map<String, String> getProperties() {
        return properties;
    }

    public void setProperties(Map<String, String> properties) {
        this.properties = properties;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "coCode='" + coCode + '\'' +
                ", id='" + id + '\'' +
                ", mnemonic='" + mnemonic + '\'' +
                ", shortName='" + shortName + '\'' +
                ", name1='" + name1 + '\'' +
                ", name2='" + name2 + '\'' +
                '}';
    }
}
