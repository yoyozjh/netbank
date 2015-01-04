function showmenu(){
	if((!event.srcElement.disabled)&&(event.srcElement.tagName=="IMG"&&event.srcElement.id!="menugif"||event.srcElement.tagName=="A"||event.srcElement.tagName=="TEXTAREA"||event.srcElement.tagName=="INPUT"||document.selection.type!="None"))
		return true;
	else
		return false;
}