<nav class="navbar header header-fixed" id="headerMenu">
    <a href="/"><img src="images/logo.png" alt="" style="width: 110px;height: 30px;margin-top: 10px;margin-left: 21px"></a>
    <p style="color: #fff;font-size: 24px;line-height: 52px;margin-left: 252px;margin-top: -40px;display: block;width: 500px">后台管理系统</p>
<#if Session.CURRENT_USER?exists>
    <ul class="nav navbar-nav pull-right">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle top-nav" data-toggle="dropdown" style="margin-top: -62px;"><i class="glyphicon glyphicon glyphicon-user"></i> ${Session.CURRENT_USER.userName!"我的帐号"}  <b class="caret"></b></a>
            <ul class="dropdown-menu animated fadeInUp">
                <li><a href="javascript:void(0);" page="User/toChangePassword"><i class="glyphicon glyphicon-pencil"></i> 修改密码</a></li>
                <li><a href="logout"><i class="glyphicon glyphicon-off"></i> 退出</a></li>
            </ul>
        </li>
    </ul>
</#if>
</nav>