function isIdCardNo(num) {

    var factorArr = new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1);
    var parityBit=new Array("1","0","X","9","8","7","6","5","4","3","2");
    var varArray = new Array();
    var intValue;
    var lngProduct = 0;
    var intCheckDigit;
    var intStrLen = num.length;
    var idNumber = num;
// initialize
    if ((intStrLen != 15) && (intStrLen != 18)) {
        return false;
    }
// check and set value
    for(i=0;i<intStrLen;i++) {
        varArray[i] = idNumber.charAt(i);
        if ((varArray[i] < '0' || varArray[i] > '9') && (i != 17)) {
            return false;
        } else if (i < 17) {
            varArray[i] = varArray[i] * factorArr[i];
        }
    }

    if (intStrLen == 18) {
//check date
        var date8 = idNumber.substring(6,14);
        if (isDate8(date8) == false) {
            return false;
        }
// calculate the sum of the products
        for(i=0;i<17;i++) {
            lngProduct = lngProduct + varArray[i];
        }
// calculate the check digit
        intCheckDigit = parityBit[lngProduct % 11];
// check last digit
        if (varArray[17] != intCheckDigit) {
            return false;
        }
    }
    else{ //length is 15
//check date
        var date6 = idNumber.substring(6,12);
        if (isDate6(date6) == false) {

            return false;
        }
    }
    return true;

}

function isDate6(sDate) {
    if(!/^[0-9]{6}$/.test(sDate)) {
        return false;
    }
    var year, month, day;
    year = sDate.substring(0, 4);
    month = sDate.substring(4, 6);
    if (year < 1700 || year > 2500) return false
    if (month < 1 || month > 12) return false
    return true
}

function isDate8(sDate) {
    if(!/^[0-9]{8}$/.test(sDate)) {
        return false;
    }
    var year, month, day;
    year = sDate.substring(0, 4);
    month = sDate.substring(4, 6);
    day = sDate.substring(6, 8);
    var iaMonthDays = [31,28,31,30,31,30,31,31,30,31,30,31]
    if (year < 1700 || year > 2500) return false
    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) iaMonthDays[1]=29;
    if (month < 1 || month > 12) return false
    if (day < 1 || day > iaMonthDays[month - 1]) return false
    return true
}

//字母数字
jQuery.validator.addMethod("alnum", function(value, element) {
    return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);
}, "只能包括英文字母和数字");

// 字符验证
jQuery.validator.addMethod("stringCheck", function(value, element) {
    return this.optional(element) || /^[u0391-uFFE5w]+$/.test(value);
}, "只能包括中文字、英文字母、数字和下划线");

// 中文字两个字节
jQuery.validator.addMethod("byteRangeLength", function(value, element, param) {
    var length = value.length;
    for(var i = 0; i < value.length; i++){
        if(value.charCodeAt(i) > 127){
            length++;
        }
    }
    return this.optional(element) || ( length >= param[0]&&length <= param[1] );
}, "请确保输入的值在3-15个字节之间(一个中文字算2个字节)");

// 必须以特定字符串开头验证
jQuery.validator.addMethod("begin", function(value, element, param) {
    var begin = new RegExp("^" + param);
    return this.optional(element) || (begin.test(value));
}, $.validator.format("必须以 {0} 开头!"));

// 验证两次输入值是否不相同
jQuery.validator.addMethod("notEqualTo", function(value, element, param) {
    return value != $(param).val();
}, $.validator.format("两次输入不能相同!"));

// 验证值不允许与特定值等于
jQuery.validator.addMethod("notEqual", function(value, element, param) {
    return value != param;
}, $.validator.format("输入值不允许为{0}!"));

// 验证值必须大于特定值(不能等于)
jQuery.validator.addMethod("gt", function(value, element, param) {
    return value > param;
}, $.validator.format("输入值必须大于{0}!"));

// 身份证号码验证
jQuery.validator.addMethod("isIdCardNo", function(value, element) {
    return this.optional(element) || isIdCardNo(value);
}, "请输入有效的身份证号码");

// 手机号码验证
jQuery.validator.addMethod("isMobile", function(value, element) {
    var length = value.length;
    var mobile = /^1[3|4|5|8][0-9]\d{4,8}$/;
    return this.optional(element) || (length == 11 && mobile.test(value));
}, "请输入有效的手机号码");

// 电话号码验证
jQuery.validator.addMethod("isTel", function(value, element) {
    var tel = /^d{3,4}-?d{7,9}$/; //电话号码格式010-12345678
    return this.optional(element) || (tel.test(value));
}, "请输入有效的电话号码");

// 联系电话(手机/电话皆可)验证
jQuery.validator.addMethod("isPhone", function(value,element) {
    var length = value.length;
    var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+d{8})$/;
    var tel = /^d{3,4}-?d{7,9}$/;
    return this.optional(element) || (tel.test(value) || mobile.test(value));

}, "请输入有效的联系电话");

// 邮政编码验证
jQuery.validator.addMethod("isZipCode", function(value, element) {
    var tel = /^[0-9]{6}$/;
    return this.optional(element) || (tel.test(value));
}, "请输入有效的邮政编码");

//正数
$.validator.addMethod("isPositive",function(value,element){
    var score = /^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/;
    return this.optional(element) || (score.test(value));
},"任意正整数，正小数（小数位不超过2位）");


//数字和小数点
$.validator.addMethod("version",function(value,element){
    var score =/[^\d.]/g;
    return this.optional(element) || (!score.test(value));
},"只能是数字和小数点");

var defaultValidateConfig = {
    errorElement: "em",
    errorPlacement: function ( error, element ) {
        error.addClass( "help-block" );
        element.parent( "div[class^='col-sm']").addClass( "has-feedback" );
        if ( element.prop( "type" ) === "checkbox" ) {
            error.insertAfter( element.parent( "label" ) );
        }
        else {
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
        $( element ).parent( "div[class^='col-sm']" ).addClass( "has-error" ).removeClass( "has-success" );
        $( element ).next( "span" ).addClass( "glyphicon-remove" ).removeClass( "glyphicon-ok" );
    },
    unhighlight: function ( element, errorClass, validClass ) {
        $( element ).parent( "div[class^='col-sm']" ).addClass( "has-success" ).removeClass( "has-error" );
        $( element ).next( "span" ).addClass( "glyphicon-ok" ).removeClass( "glyphicon-remove" );
    }
};

function initValidate(obj, conf){
    obj.validate($.extend({},defaultValidateConfig, conf));
}