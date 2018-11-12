package cn.com.cm.base.interceptor;

import cn.com.cm.base.annotation.JBaseAccessControl;
import cn.com.cm.base.controller.HttpSessionHelper;
import cn.com.cm.base.dto.LoginUser;
import org.apache.shiro.authz.AuthorizationException;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.annotation.Annotation;

public class AccessControlInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o)
            throws Exception {
        if ((o instanceof HandlerMethod)) {
            HandlerMethod methodObj = (HandlerMethod) o;
            String[] targetResources = getTargetResourceId(methodObj);
            LoginUser loginUser = HttpSessionHelper.currentUser();
            if (targetResources == null) {
                return true;
            }
            if (loginUser == null) {
                throw new AuthorizationException("用户未登录");
            }
            if (loginUser.getRoleId() == null) {
                throw new AuthorizationException("用户无任何权限");
            }
            for (String tgt : targetResources) {
                if ("*".equals(tgt)) {
                    return true;
                }
                if ((tgt != null) && (loginUser.getRoleId() != null) && (tgt.equals(loginUser.getRoleId()))) {
                    return true;
                }
            }

            throw new AuthorizationException("用户无任何权限");
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView)
            throws Exception {
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
    }

    private String[] getTargetResourceId(HandlerMethod methodObj) {
        Annotation[] annotations = methodObj.getMethod().getAnnotations();
        for (Annotation annotation : annotations) {
            if ((annotation instanceof JBaseAccessControl)) {
                JBaseAccessControl ecpAccessControl = (JBaseAccessControl) annotation;
                return ecpAccessControl.value();
            }
        }
        return null;
    }
}
