package cn.com.cm.base.service;

import cn.com.cm.base.exception.CmBaseException;

public abstract interface ShiroService {
    Object doLogin(String paramString1, String paramString2) throws CmBaseException;
}