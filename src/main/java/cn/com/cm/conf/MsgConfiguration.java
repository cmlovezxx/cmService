package cn.com.cm.conf;

import cn.com.cm.base.annotation.MsgBean;
import cn.com.cm.base.annotation.MsgFile;
import cn.com.cm.base.conf.BaseMsgConfiguration;
import org.springframework.context.annotation.Configuration;

import java.util.Properties;

@Configuration
public class MsgConfiguration extends BaseMsgConfiguration {

    @MsgBean
    public Properties getMsgResource(@MsgFile String fileName) {
        return super.getMsgResource(fileName);
    }
}
