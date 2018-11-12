<!--LOGIN-->
<!DOCTYPE html>
<html>
<head>
    <title>运营管理平台</title>
    <link rel="icon" type="image/x-icon" href="images/favicon.ico">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="base/css/dataTables.bootstrap.min.css" media="screen">
    <link rel="stylesheet" href="base/css/bootstrap.min.css">
    <link rel="stylesheet" href="base/css/bootstrap-theme.min.css">

    <link href="ecp/css/frame.css" rel="stylesheet">
    <link href="ecp/css/bootstrap-overrode.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="base/js/html5shiv.js"></script>
    <script src="base/js/respond.min.js"></script>
    <![endif]-->
</head>
<body class="login-bg" style="overflow: hidden">

<div class="page-content container">

    <div class="row">
        <div class="col-md-4 col-md-offset-4">
        <#if msg??>
            <div class="alert alert-danger">${msg}</div>
        </#if>
            <div class="login-wrapper">
                <div class="box">
                    <div class="content-wrap">
                        <form action="/login/auth" method="post" id="form">
                            <fieldset>
                            <#--<div style="background:url(images/logo-l.jpg) no-repeat;  height: 50px;"></div>-->
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input id="username" name="username" class="form-control" type="text" placeholder="请输入用户名">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input id="passwd" name="passwd" class="form-control" type="password" placeholder="请输入密码">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-8">
                                        <input id="authcd" name="authcd" class="form-control" type="text" placeholder="请输入验证码">
                                    </div>
                                    <div class="col-sm-4">
                                        <img id="authcode" src="/authcode"/>
                                    </div>
                                </div>
                                <input id="password" name="password" type="hidden">
                                <a class="btn btn-success btn-block m-t-20 btn-color" href="javascript:void(0);" onclick="login()">登录</a>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="base/js/jquery-1.12.3.min.js"></script>
<script type="text/javascript" src="base/js/jquery.md5.js"></script>
<script type="text/javascript" src="base/js/bootstrap.min.js"></script>
<script type="text/javascript" src="base/js/jquery.validate.js"></script>
<script type="text/javascript" src="base/js/messages_zh.js"></script>
<script src="ecp/js/validate.js"></script>
<script>
    function login(){
        var validateConfig = {
            rules: {
                username: {
                    required: true,
                    minlength: 3,
                    maxlength: 20
                },
                passwd: {
                    required: true,
                    minlength: 6,
                    maxlength: 20
                },
                authcd: {
                    required: true
                }
            },
            messages: {
                username: {
                    required: "请输入用户名"
                },
                passwd: {
                    required: "请输入密码"
                },
                authcd: {
                    required: "请输入验证码"
                }
            },
            errorElement: "em",
            errorPlacement: function ( error, element ) {
                error.addClass( "help-block" );
                element.parents( ".col-sm-12" ).addClass( "has-feedback" );
                element.parents( ".col-sm-8" ).addClass( "has-feedback" );
                if ( element.prop( "type" ) === "checkbox" ) {
                    error.insertAfter( element.parent( "label" ) );
                } else {
                    error.insertAfter( element );
                }
                if ( !element.next( "span" )[ 0 ] ) {
                    $( "<span class='glyphicon glyphicon-remove form-control-feedback'></span>" ).insertAfter( element );
                }
            },
            success: function ( label, element ) {
                // Add the span element, if doesn't exists, and apply the icon classes to it.
                if ( !$( element ).next( "span" )[ 0 ] ) {
                    $( "<span class='glyphicon glyphicon-ok form-control-feedback'></span>" ).insertAfter( $( element ) );
                }
            },
            highlight: function ( element, errorClass, validClass ) {
                $( element ).parents( ".col-sm-12" ).addClass( "has-error" ).removeClass( "has-success" );
                $( element ).parents( ".col-sm-8" ).addClass( "has-error" ).removeClass( "has-success" );
                $( element ).next( "span" ).addClass( "glyphicon-remove" ).removeClass( "glyphicon-ok" );
            },
            unhighlight: function ( element, errorClass, validClass ) {
                $( element ).parents( ".col-sm-12" ).addClass( "has-success" ).removeClass( "has-error" );
                $( element ).parents( ".col-sm-8" ).addClass( "has-success" ).removeClass( "has-error" );
                $( element ).next( "span" ).addClass( "glyphicon-ok" ).removeClass( "glyphicon-remove" );
            }
        };
        initValidate($( "#form" ), validateConfig);
        if(!$("#form").valid())
        {
            return;
        }
        $('#password').val($.md5('@'+$('#passwd').val()));
        $('#form').submit();
    }
    $("#authcode").click(function () {
        $("#authcode").attr("src","/authcode?"+ new Date());
    });
    $("body").keydown(function(e){
        if(e.keyCode==13){
            login();
        }
    });
</script>
</body>
</html>
