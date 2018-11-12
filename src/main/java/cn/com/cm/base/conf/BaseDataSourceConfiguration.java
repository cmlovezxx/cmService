package cn.com.cm.base.conf;

import com.github.pagehelper.PageInterceptor;
import org.apache.ibatis.io.VFS;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.boot.autoconfigure.SpringBootVFS;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import javax.sql.DataSource;
import java.util.Properties;

public abstract class BaseDataSourceConfiguration {
    public static final String MAPPER_BASE_PACKAGES = "**.dao";
    public static final String MAPPER_LOCATIONS = "classpath*:/mapper/*.xml";

    protected final DataSource configDataSource(String clazName) throws ClassNotFoundException {
        ClassLoader currentLoader = null;
        DataSourceBuilder dsBuilder = null;
        try {
            currentLoader = Thread.currentThread().getContextClassLoader();
            dsBuilder = new DataSourceBuilder(currentLoader);
            DataSource localDataSource = dsBuilder.type((Class<? extends DataSource>) Class.forName(clazName)).build();
            return localDataSource;
        } finally {
            Thread.currentThread().setContextClassLoader(currentLoader);
        }
    }

    protected SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        VFS.addImplClass(SpringBootVFS.class);

        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource);

        PageInterceptor pageHelper = new PageInterceptor();
        Properties properties = new Properties();
        properties.setProperty("helperDialect", "mysql");

        pageHelper.setProperties(properties);

        sqlSessionFactoryBean.setPlugins(new Interceptor[]{pageHelper});

        PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
        sqlSessionFactoryBean.setMapperLocations(resolver.getResources("classpath*:/mapper/*.xml"));
        return sqlSessionFactoryBean.getObject();
    }

}
