package cn.com.cm.conf;

import cn.com.cm.base.annotation.DruidPassword;
import cn.com.cm.base.annotation.DruidUsername;
import cn.com.cm.base.conf.BaseDruidConfiguration;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DruidConfiguration extends BaseDruidConfiguration {
    @Bean
    public ServletRegistrationBean regDruidServlet(@DruidUsername String loginUsername, @DruidPassword String loginPassword) {
        return super.regDruidServlet(loginUsername, loginPassword);
    }

    @Bean
    public FilterRegistrationBean createFilterRegistrationBean() {
        return super.createFilterRegistrationBean();
    }
}