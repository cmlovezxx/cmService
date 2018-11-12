package cn.com.cm.base.utils;

import java.util.Map;

public class MessageContext {
    private static Map<String, String> msgMap;

    public static String getMsg(String code) {
        if (msgMap != null) {
            return (String) msgMap.get(code);
        }
        return null;
    }

    public static void init(Map<String, String> msgMap) {
        MessageContext.msgMap = msgMap;
    }
}