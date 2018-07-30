			function playVideo(url){
				changeVideoPlayNum();
				// 切换视频播放
				initPlayer(playerInstance,url,true);
			}
			function openUnitTest(){
				$("#openBtn").click();
			} 
			
			var isBuy = "${isBuy}";// 是否购买过
			var vvip = 0;
			var islogin = 0;
			var userIsVip = 0;
			var endTime;
			var timeII;
			var count = 7200;// 2小时
			var playerInstance;
			var time;// 播放时间
			var isPlay = false;
			$(function() {
				
				var playerwidth = $("#myvideo").width();
				var playerheight = $("#myvideo").height();
				playerInstance = jwplayer('myvideo');
				// var playerlimittime = 60;
				var playerlimittime = 300;
				// 会员的标识是会员为1
				var bpn = $('.bpns').val();
				islogin = "${user==null?0:1}";// 是否登录
				userIsVip = islogin == 0 ? 0 : "${user.isVip}";
				endTime = islogin == 0 ? ""
						: "${user.endTime==null?'':user.endTime}";
				vvip = "${contestVideo.cisVip}";
				// 初始化视频
				initPlayer(playerInstance, "${contestVideo.cvideoUrl}", false);
				$("#closeErweima").click(function() {// 关闭二维码时候判断是否继续播放
					clearInterval(timeII);// 停止计时器
					$.ajax({
						url : "${pageContext.request.contextPath}/order/checkOrderIsBuy",
						type : "post",
						data : {
							vid : "${contestVideo.cid}",
							vclassify : 1,
							uid : "${user.uid}"
						},
						async : false,
						success : function(res) {
							if (res == "ok") {
								isBuy = 1;
								playerInstance.play();
								$(".paybtn").removeAttr("onclick");
								$(".paybtn").html("已支付");
								$(".paybtn").css({
									background : "gray",
									color : "white"
								});
							}
						}
					});
								});
			});
			// 设置播放器参数
			function initPlayer(playerInstance, url, autostart) {
				var playerwidth = $("#myvideo").width();
				var playerheight = $("#myvideo").height();
				playerInstance.setup({
					// 视频文件路径
					file: url,
					// 未播放前图片路径
					image: "${pageContext.request.contextPath}/jsp/img/back.jpg",
					// 播放器宽度
					width: playerwidth,
					// 播放器高度
					height: playerheight,
					// 设置默认播放器的渲染模式。
					primary: "flash",
					// 设置视频铺满屏幕变换了形状
					stretching: "exactfit",
					autostart: autostart
					// 是否自动播放
				});
				// 监控播放时间
				playerInstance.onTime(function() {
					// 获取当前的播放时间
					time = playerInstance.getPosition();
					if (!isPlay) {
						$.post("${pageContext.request.contextPath}/video/changePlayCount", {
							vid: "${contestVideo.cid}",
							vclassify: 1
						},
						function() {});
						isPlay = true;
					}
					// 不回答问题不能进行播放下面的视频
					// if(vvip==1){
					if (vvip == 0) { // 数据库中：0：是；1：否 (20170326-update)
						if (isNeedBuy()) {
							if (time >= playerlimittime) {
								// 让播放条滑动到设定的时间段
								playerInstance.seek(playerlimittime);
								// 暂停当前播放视频
								playerInstance.pause();
								payErweima();
							}
						}
					}
				});
			
			}
			function isNeedBuy() {
				if ((userIsVip != 1 && isBuy == "0") || (userIsVip == 1 && (!compareTo(endTime) 
						|| (compareTo(endTime) && !isRight(islogin))) && isBuy == "0") || islogin == "0") {
					return true;
				}
				return false;
			}
			function isRight(islogin) {
				if (islogin == "0") {
					return false;
				} else {
					var rightContent = "${user.rightContent}";
					if (rightContent.length == 0) {
						return true;
					} else {
						var class_g = "${contestVideo.cclass}";
						var gclassify = "${contestVideo.cclassify}";
						var gsbuject = "${contestVideo.competitionName}";
						if (class_g.indexOf("古诗") > -1
								|| class_g.indexOf("阅读") > -1
								|| class_g.indexOf("写作") > -1
								|| class_g.indexOf("语法") > -1
								|| class_g.indexOf("流利英语") > -1) {
							class_g = "";
						}
						if (class_g == "") {
							return rightContent.indexOf(gsbuject + gclassify) > -1 ? true
									: false;
						}
						var class_arr = class_g.split(",");
						for ( var i in class_arr) {
							if (rightContent.indexOf(gsbuject + class_arr[i]
									+ gclassify) > -1) {
								return true;
							}
						}
						return false;
					}
				}
			}
			function payErweima() {
				if (islogin == "0") {
					alert("您还没有登录！");
					return;
				}
				// 发送请求到服务器生成订单号和二维码
				$.ajax({
					url: "${pageContext.request.contextPath}/order/getErweimaImg",
					data: {
						vid: "${contestVideo.cid}",
						vclassify: 1,
						uid: "${user.uid}"
					},
					type: "post",
					async: false,
					success: function(data) {
						var data = eval("(" + data + ")");
						var code = data.url;
						// alert("code=============="+code);
						// 修改二维码图片等信息
						if (code.length > 0) {
							var competitionName = "${contestVideo.competitionName}";
							var cclass = "${contestVideo.cclass}";
							var cclassify = "${contestVideo.cclassify}";
							var cname = "${contestVideo.cname}";
							if (cname.length > 0) {
								cname = "【" + cname + "】";
							}
							$("#bodyDes").html(competitionName + cclass + cclassify + cname); // 视频名称
							$(".msk h3").html("￥" + data.omoney); // 视频价格
							var url = "${pageContext.request.contextPath}/qr_codeImg?code_url=" + code;
							$("#erweimaImg").attr("src", url);
							$('.msk').show();
							timeStart(); // 支付计时开始
						} else {
							alert("支付二维码生成失败，请联系客服！");
						}
					}
				});
			}
			function readPdf(url, This) {
				var flag = false;
				if (vvip == 0) {
					if (isNeedBuy()) {
						if (islogin == "0") {
							alert("您还没有登录！");
						} else {
							alert("您还没有购买此视频！");
						}
					} else {
						flag = true;
					}
				} else {
					flag = true;
				}
				if (flag) {
					$(This).attr("href", url);
					$(This).attr("target", "_blank");
				}
			}
			function dowbLoad(url) {
				var flag = false;
				if (vvip == 0) {
					if (isNeedBuy()) {
						if (islogin == "0") {
							alert("您还没有登录！");
						} else {
							alert("您还没有购买此视频，不能下载！");
						}
					} else {
						flag = true;
					}
				} else {
					flag = true;
				}
				if (flag) {
					window.open(contextpath+"/download/file?url=" + url);
				}
			}
			function timeStart() {
				count = 7200;
				setSpanTime(count);
				var ii = setInterval(function() {
					timeII = ii;
					if (count > 0) {
						count--;
						setSpanTime(count);
					} else {
						$("#closeErweima").click();
					}

				}, 1000);
			}
			function setSpanTime(seconds) {
				$(".msk h4 span").html(getTimeVal(seconds));
			}
			function getTimeVal(seconds) {
				var val = "";
				var h = Math.floor(seconds / 3600);
				var m = Math.floor(seconds % 3600 / 60);
				var s = Math.floor(seconds % 3600 % 60);
				h = h < 0 ? 0 : h;
				m = m < 0 ? 0 : m;
				s = s < 0 ? 0 : s;
				val = h + "时" + m + "分" + s + "秒";
				return val;
			}
			// 日期比大小
			function compareTo(endTime) {
				var flag = false;
				if (endTime.length > 0) {
					var currdate = new Date();
					// 日期比较大小
					var endDate = new Date(Date.parse(endTime));
					if (endDate >= currdate) {
						flag = true;
					}
				}
				return flag;
			}
