// Datatable 初始化
function initDatatable(dtConf){
    dtConf.tableObj.children('thead').children('tr').append($("<th>&nbsp;</th>"))
    if (dtConf.rowExt && typeof(dtConf.rowExt)==='function'){
        var extColumn = {
            "mRender": function(obj, type, full) {
                var htmlStr = "<i class='details-control glyphicon glyphicon-chevron-down' ></i>";
                return htmlStr;
            }
        };
        dtConf.columns.push(extColumn);
    }
    ECP.oTable = dtConf.tableObj.DataTable(
        {
            "sPaginationType": "full_numbers", //分页风格，full_number会把所有页码显示出来（大概是，自己尝试）
            "iDisplayLength": dtConf.pageSize,//每页显示10条数据
            "bAutoWidth": false,//宽度是否自动，感觉不好使的时候关掉试试
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "oLanguage": {//下面是一些汉语翻译
                "sSearch": "搜索",
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "没有检索到数据",
                "sInfo": "显示 _START_ 至 _END_ 条 &nbsp;&nbsp;共 _TOTAL_ 条",
                "sInfoFiltered": "(筛选自 _MAX_ 条数据)",
                "sInfoEmpty": "没有数据",
                "sProcessing": "正在加载数据...",
                "oPaginate":
                {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "末页"
                }
            },
            "bProcessing": true,
            "bServerSide": true,
            "sAjaxSource": dtConf.url,
            "fnServerData": retrieveData,
            "aaSorting": [[1, "asc"]],
            columns: dtConf.columns,
            columnDefs: dtConf.columnDefs,
            fnDrawCallback:dtConf.drawCallback
        }
    );
    if (dtConf.rowExt && typeof(dtConf.rowExt)==='function'){
        dtConf.tableObj.children('tbody').on('click', '.details-control', function () {
            var tr = $(this).closest('tr');
            var row = ECP.oTable.row( tr );
            if ( row.child.isShown() ) {
                row.child.hide("slow");
                tr.removeClass('shown');
                $(this).removeClass('glyphicon-chevron-up').addClass('glyphicon-chevron-down');
            } else {
                row.child("加载中...").show("slow");
                tr.addClass('shown');
                $(this).removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-up');
                dtConf.rowExt(row.data(), function (extData) {
                    $(".bigImg").unbind();
                    tr.removeClass('shown');
                    row.child(extData).show("slow");
                    tr.addClass('shown');
                    bindBigImage($(".bigImg"));
                });
            }
        } );
    };
    function getDtAjaxParam(aoData){
        var param = {};
        var formData = dtConf.formObj.serializeArray();
        formData.forEach(function (e) {
            param[e.name] = e.value;
        });
        aoData.forEach(
            function (d) {
                if(d.name === "iDisplayStart"){
                    param["pageNum"] = d.value / dtConf.pageSize + 1;
                    return false;
                }
            }
        )
        return param;
    };

    function retrieveData(sSource, aoData, fnCallback) {
        var param = getDtAjaxParam(aoData);
        $.ajax({
            url : sSource,
            data : param,
            type : "get",
            success : function(result) {
                if(result.success){
                    var a = {};
                    a["iTotalRecords"] = result.response.total;
                    a["iTotalDisplayRecords"] = result.response.total;
                    a["aaData"] = result.response.results;
                    fnCallback(a);
                } else {
                    SYSERR_DIALOG(result.code, result.msg);
                }
            },
            error : handleAjaxError
        });
    };

    function handleAjaxError( xhr, textStatus, error ) {
        if ( textStatus === 'timeout' ) {
            SYSERR_DIALOG(textStatus,'The server took too long to send the data.');
        }
        else {
            SYSERR_DIALOG(textStatus,'An error occurred on the server. Please try again in a minute.');
        }
        $('.dataTable').dataTable().fnProcessingIndicator( false );
    };
};;