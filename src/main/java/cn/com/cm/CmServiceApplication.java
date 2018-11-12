package cn.com.cm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
public class CmServiceApplication {
    public static void main(String[] args) {
        SpringApplication application = new SpringApplication(CmServiceApplication.class);
        application.run(args);
    }
}
