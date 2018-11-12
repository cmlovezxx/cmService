function initZtree(data,setting,zNodes){

    // 根据需求 编辑setting参数
    // var setting = {
    //     view: {
    //         showIcon: showIconForTree,
    //         showLine: false
    //         // addHoverDom: addHoverDom, 增加节点
    //         // removeHoverDom: removeHoverDom, 删除节点
    //         // selectedMulti: false
    //     },
    //     check: settingConf.check,
    //     edit: {
    //         drag: {
    //             autoExpandTrigger: true,
    //             prev: dropPrev,
    //             inner: dropInner,
    //             next: dropNext
    //         },
    //         enable: true,
    //         editNameSelectAll: settingConf.editNameSelectAll,
    //         showRemoveBtn: settingConf.showRemoveBtn,
    //         showRenameBtn: settingConf.showRenameBtn
    //     },
    //     data: {
    //         simpleData: {
    //             enable: true
    //         }
    //     },
    //     callback: {
    //         beforeDrag: beforeDrag,
    //         beforeDrop: beforeDrop,
    //         beforeDragOpen: beforeDragOpen,
    //         onDrag: onDrag,
    //         onDrop: onDrop,
    //         onExpand: onExpand,
    //         onClick: onClick
    //     }
    // };

    return $.fn.zTree.init(data, setting, zNodes);

    /* *** 隐藏节点图标 **** */
    function showIconForTree(treeId, treeNode) {
        return !treeNode.isParent;
    };
    /* *** 拖拽功能**** */
    function dropPrev(treeId, nodes, targetNode) {
        var pNode = targetNode.getParentNode();
        if (pNode && pNode.dropInner === false) {
            return false;
        } else {
            for (var i=0,l=curDragNodes.length; i<l; i++) {
                var curPNode = curDragNodes[i].getParentNode();
                if (curPNode && curPNode !== targetNode.getParentNode() && curPNode.childOuter === false) {
                    return false;
                }
            }
        }
        return true;
    }
    function dropInner(treeId, nodes, targetNode) {
        if (targetNode && targetNode.dropInner === false) {
            return false;
        } else {
            for (var i=0,l=curDragNodes.length; i<l; i++) {
                if (!targetNode && curDragNodes[i].dropRoot === false) {
                    return false;
                } else if (curDragNodes[i].parentTId && curDragNodes[i].getParentNode() !== targetNode && curDragNodes[i].getParentNode().childOuter === false) {
                    return false;
                }
            }
        }
        return true;
    }
    function dropNext(treeId, nodes, targetNode) {
        var pNode = targetNode.getParentNode();
        if (pNode && pNode.dropInner === false) {
            return false;
        } else {
            for (var i=0,l=curDragNodes.length; i<l; i++) {
                var curPNode = curDragNodes[i].getParentNode();
                if (curPNode && curPNode !== targetNode.getParentNode() && curPNode.childOuter === false) {
                    return false;
                }
            }
        }
        return true;
    }

    var log, className = "dark", curDragNodes, autoExpandNode;
    function beforeDrag(treeId, treeNodes) {
        className = (className === "dark" ? "":"dark");
        showLog("[ "+getTime()+" beforeDrag ]&nbsp;&nbsp;&nbsp;&nbsp; drag: " + treeNodes.length + " nodes." );
        for (var i=0,l=treeNodes.length; i<l; i++) {
            if (treeNodes[i].drag === false) {
                curDragNodes = null;
                return false;
            } else if (treeNodes[i].parentTId && treeNodes[i].getParentNode().childDrag === false) {
                curDragNodes = null;
                return false;
            }
        }
        curDragNodes = treeNodes;
        return true;
    }
    function beforeDragOpen(treeId, treeNode) {
        autoExpandNode = treeNode;
        return true;
    }
    function beforeDrop(treeId, treeNodes, targetNode, moveType, isCopy) {
        className = (className === "dark" ? "":"dark");
        showLog("[ "+getTime()+" beforeDrop ]&nbsp;&nbsp;&nbsp;&nbsp; moveType:" + moveType);
        showLog("target: " + (targetNode ? targetNode.name : "root") + "  -- is "+ (isCopy==null? "cancel" : isCopy ? "copy" : "move"));
        return true;
    }
    function onDrag(event, treeId, treeNodes) {
        className = (className === "dark" ? "":"dark");
        showLog("[ "+getTime()+" onDrag ]&nbsp;&nbsp;&nbsp;&nbsp; drag: " + treeNodes.length + " nodes." );
    }
    function onDrop(event, treeId, treeNodes, targetNode, moveType, isCopy) {
        className = (className === "dark" ? "":"dark");
        showLog("[ "+getTime()+" onDrop ]&nbsp;&nbsp;&nbsp;&nbsp; moveType:" + moveType);
        showLog("target: " + (targetNode ? targetNode.name : "root") + "  -- is "+ (isCopy==null? "cancel" : isCopy ? "copy" : "move"))
    }
    function onExpand(event, treeId, treeNode) {
        if (treeNode === autoExpandNode) {
            className = (className === "dark" ? "":"dark");
            showLog("[ "+getTime()+" onExpand ]&nbsp;&nbsp;&nbsp;&nbsp;" + treeNode.name);
        }
    }

    function showLog(str) {
        if (!log) log = $("#log");
        log.append("<li class='"+className+"'>"+str+"</li>");
        if(log.children("li").length > 8) {
            log.get(0).removeChild(log.children("li")[0]);
        }
    }
    function getTime() {
        var now= new Date(),
            h=now.getHours(),
            m=now.getMinutes(),
            s=now.getSeconds(),
            ms=now.getMilliseconds();
        return (h+":"+m+":"+s+ " " +ms);
    }
    /* *** 拖拽功能**** */
    function beforeEditName(treeId, treeNode) {
        className = (className === "dark" ? "":"dark");
        showLog("[ "+getTime()+" beforeEditName ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.selectNode(treeNode);
        return confirm("进入节点 -- " + treeNode.name + " 的编辑状态吗？");
    }
    function setEdit() {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
            remove = $("#remove").attr("checked"),
            rename = $("#rename").attr("checked"),
            removeTitle = $.trim($("#removeTitle").get(0).value),
            renameTitle = $.trim($("#renameTitle").get(0).value);
        zTree.setting.edit.showRemoveBtn = remove;
        zTree.setting.edit.showRenameBtn = rename;
        zTree.setting.edit.removeTitle = removeTitle;
        zTree.setting.edit.renameTitle = renameTitle;
        showCode(['setting.edit.showRemoveBtn = ' + remove, 'setting.edit.showRenameBtn = ' + rename,
            'setting.edit.removeTitle = "' + removeTitle +'"', 'setting.edit.renameTitle = "' + renameTitle + '"']);
    }
    function showCode(str) {
        var code = $("#code");
        code.empty();
        for (var i=0, l=str.length; i<l; i++) {
            code.append("<li>"+str[i]+"</li>");
        }
    }
    var newCount = 1;
    function addHoverDom(treeId, treeNode) {
        var sObj = $("#" + treeNode.tId + "_span");
        if (treeNode.editNameFlag || $("#addBtn_"+treeNode.id).length>0) return;
        var addStr = "<span class='button add' id='addBtn_" + treeNode.id
            + "' title='add node' onfocus='this.blur();'></span>";
        sObj.after(addStr);
        var btn = $("#addBtn_"+treeNode.id);
        if (btn) btn.bind("click", function(){
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            zTree.addNodes(treeNode, {id:(100 + newCount), pId:treeNode.id, name:"new node" + (newCount++)});
            return false;
        });
    };
    // 删除前
    function beforeRemove(treeId, treeNode) {
        className = (className === "dark" ? "":"dark")
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.selectNode(treeNode);
        return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
    }
    function removeHoverDom(treeId, treeNode) {
        $("#addBtn_"+treeNode.id).unbind().remove();
    };
    function selectAll() {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.setting.edit.editNameSelectAll =  $("#selectAll").attr("checked");
    }
    // 删除时触发
    function onRemove(e, treeId, treeNode) {
        //showLog("[ "+getTime()+" onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
    }
    // 改名时触发
    function onRename(e, treeId, treeNode) {
        //showLog("[ "+getTime()+" onRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
    }
    // 点击节点
    function onClick(event, treeId, treeNode, clickFlag) {
        //showLog("[ "+getTime()+" onClick ]&nbsp;&nbsp;clickFlag = " + clickFlag + " (" + (clickFlag===1 ? "普通选中": (clickFlag===0 ? "<b>取消选中</b>" : "<b>追加选中</b>")) + ")");
    }
};