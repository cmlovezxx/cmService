package cn.com.cm.service;


import cn.com.cm.base.dto.LoginUser;
import cn.com.cm.base.exception.CmBaseException;
import cn.com.cm.base.service.ShiroService;
import cn.com.cm.dao.UserDao;
import cn.com.cm.dao.entity.UserEntity;
import cn.com.cm.form.UserForm;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.subject.WebSubject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.ServletRequest;

@Service
public class UserService implements ShiroService {
    @Autowired
    private UserDao userDao;

    @Override
    public LoginUser doLogin(String username, String password) throws CmBaseException {
        //获取访问ip地址
        Subject currentUser = SecurityUtils.getSubject();
        ServletRequest servletRequest = ((WebSubject) currentUser).getServletRequest();
        String lastLoginIp = servletRequest.getRemoteAddr();
        UserEntity userEntity = new UserEntity();
        userEntity.setUserName(username);
        userEntity.setUserPassword(password);
        userEntity.setModifyDt(System.currentTimeMillis());
        userEntity.setLastLoginIp(lastLoginIp);
        // 根据用户Id查询用户信息
        UserEntity userEntityResult = userDao.findByUsername(userEntity);
//        if (null == userEntityResult) {
//            //用户不存在
//            JBaseExceptionHelper.throwBusinessException(MsgCode.E_MNG_BASE_USER_NOTHINGNESS);
//        } else if (!userEntityResult.getUserPassword().equals(userEntity.getUserPassword())) {
//            //密码错误
//            JBaseExceptionHelper.throwBusinessException(MsgCode.E_MNG_BASE_INVALID_PASSWORD);
//        } else if (Constant.DelFlag.DEL_KEY.equals(userEntityResult.getDelFlag())) {
//            //用户已停用
//            JBaseExceptionHelper.throwBusinessException(MsgCode.E_MNG_BASE_USER_DEACTIVATED);
//        } else if (Constant.StatusFlag.STOP_KEY.equals(userEntityResult.getStatus())) {
//            //用户已停用
//            JBaseExceptionHelper.throwBusinessException(MsgCode.E_MNG_BASE_USER_DEACTIVATED);
//        }
//        //session
        LoginUser loginUser = new LoginUser();
        loginUser.setUserId(userEntityResult.getUserId());
        loginUser.setUserName(userEntityResult.getUserName());
        loginUser.setPassword(userEntityResult.getUserPassword());
        loginUser.setRoleId(userEntityResult.getRoleId());
        loginUser.setRealName(userEntityResult.getRealName());
        loginUser.setPhone(userEntityResult.getPhone());
        //更新最后登录时间
        userDao.updateUserLastLoginDTAndLastLoginIp(userEntity);

        return loginUser;
    }

    public UserForm getUserById(UserForm userForm) {
        UserEntity userEntity = new UserEntity();
        userEntity.setUserId(userForm.getUserId());
        UserEntity entity = userDao.getUserById(userEntity);
        UserForm userFormRe = new UserForm();
        userFormRe.setUserId(entity.getUserId());
        userFormRe.setPhone(entity.getPhone());
        return userFormRe;
    }
}
