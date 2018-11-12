package cn.com.cm.conf;

import cn.com.cm.base.conf.BaseWebConfiguration;
import cn.com.cm.base.interceptor.AccessControlInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;

@Configuration
public class WebAppConfiguration extends BaseWebConfiguration {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new AccessControlInterceptor()).addPathPatterns("/**");
        super.addInterceptors(registry);
    }
}
