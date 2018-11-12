package cn.com.cm.base.conf;

import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;

public class BaseDruidConfiguration {
    protected ServletRegistrationBean regDruidServlet(String loginUsername, String loginPassword) {
        ServletRegistrationBean reg = new ServletRegistrationBean();
        reg.setServlet(new StatViewServlet());
        reg.addUrlMappings(new String[]{"/druid/*"});
        if ((loginUsername != null) && (loginPassword != null)) {
            reg.addInitParameter("loginUsername", loginUsername);
            reg.addInitParameter("loginPassword", loginPassword);
        }
        return reg;
    }

    protected FilterRegistrationBean createFilterRegistrationBean() {
        FilterRegistrationBean filterRegistrationBean = new FilterRegistrationBean();
        filterRegistrationBean.setFilter(new WebStatFilter());
        filterRegistrationBean.addUrlPatterns(new String[]{"/*"});
        filterRegistrationBean.addInitParameter("exclusions", "*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*");
        return filterRegistrationBean;
    }
}
