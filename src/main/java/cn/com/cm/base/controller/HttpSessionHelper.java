package cn.com.cm.base.controller;

import cn.com.cm.base.dto.LoginUser;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;

public class HttpSessionHelper {

    public static HttpSession getHttpSession() {
        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        return session;
    }

    public static void set(String name, Object value) {
        HttpSession session = getHttpSession();
        session.setAttribute(name, value);
    }

    public static Object get(String name) {
        HttpSession session = getHttpSession();
        return session.getAttribute(name);
    }

    public static LoginUser currentUser() {
        Object o = get("CURRENT_USER");
        if (o == null) {
            return null;
        }
        return (LoginUser) o;
    }

    public static void clearCurrentUser() {
        getHttpSession().removeAttribute("CURRENT_USER");
    }
}
