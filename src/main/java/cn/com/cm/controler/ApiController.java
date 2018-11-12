package cn.com.cm.controler;

import cn.com.cm.base.controller.RESTResponse;
import cn.com.cm.base.exception.CmBaseException;
import cn.com.cm.form.UserForm;
import cn.com.cm.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

/**
 * Created by cm on 2018/5/23.
 */
@Controller
@RequestMapping(value = "/api")
public class ApiController {

    @Resource
    private UserService userService;

    /**
     * 获取用户信息通过用户Id
     *
     * @return
     * @throws CmBaseException
     */
    @ResponseBody
    @GetMapping(value = "/getUserById")
    public RESTResponse<UserForm> getUserById(UserForm userForm) throws CmBaseException {
        RESTResponse<UserForm> restResponse = new RESTResponse<>();
        UserForm userFormRe = userService.getUserById(userForm);
        restResponse.setResponse(userFormRe);
        return restResponse;
    }
}
