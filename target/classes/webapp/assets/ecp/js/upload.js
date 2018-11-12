if (typeof UploadType == "undefined") {
    var UploadType = {};
    UploadType.tmp = 0;
    UploadType.Goods = 1;
    UploadType.GoodsPattern = 2;
    UploadType.GoodsDesign = 3;
    UploadType.GoodsResouce = 4;
    UploadType.System = 5;
}

function initUploaderMulty(obj, uploadConf) {
    uploadType = UploadType.tmp;
    if (uploadConf.uploadType) {
        uploadType = uploadConf.uploadType;
    }
    var options = {
        language: 'zh',
        uploadUrl: 'uploadMultipleFile?uploadType=' + uploadType,
        allowedPreviewTypes: ['image', 'html', 'text', 'video', 'audio', 'flash'],
        showClose: false,
        showPreview: false,
        showCaption: false,
        showUpload: false,
        browseOnZoneClick: true,
        maxFileCount: uploadConf.maxFileCount,
        showZoom: true
    };

    obj.fileinput(options);
    obj.on('fileclear', function (event) {
        if (uploadConf.fileClear) {
            uploadConf.fileClear(event);
        }
    });
    obj.on('filesuccessremove', function (event, id) {
        if (uploadConf.fileRemove) {
            return uploadConf.fileRemove($("#" + id).index(), event);
        }
        return true;
    });

    obj.on('fileuploaded', function (event, data, previewId, index) {
        // var form = data.form, files = data.files, extra = data.extra,
        //     response = data.response, reader = data.reader;
        if (uploadConf.fileUploaded) {
            uploadConf.fileUploaded(data.response.filenames, event);
        }
    });
    obj.on('filebatchselected', function (event) {
        $(this).fileinput("upload");
    });
}

function initUploader(obj, uploadConf) {
    uploadType = UploadType.tmp;
    if (uploadConf.uploadType) {
        uploadType = uploadConf.uploadType;
    }
    var options = {
        language: 'zh',
        uploadUrl: 'uploadFile?uploadType=' + uploadType,
        allowedPreviewTypes: ['image', 'html', 'text', 'video', 'audio', 'flash'],
        showClose: false,
        showPreview: false,
        showCaption: false,
        showUpload: false,
        browseOnZoneClick: true,
        maxFileCount: uploadConf.maxFileCount,
        showZoom: true
    };
    obj.fileinput(options);
    obj.on('fileclear', function (event) {
        if (uploadConf.fileClear) {
            uploadConf.fileClear();
        }
    });

    obj.on('fileuploaded', function (event, data, previewId, index) {
        // var form = data.form, files = data.files, extra = data.extra,
        //     response = data.response, reader = data.reader;
        if (uploadConf.fileUploaded) {
            uploadConf.fileUploaded(data.response.filenames);
        }
    });
    obj.on('filebatchselected', function (event) {
        $(this).fileinput("upload");
    });
}