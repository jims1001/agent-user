package com.agent.user.repository;
import com.agent.user.repository.entitys.User;
import jakarta.validation.constraints.Size;
import org.springframework.data.domain.Limit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, String> {
    Optional<Object> findUserByUsername(@Size(max = 255) String username);
}
