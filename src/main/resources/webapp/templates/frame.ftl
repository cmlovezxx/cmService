<!DOCTYPE html>
<html>
<head>
    <title>运营管理平台</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/x-icon" href="images/favicon.ico">
    <link rel="stylesheet" href="base/css/dataTables.bootstrap.min.css" media="screen">
    <link rel="stylesheet" href="base/css/bootstrap.min.css">
    <link rel="stylesheet" href="base/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="base/css/bootstrap-treeview.css">
    <link rel="stylesheet" href="base/css/bootstrap-dialog.min.css">
    <link rel="stylesheet" href="base/css/bootstrap-switch.min.css">
    <link rel="stylesheet" href="base/fileinput/css/fileinput.min.css">

    <link href="ecp/css/frame.css" rel="stylesheet">
    <link href="ecp/css/bootstrap-overrode.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="base/js/html5shiv.js"></script>
    <script src="base/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <#include "common/header.ftl"/>
    <div class="page-content">
        <div class="pull-left">
        <#include "common/menu.ftl"/>
        </div>
        <div class="pull-right" style="width: calc(100% - 250px)">
            <MainContent>
                Loading ...
            </MainContent>
        </div>
    </div>
    <#include "common/footer.ftl"/>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script type="text/javascript" src="base/js/jquery-1.12.3.min.js"></script>
    <script type="text/javascript" src="base/js/jquery-ui.js"></script>

    <!-- Latest compiled and minified JavaScript -->
    <script type="text/javascript" src="base/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="base/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="base/js/dataTables.bootstrap.min.js"></script>
    <script type="text/javascript" src="base/js/bootstrap-treeview.js"></script>
    <script type="text/javascript" src="base/js/bootstrap-dialog.min.js"></script>
    <script type="text/javascript" src="base/js/bootstrap-switch.min.js"></script>
    <script type="text/javascript" src="base/js/jquery.validate.min.js"></script>
    <script type="text/javascript" src="base/js/messages_zh.js"></script>
    <script type="text/javascript" src="base/fileinput/js/fileinput.js"></script>
    <script type="text/javascript" src="base/fileinput/js/fileinput_locale_zh.js"></script>
    <script type="text/javascript" src="base/js/echarts.js"></script>
    <script type="text/javascript" src="base/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="base/js/jquery.ztree.excheck-3.5.js"></script>
    <script type="text/javascript" src="base/js/jquery.ztree.exedit-3.5.js"></script>
    <script type="text/javascript" src="base/js/jquery.ztree.exhide-3.5.js"></script>
    <script type="text/javascript" src="base/js/jquery.ztree.exhide-3.5.min.js"></script>
    <script src="base/bootstrap-datetimepicker/bootstrap-datetimepicker.js"></script>
    <script src="base/bootstrap-datetimepicker/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="ecp/js/require.js"></script>
    <script src="ecp/js/frame.js"></script>
    <script src="ecp/js/datatable.js"></script>
    <script src="ecp/js/treeview.js"></script>
    <script src="ecp/js/dialog.js"></script>
    <script src="ecp/js/validate.js"></script>
    <script src="ecp/js/upload.js"></script>
    <script src="ecp/js/ztree.js"></script>
</body>
</html>

