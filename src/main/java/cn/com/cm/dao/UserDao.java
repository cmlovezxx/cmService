package cn.com.cm.dao;


import cn.com.cm.dao.entity.UserEntity;

import java.util.List;

public interface UserDao {

    /**
     * 根据用户名查用户信息
     *
     * @param userEntity
     * @return
     */
    UserEntity findByUsername(UserEntity userEntity);

    /**
     * @param
     * @Author:cm
     * @Description: 获取用户数据list
     * @params:
     * @Date:2017/9/29 16:38
     * @Modified By:
     */
    List<UserEntity> getUser(UserEntity userEntity);

    /**
     * @param
     * @Author:cm
     * @Description:
     * @params:
     * @Date:2017/9/30 10:23
     * @Modified By:
     */
    boolean addUser(UserEntity userEntity);

    /**
     * @param userEntity
     * @Author:cm
     * @Description:根据id获取该id用户信息
     * @params:
     * @Date:2017/10/9 10:39
     * @Modified By:
     */
    UserEntity getUserById(UserEntity userEntity);

    boolean updateUser(UserEntity userEntity);

    boolean startOrStop(UserEntity userEntity);

    boolean toResetPwd(UserEntity userEntity);

    boolean toRemove(UserEntity userEntity);

    List<UserEntity> isUser(UserEntity userEntity);

    /**
     * 修改密码
     *
     * @param userEntity
     * @return
     */
    boolean changePassword(UserEntity userEntity);

    /**
     * 检查用户密码
     *
     * @param userEntity
     * @return
     */
    UserEntity checkPassword(UserEntity userEntity);

    /**
     * 更新用户登录时间与IP
     *
     * @param userEntity
     */
    Boolean updateUserLastLoginDTAndLastLoginIp(UserEntity userEntity);
}