package cn.com.cm.base.utils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Md5Util {
    private static final MessageDigest md5;
    protected static final char[] hexDigits;

    public static String bufferToHex(String value) {
        if (value == null) {
            return null;
        }

        return bufferToHex(md5.digest(value.getBytes()));
    }

    public static String bufferToHex(byte[] bytes) {
        return bufferToHex(bytes, 0, bytes.length);
    }

    public static String bufferToHex(byte[] bytes, int m, int n) {
        StringBuilder builder = new StringBuilder(2 * n);
        int k = m + n;
        for (int l = m; l < k; l++) {
            appendHexPair(bytes[l], builder);
        }
        return builder.toString();
    }

    private static void appendHexPair(byte bt, StringBuilder builder) {
        char c0 = hexDigits[((bt & 0xF0) >> 4)];
        char c1 = hexDigits[(bt & 0xF)];
        builder.append(c0);
        builder.append(c1);
    }

    static {
        try {
            md5 = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            CmLogs.error("MD5 digest failed", e);
            throw new RuntimeException(e);
        }

        hexDigits = new char[]{'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
    }
}
