// Treeview 初始化
function initTreeView(treeConf){

    $.ajax({
        url:treeConf.url,
        type:'get',
        async:true,
        data:treeConf.paramData,
        timeout:5000,    //超时时间
        dataType:'json',
        success:function(data,textStatus,jqXHR){
            console.log(data);
            console.log(textStatus);
            console.log(jqXHR);
            ECP.tree = treeConf.treeObj.treeview({
                showBorder: false,
                showTags: false,
                highlightSelected: true,
                showIcon: false,
                showCheckbox: true,
                onNodeChecked: treeConf.onNodeChecked,
                onNodeUnchecked: treeConf.onNodeUnchecked,
                data: data.response
            });
            //$tree.treeview('findNodes','true', 'g', 'value.3');
            //$tree.treeview('checkNode',$tree.treeview('getNode','0'));

            //return $tree;
        },
        error:function(xhr,textStatus){
            console.log('错误')
            console.log(xhr)
            console.log(textStatus)
        }
    })
};