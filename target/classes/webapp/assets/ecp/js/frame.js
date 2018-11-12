if (typeof String.prototype.startsWith != 'function') {
	String.prototype.startsWith = function (prefix){
		return this.slice(0, prefix.length) === prefix;
	};
};
if (typeof String.prototype.endsWith != 'function') {
    String.prototype.endsWith = function(suffix) {
        return this.indexOf(suffix, this.length - suffix.length) !== -1;
    };
};
function go(pageUrl){
	if (!pageUrl) return;
	menuLock = true;
	showMainPage(pageUrl);
};

function bindBigImage(imgObj){
	imgObj.click(function () {
		var src = $(this).attr('src')
		imageZoom(src)
	});
}

/**
 * 图片放大
 * @param src
 */
function imageZoom(src) {
	var screenW = $(document).width(),
		screenH = $(document).height(),
		imgBox = $('<div class="imgBox" data-role="imgBox"><div><p><img src=' + src + ' style="max-width:' + screenW * 0.8 + 'px; max-height:' + screenH * 0.8 + 'px;"></p></div></div>');
	console.log(screenW, screenH)
	$('body').append(imgBox);
	$('div[data-role="imgBox"]').on('click', function () {
		$(this).remove()
	})
}

function showMainPage(url) {
	console.log("** TARGET PAGE URL: " + url);
	$.get(url,
		function(data,status,xhr) {
			if(typeof(data)==='string'){
				if(data.startsWith('<!--LOGIN-->')){
					ECPError("登录超时，请重新登录！", function(){
						location.href = "/login";
					});
					return;
				}
				$("MainContent").find("*").unbind();
				if (ECP.release){
					ECP.release();
				}
				$("MainContent").empty();
				delete ECP;
				ECP = {};
				// UE.clear();
				$("MainContent").html("loading...");
				$("#leftMenu li").removeClass("current");
				$(this).parent().addClass("current");

				$("MainContent").html(data);
				menuLock = false;
				if (ECP.onloadMain) {
					ECP.onloadMain();
				}
			} else {
				if(data && data.msg){
					ECPError(data.msg);
				} else {
					ECPError("系统错误。");
				}
			}
		});
};

var ECP={};
$(function() {
	var menuLock = false;
	// 初始化首页
	$("MainContent").empty();
	showMainPage("index");

	// 菜单点击
	$(".submenu > a").click(function(e) {
		e.preventDefault();
		var $li = $(this).parent("li");
		var $ul = $(this).next("ul");
		if ($li.hasClass("open")) {
			$ul.slideUp(350);
			$li.removeClass("open");
		} else {
			$(".nav > li > ul").slideUp(350);
			$(".nav > li").removeClass("open");
			$ul.slideDown(350);
			$li.addClass("open");
		}
	});
	$("#leftMenu a").click(function(e) {
		if (menuLock) return;
		var pageUrl = $(this).attr("page");
		go(pageUrl);
	});

});

var exportMain = function(mainPageJs) {
	ECP = mainPageJs;
	mainPageJs = undefined;
};