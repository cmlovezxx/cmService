package cn.com.cm.base.annotation;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;

import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Bean(name = {"msgResource"})
@ConfigurationProperties(prefix = "msg")
public @interface MsgBean {
}