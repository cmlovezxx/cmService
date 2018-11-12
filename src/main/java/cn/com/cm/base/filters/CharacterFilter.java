package cn.com.cm.base.filters;

import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CharacterFilter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        filterChain.doFilter(new HttpServletRequestWrapper(request) {
                                 @Override
                                 public String getParameter(String name) {
                                     return CharacterFilter.this.filterDangerString(super.getParameter(name));
                                 }

                                 @Override
                                 public String[] getParameterValues(String name) {
                                     String[] values = super.getParameterValues(name);
                                     if (values != null) {
                                         for (int i = 0; i < values.length; i++) {
                                             values[i] = CharacterFilter.this.filterDangerString(values[i]);
                                         }
                                     }
                                     return values;
                                 }
                             }
                , response);
    }

    public String filterDangerString(String value) {
        if (value == null) {
            return null;
        }

        value = value.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
        value = value.replaceAll("\\(", "&#40;").replaceAll("\\)", "&#41;");
        value = value.replaceAll("'", "&#39;");
        value = value.replaceAll("eval\\((.*)\\)", "");
        value = value.replaceAll("[\\\"\\'][\\s]*javascript:(.*)[\\\"\\']", "\"\"");
        value = value.replaceAll("script", "");
        return value;
    }
}
