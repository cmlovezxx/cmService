package cn.com.cm.base.controller;

public class RESTResponse<T> {

    private boolean success;
    private String code;
    private String msg;
    private T response;

    public RESTResponse() {
    }

    public RESTResponse(T response) {
        setSuccess(true);
        this.response = response;
    }

    public RESTResponse(String code, String msg) {
        setSuccess(false);
        setCode(code);
        setMsg(msg);
        setResponse(null);
    }

    public boolean isSuccess() {
        return this.success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return this.msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getResponse() {
        return this.response;
    }

    public void setResponse(T response) {
        this.response = response;
        setSuccess(true);
    }
}
