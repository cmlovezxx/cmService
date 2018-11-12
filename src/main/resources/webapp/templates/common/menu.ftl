<style>
    .sidebar .nav > li > ul > li > a.change{
        background: #f1f1f1 !important;
    }
</style>
<div class="sidebar" style="display: block;" id="leftMenu">
    <nav class="sidebar-nev content-box">
        <ul class="nav" id="menu">
            <li class="submenu">
                <a href="javascript:void(0);"><i class="glyphicon glyphicon-tower"></i> 系统管理 <span class="caret pull-right"></span></a>
                <ul>
                    <li class="submenu-two two-level"><a href="javascript:void(0);" page="inf/loc"><i class="glyphicon glyphicon-info-sign"></i>用户管理</a></li>
                </ul>
            </li>
            <li class="submenu">
                <a href="javascript:void(0);"><i class="glyphicon glyphicon-dashboard"></i> aaa <span class="caret pull-right"></span></a>
                <ul>
                    <li class="submenu-two two-level"><a href="javascript:void(0);" page="demo/select"><i class="glyphicon glyphicon-hand-right"></i>aaa</a></li>
                </ul>
            </li>
        </ul>
    </nav>
</div>
<script type="text/javascript" src="base/js/jquery-1.12.3.min.js"></script>
<script>
    $(".two-level>a").each(function (i,v) {
        $(v).click(function () {
            $(".two-level>a").removeClass("change");
            $(this).addClass("change");
        })
    })
</script>
