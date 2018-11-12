package cn.com.cm.conf;

import cn.com.cm.base.annotation.DatasourceConfiguration;
import cn.com.cm.base.conf.BaseDataSourceConfiguration;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;

@DatasourceConfiguration
public class DataSourceConfiguration extends BaseDataSourceConfiguration {
    @Bean
    @ConfigurationProperties(prefix = "datasource.admin")
    public DataSource userDataSource(@Value("${datasource.admin.type}") String className) throws ClassNotFoundException {
        return super.configDataSource(className);
    }

    @Bean
    protected SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        return super.sqlSessionFactory(dataSource);
    }

}
