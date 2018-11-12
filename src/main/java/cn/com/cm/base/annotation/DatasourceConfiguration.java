package cn.com.cm.base.annotation;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Configuration
@MapperScan(basePackages = {"**.dao"})
public @interface DatasourceConfiguration {
}
