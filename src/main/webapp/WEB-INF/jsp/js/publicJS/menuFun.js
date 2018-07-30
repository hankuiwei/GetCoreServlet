/**
 * 菜单点击触发函数
 */
var cxPath="/GetCoreServlet/";
var isChangeTime=false;
function setChangeTimeStatus(flag){
	isChangeTime=flag;
}
function general_list(url,gsbuject,gclass,gclassify,pageNo,nameType,sort){
	 $("#subFrom").attr("action",cxPath+url);
     $("#gsbuject").val(gsbuject);
     $("#gclassify").val(gclassify);
     $("#gclass").val(gclass);
     try{
    	 $("#nameType").val(nameType);
         $("#sort").val(sort);
     }catch(e){}
     if(pageNo){
    	 $("#pageNo").val(pageNo);
     }else{
    	 $("#pageNo").val(1); 
     }
     $("#subFrom").submit();
}
function contest_list(url,competitionName,cclass,cclassify,pageNo){
	$("#subFrom").attr("action",cxPath+url);
    $("#competitionName").val(competitionName);
    $("#cclassify").val(cclassify);
    $("#cclass").val(cclass);
    if(pageNo){
   	 $("#pageNo").val(pageNo);
    }else{
   	 $("#pageNo").val(1); 
    }
    $("#subFrom").submit();
}

function teacher_list(url,pageNo){
	$("#subFrom").attr("action",cxPath+url);
	if(pageNo){
	   	 $("#pageNo").val(pageNo);
    }else{
    	$("#pageNo").val(1); 
    }
    $("#subFrom").submit();
}
function getOneTeacher(url,tid){
	$("#subFrom").attr("action",cxPath+url);
	$("#tid").val(tid);
    $("#subFrom").submit();
}
function student_list(url,pageNo){
	$("#subFrom").attr("action",cxPath+url);
	if(pageNo){
	   	 $("#pageNo").val(pageNo);
    }else{
    	$("#pageNo").val(1); 
    }
    $("#subFrom").submit();
}
function getOneStudent(url,pid){
	$("#subFrom").attr("action",cxPath+url);
	$("#pid").val(pid);
    $("#subFrom").submit();
}


function latestCourse_list(url,pageNo){
	$("#subFrom").attr("action", cxPath + url);
	if (pageNo) {
		$("#pageNo").val(pageNo);
	} else {
		$("#pageNo").val(1);
	}
	$("#subFrom").submit();
}

function exam_list(url,etsubject,etclass,etclassify,pageNo){
	$("#subFrom").attr("action",cxPath+url);
    $("#etsubject").val(etsubject);
    $("#etclassify").val(etclassify);
    $("#etclass").val(etclass);
      if(pageNo){
      	 $("#pageNo").val(pageNo);
       }else{
      	 $("#pageNo").val(1); 
       }
    $("#subFrom").submit();
}
$(function(){
		$('.thisv').on('click',function(){
			var vid = $(this).children('.no').val();
			var name=$(this).children('a').children(".name").html();
			var isMore=$("#isMore_"+vid).val();
			var url="";
			if(isMore==0){
				url="public/generalCourseDetail";
			}else{
				url="public/generalCourseDetail_more";
			}
			if(isChangeTime){
				changeVideoPlayNum();
			}
			    $("#subFrom").attr("action",cxPath+url);
		        $("#className").val(name);
		        $("#classNo").val(vid);
		        $("#subFrom").submit();
		});
		$('.thisc').on('click',function(){
			var cid = $(this).children('.cno').val();
			var name=$(this).children('a').children(".name").html();//好像不太重要...
			var url="public/competitionCourseDetail";
			if(isChangeTime){
				changeVideoPlayNum();
			}
			$("#subFrom").attr("action",cxPath+url);
	        $("#className").val(name);
	        $("#classNo").val(cid);
	        $("#subFrom").submit();
		})
		
		$('.info_img').on('click',function(){
			if(document.title == '常规课'){
				var gsubject = $(".cur.active").html().trim();
				var gclassify = $(this).children(".info_name_cclassify").html().trim(); 
				var gclass = $(this).children(".info_name_cclass").html().trim(); 
				var url="";
				if(gsubject=='数学'&&gclassify=='专题课'){
					 url="public/generalCourseList_zt";
				}else{
					 url="public/generalCourseList";
				}
				if(isChangeTime){
					changeVideoPlayNum();
				}
				general_list(url,gsubject,gclass,gclassify);
			}else if(document.title == '竞赛课'){
				var competitionName = $(".cur.active").html().trim();
				var cclassify = $(this).children(".info_name_cclassify").html().trim(); 
				var cclass = $(this).children(".info_name_cclass").html().trim(); 
				var url="public/competitionCourseList";
				if(isChangeTime){
					changeVideoPlayNum();
				}
				contest_list(url,competitionName,cclass,cclassify);
			}else if(document.title == '小测试'){
				var etsubject = $(".cur.active").html().trim();
				var etclass = $(this).children(".info_name_cclass").html().trim(); 
				var etclassify = $(this).children(".info_name_cclassify").html().trim(); 
				var url="public/examList";
				if(isChangeTime){
					changeVideoPlayNum();
				}
				exam_list(url,etsubject,etclass,etclassify);
			}
			
		});
		
		$('.thisexam').on('click',function(){
			var etid = $(this).children('.eno').val();
			var name=$(this).children('a').children(".ename").html();
            var url="public/examDetail";
		    $("#subFrom").attr("action",cxPath+url);
	        $("#etid").val(etid);
	        $("#name").val(name);
	        $("#subFrom").submit();
		});
	});

$(function(){
	$(".exitUser").on("click",function(){
		if(isChangeTime){
			changeVideoPlayNum();
		}
		window.location.href=cxPath+"/user/exitUser";
	});
});


function searchVideo(id){
	var keyword=$("#"+id).val();
	if(keyword.length > 0){
		window.location.href=encodeURI(cxPath+"searchVideo?keyword="+encodeURI(keyword) );
	}else{
		alert("搜索的视频名称不能为空!");
	}
}
