function SYSERR_DIALOG(code,msg){
    BootstrapDialog.show({
        type: BootstrapDialog.TYPE_DANGER,
        title: '<b>*** 系统错误 ***</b>',
        message: 'CODE：'+ code + '<br>MESSAGE:' + msg,
        closable: false,
        buttons: [{
            id: 'btn-ok',
            icon: 'glyphicon glyphicon-check',
            label: '确定',
            cssClass: 'btn-primary',
            autospin: false,
            action: function(dialogRef){
                dialogRef.close();
            }
        }]
    });
}

function ECPInfo(msg, callback){
    BootstrapDialog.show({
        type: BootstrapDialog.TYPE_SUCCESS,
        title: '<b>系统提示</b>',
        message: msg,
        closable: false,
        buttons: [{
            id: 'btn-ok',
            icon: 'glyphicon glyphicon-check',
            label: '确定',
            cssClass: 'btn-primary',
            autospin: false,
            action: function(dialogRef){
                dialogRef.close();
                if(callback){
                    callback();
                }
            }
        }]
    });
}
function ECPError(msg, callback){
    BootstrapDialog.show({
        type: BootstrapDialog.TYPE_WARNING,
        title: '<b>系统提示</b>',
        message: msg,
        closable: false,
        buttons: [{
            id: 'btn-ok',
            icon: 'glyphicon glyphicon-check',
            label: '确定',
            cssClass: 'btn-primary',
            autospin: false,
            action: function(dialogRef){
                dialogRef.close();
                if(callback){
                    callback();
                }
            }
        }]
    });
}
function ECPConfirm(msg, callback, attr){
    BootstrapDialog.show({
        type: BootstrapDialog.TYPE_INFO,
        title: '<b>确认</b>',
        message: msg,
        closable: false,
        buttons: [{
            id: 'btn-ok',
            icon: 'glyphicon glyphicon-ok-circle',
            label: '确定',
            cssClass: 'btn-primary',
            autospin: false,
            action: function(dialogRef){
                dialogRef.close();
                if(callback){
                    callback(1, attr);
                }
            }
        },{
            id: 'btn-cancel',
            icon: 'glyphicon glyphicon-remove-circle',
            label: '取消',
            cssClass: 'btn-primary',
            autospin: false,
            action: function(dialogRef){
                dialogRef.close();
                if(callback){
                    callback(0, attr);
                }
            }
        }]
    });
}

function ECPModel(modelConfig){
    BootstrapDialog.show({
        type: BootstrapDialog.TYPE_INFO,
        title: modelConfig.title,
        message: modelConfig.content,
        closable: false,
        buttons: [{
            id: 'btn-ok',
            icon: 'glyphicon glyphicon-ok-circle',
            label: modelConfig.OK.text,
            cssClass: 'btn-primary',
            autospin: false,
            action: function(dialogRef){
                dialogRef.close();
                console.log(this.parent());
                if(modelConfig.OK.callback){
                    modelConfig.OK.callback(1);
                }
            }
        },{
            id: 'btn-cancel',
            icon: 'glyphicon glyphicon-remove-circle',
            label: modelConfig.CANCEL.text,
            cssClass: 'btn-primary',
            autospin: false,
            action: function(dialogRef){
                dialogRef.close();
                if(modelConfig.CANCEL.callback){
                    modelConfig.CANCEL.callback(0);
                }
            }
        }]
    });
}