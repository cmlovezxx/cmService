package cn.com.cm.base.utils;

import org.apache.shiro.crypto.hash.SimpleHash;

public class PasswordUtil {
    public static String encodePasswordForRegister(String passwd, String salt) {
        String password = Md5Util.bufferToHex("@" + passwd);
        password = salt + "." + password + "@ecpECP";
        password = Md5Util.bufferToHex(password);
        SimpleHash sh = new SimpleHash("MD5", password, null, 2);
        return sh.toString();
    }

    public static SimpleHash encodePasswordForAuthInfo(String password) {
        return new SimpleHash("MD5", password, null, 2);
    }

    public static String encodePasswordForLogin(String passwd, String salt) {
        String password = salt + "." + passwd + "@ecpECP";
        password = Md5Util.bufferToHex(password);
        SimpleHash sh = new SimpleHash("MD5", password, null, 2);
        return sh.toString();
    }
}
