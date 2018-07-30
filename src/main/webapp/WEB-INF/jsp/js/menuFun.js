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
			var name=$(this).children('a').children('.classification-content-text').children(".name").html();
			var isMore=$("#isMore_"+vid).val();
			var url="";
			if(isMore==0){
				//window.location.href="general/general.html?className="+name+"&"+"classNo="+vid;
				url="general/general.html";
			}else{
				//window.location.href="general/generalMore.html?className="+name+"&"+"classNo="+vid;
				url="general/generalMore.html";
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
			var name=$(this).children('a').children('.classification-content-text').children(".cname").html();
			//window.location.href="contest/contest.html?className="+name+"&"+"classNo="+cid+"";	
			var url="contest/contest.html";
			if(isChangeTime){
				changeVideoPlayNum();
			}
			$("#subFrom").attr("action",cxPath+url);
	        $("#className").val(name);
	        $("#classNo").val(cid);
	        $("#subFrom").submit();
		})
		$('.gclassify').on('click',function(){
			var gsbuject = $(this).parents(".subinnerbox-content").siblings(".subinnerbox-title").html().trim();
			var gclassify = $(this).html().trim();
			var gclass = $(this).siblings(".gclass").html().trim(); 
			var url="";
			if(gsbuject=='数学'&&gclassify=='专题课'){
				 url="general/generalVideoList_zt.html";
				 //window.location.href="general/generalVideoList_zt.html?gsbuject="+gsbuject+"&"+"gclass="+gclass+"&"+"gclassify="+gclassify;
			}else{
				 url="general/generalVideoList.html";
				// window.location.href="general/generalVideoList.html?gsbuject="+gsbuject+"&"+"gclass="+gclass+"&"+"gclassify="+gclassify;
			}
			if(isChangeTime){
				changeVideoPlayNum();
			}
			general_list(url,gsbuject,gclass,gclassify);
		});
		$('.cclassify').on('click',function(){
			var competitionName = $(this).parents(".subinnerbox-content").siblings(".subinnerbox-title").html().trim();
			var cclassify = $(this).html().trim();
			var cclass = $(this).siblings(".cclass").html().trim(); 
	        //window.location.href="contest/contestVideoList.html?competitionName="+competitionName+"&"+"cclassify="+cclassify+"&"+"cclass="+cclass;	
			var url="contest/contestVideoList.html";
			if(isChangeTime){
				changeVideoPlayNum();
			}
			contest_list(url,competitionName,cclass,cclassify);
		});
		$('.etclassify').on('click',function(){
			var etsubject = $(this).parents(".subinnerbox-content").siblings(".subinnerbox-title").html().trim();
			var etclassify = $(this).html().trim();
			var etclass = $(this).siblings(".etclass").html().trim(); 
	       // window.location.href="exam/examlist.html?etsubject="+etsubject+"&"+"etclassify="+etclassify+"&"+"etclass="+etclass;
			var url="exam/examlist.html";
			if(isChangeTime){
				changeVideoPlayNum();
			}
	        exam_list(url,etsubject,etclass,etclassify);
		});
		$('.thisexam').on('click',function(){
			var etid = $(this).children('.eno').val();
			var name=$(this).children('a').children('.classification-content-text').children(".ename").html();
	             //window.location.href="exam/exam.html?etid="+etid+"&"+"name="+name+"";	
	            var url="exam/exam.html";
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
