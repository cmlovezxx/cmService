package cn.com.cm.base.conf;

import cn.com.cm.base.utils.CmLogs;
import cn.com.cm.base.utils.MessageContext;
import cn.com.cm.base.utils.PropertiesUtil;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

public class BaseMsgConfiguration
        implements ApplicationListener<ContextRefreshedEvent> {

    @Resource(name = "msgResource")
    private Properties msgResource;

    public Properties getMsgResource(String fileName) {
        Properties prop = PropertiesUtil.readProperties(getClass().getClassLoader(), fileName);
        return prop;
    }

    @Override
    public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
        Map msgMap = new HashMap();
        CmLogs.info("********************** MSG: " + this.msgResource);
        for (Iterator localIterator = this.msgResource.keySet().iterator(); localIterator.hasNext(); ) {
            Object key = localIterator.next();
            msgMap.put(key.toString(), this.msgResource.getProperty(key.toString()));
        }
        MessageContext.init(msgMap);
        CmLogs.info("********************** MessageContext.init(): Finished.");
    }
}
