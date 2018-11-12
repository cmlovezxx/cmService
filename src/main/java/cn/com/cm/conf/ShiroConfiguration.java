package cn.com.cm.conf;

import cn.com.cm.base.conf.BaseShiroConfiguration;
import cn.com.cm.base.service.ShiroService;
import cn.com.cm.service.UserService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import java.util.LinkedHashMap;
import java.util.Map;

@Configuration
public class ShiroConfiguration extends BaseShiroConfiguration {


    @Bean(name = "shiroRealm")
    @DependsOn("lifecycleBeanPostProcessor")
    public ShiroRealm shiroRealm(ShiroService userService) {
        ShiroRealm realm = new ShiroRealm((UserService) userService);
        realm.setCredentialsMatcher(hashedCredentialsMatcher());
        return realm;
    }

    @Override
    public Map<String, String> getFilterChainDefinitionMap() {
        Map<String, String> filterChainDefinitionMap = new LinkedHashMap<String, String>();
        filterChainDefinitionMap.put("/logout", "logout");
        filterChainDefinitionMap.put("/**/*.js", "anon");
        filterChainDefinitionMap.put("/**/*.css", "anon");
        filterChainDefinitionMap.put("/**/*.ico", "anon");
        filterChainDefinitionMap.put("/**/*.tff", "anon");
        filterChainDefinitionMap.put("/**/*.woff", "anon");
        filterChainDefinitionMap.put("/images/*.jpg", "anon");
        filterChainDefinitionMap.put("/login", "anon");
        filterChainDefinitionMap.put("/login/auth", "anon");
        filterChainDefinitionMap.put("/authcode", "anon");
        filterChainDefinitionMap.put("/api/*", "anon"); // 开放接口
        filterChainDefinitionMap.put("/tmp/*/*/*.jpg", "anon"); // 开放接口
        filterChainDefinitionMap.put("/tmp/*/*/*.png", "anon"); // 开放接口
        filterChainDefinitionMap.put("/**", "authc");
        return filterChainDefinitionMap;
    }

}
