package ph.com.pbcom.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ph.com.pbcom.model.Customer;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, String> {
}
