
function selectrow() {
	var myinput = arguments[0].getElementsByTagName("input");
	var type = myinput[0].getAttribute("type");
	if (type == "radio") {
		myinput[0].checked = true;
	}
	if (type == "checkbox") {
		if (myinput[0].checked) {
			myinput[0].checked = false;
		} else {
			myinput[0].checked = true;
		}
	}
}
function tj() {
	document.forms[0].submit();
}
String.prototype.Trim = function () {
	var m = this.match(/^\s*(\S+(\s+\S+)*)\s*/); 
	return (m == null) ? "" : m[1];
};
String.prototype.isMobile = function () {
	return (/^(?:13\d|15[89])-?\d{5}(\d{3}|\*{3})$/.test(this.Trim()));
};
String.prototype.isTel = function () {
//return (/^(([0+]d{2,3}-)?(0d{2,3})-)?(d{7,8})(-(d{3,}))?/.test(this.Trim()));
	return (/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?/.test(this.Trim()));
};
function onlyMunNoPointer() {
	if (event.keyCode < 48 || event.keyCode > 58) {
		if (event.keyCode != 190 && event.keyCode != 13) {
			event.returnValue = false;
		}
	}
}
function onlyMun() {
	if (event.keyCode < 48 || event.keyCode > 58) {
		if (event.keyCode != 190 && event.keyCode != 13 && event.keyCode != 46) {
			event.returnValue = false;
		}
	}
}
function PhoneCheck(s) {
	var str=s;
	var reg=/(^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}13[0-9]{9}$)/
	return reg.test(str);
}

function PostCheck(s) {
	var str=s;
	var reg=/(^[0-9]{6}$)/
	return reg.test(str);
}
function LimiteCheck(s) {
	var str=s;
	if(str<50){
		return false;
	}
	if(str%50!=0){
		return false;
	}
	return true;
}
