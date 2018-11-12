package cn.com.cm.conf;

import cn.com.cm.base.dto.LoginUser;
import cn.com.cm.base.exception.CmBaseException;
import cn.com.cm.base.utils.PasswordUtil;
import cn.com.cm.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.Subject;

public class ShiroRealm extends AuthorizingRealm {

    private UserService userService;

    public ShiroRealm(UserService userService){
        this.userService = userService;
    }

    /**
     * 授权
     * @param principals
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        //获取当前登录的用户名,等价于(String)principals.fromRealm(this.getName()).iterator().next()
        String currentUsername = (String)super.getAvailablePrincipal(principals);
//        MemberModel member = memberService.getMemberByName(currentUsername);
//        if(member == null){
//            throw new AuthenticationException("msg:用户不存在。");
//        }
        SimpleAuthorizationInfo simpleAuthorInfo = new SimpleAuthorizationInfo();
        simpleAuthorInfo.addRole("ROLE_000");
        simpleAuthorInfo.addStringPermission("PERMISSION_000");

//        List<RoleModel> roleList = memberService.selectRoleByMemberId(member.getId());
//        List<PermissionModel> permList = memberService.selectPermissionByMemberId(member.getId());
//
//        if(roleList != null && roleList.size() > 0){
//            for(RoleModel role : roleList){
//                if(role.getRoleCode() != null){
//                    simpleAuthorInfo.addRole(role.getRoleCode());
//                }
//            }
//        }
//
//        if(permList != null && permList.size() > 0){
//            for(PermissionModel perm : permList){
//                if(perm.getCode() != null){
//                    simpleAuthorInfo.addStringPermission(perm.getCode());
//                }
//            }
//        }
        return simpleAuthorInfo;
    }

    /**
     * 登录
     * @param authcToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
        //获取基于用户名和密码的令牌
        //实际上这个authcToken是从LoginController里面currentUser.login(token)传过来的
        UsernamePasswordToken token = (UsernamePasswordToken)authcToken;
        String username = token.getUsername();
        String password = String.valueOf(token.getPassword());

        LoginUser loginUser = null;
        try {
            loginUser = userService.doLogin(username, password);
        } catch (CmBaseException e) {
            throw new AuthenticationException(e.getMsg());
        }

        Subject currentUser = SecurityUtils.getSubject();
        Session session = currentUser.getSession();
        session.setAttribute("CURRENT_USER", loginUser);

        SimpleHash simpleHash = PasswordUtil.encodePasswordForAuthInfo(loginUser.getPassword());
        return new SimpleAuthenticationInfo(loginUser.getUserName(), simpleHash, this.getName());
    }
}
