package cn.com.cm.base.conf;

import cn.com.cm.base.filters.CharacterFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import javax.servlet.Filter;

public class BaseWebConfiguration extends WebMvcConfigurerAdapter {
    @Bean(name = {"characterFilter"})
    public Filter characterFilter() {
        return new CharacterFilter();
    }
}
