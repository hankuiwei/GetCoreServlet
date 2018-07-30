function initWebsocket(clientId,serverName,type){
	var WsBasePath="ws://"+serverName+":80/carRental/createWebsocket";
	//alert(serverName);
	if(clientId&&clientId.length>0){
		create_websocket(clientId,WsBasePath,type);
	}
}
function create_websocket(clientId,WsBasePath,type){
	    var socket;
	    var msg="ok";
		var url = WsBasePath+"?clientId="+clientId;
			try{
				socket = new WebSocket(url);
			}catch(e){
				msg="抱歉，您的浏览器不支持html5，请使用IE10或者最新版本的谷歌、火狐等浏览器！";
			}
			//打开Socket 
			socket.onopen = function(event) {
				//alert("打开连接:"+clientId);
			};
			//接收服务器发送的消息
			socket.onmessage = function(event) {
				if(type){//pc端使用桌面通知
					if (notify.isSupported){//桌面弹出
						if (notify.permissionLevel() === notify.PERMISSION_GRANTED) {
							notify.createNotification('标题',{body:event.data, icon: "http://www.oschina.net/img/logo/chrome.png",tag:"消息"});
						} else {
							notify.requestPermission(function(result) {
								if (result === notify.PERMISSION_DENIED || result === notify.PERMISSION_DEFAULT) {
									msg='通知权限被无情的拒绝了！';
								} else {
									notify.createNotification('标题',{body:event.data, icon: "http://www.oschina.net/img/logo/chrome.png",tag:"消息"});
								}
							});
						};
					} else {
						msg='你的浏览器不支持桌面通知，请使用其他浏览器';
					}
					if(msg!="ok"){
						alert(msg);
					}
				}else{//手机端使用浮动层
						var vvhtml=$(".popnews").html();
						if(!vvhtml){//不存在，创建一个
							 $('body').append('<div class="popnews" onclick="webSocketReload()" style="display:none;">'
									    +'<h3 class="fw fs12 color666" id="h3_date">2019-08-19  23:59</h3>'
									    +'<h2 class="fw fs14 color39" id="h2_websocket" style="color:green;">发消息人名称：消息内容消息内容。</h2>'
									    +'<span class="popdel"></span>'
									    +'</div>');
									 $('.popdel').click(function(){
									  $('.popnews').hide();
							         });
						}
					$("#h2_websocket").html(event.data);
					$("#h3_date").html(new Date());
					$(".popnews").show(); 
					setTimeout(function(){
						$(".popnews").hide(); 
					},15000);//15秒钟后隐藏浮动层
				}
			};
			// 监听Socket的关闭
			  socket.onclose = function(event) { 
			   alert('Client notified socket has closed',event); 
			  }; 
			  // 关闭Socket.... 
			  //socket.close() 
	return 	msg;
}
function webSocketReload(){ 
	location.reload();
}