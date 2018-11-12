package cn.com.cm.base.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * @author : cm
 * @date : 2018/11/12 13:02
 * @modified By :
 */
public class PropertiesUtil {
    public PropertiesUtil() {
    }

    public static Properties readProperties(ClassLoader classLoader, String fileName) {
        Properties prop = new Properties();

        try {
            InputStream input = classLoader.getResourceAsStream(fileName);
            prop.load(input);
            input.close();
        } catch (IOException var4) {
            var4.printStackTrace();
        }

        return prop;
    }
}
