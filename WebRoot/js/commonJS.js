/* 公用JS文件
 * author:张竞辉
 * date:2010-7-7
 *
 */
 
//查询当前被选中的记录，返回他们的数组//":checked[name='selectedRow']"
function getTheSelectedRowID(jqStr) {
	var i = 0;
	var idArray = new Array();
	jQuery(jqStr).each(function () {
		var value = jQuery(this).val();
		idArray[i] = value;
		i++;
	});
	return idArray;
}

//获取当前被选中的记录的扩展属性 参数为其扩展属性名称
function getSelRowByExtName(jqStr,extName){
	var i = 0;
	var valArray = new Array();
	jQuery(jqStr).each(function () {
		var value = jQuery(this).attr(extName);
		valArray[i] = value;
		i++;
	});
	return valArray;
}

//获得当前被选中的记录的条数
function getSelRowLength(jqStr){
	return getTheSelectedRowID(jqStr).length;
}

//获得当前被选中的记录ID的字符串，多个时，使用|符合拼接
function getSelRowIDStr(jqStr) {
	var idArray=getTheSelectedRowID(jqStr);
	return processTheIDArray(idArray);
}

//获得当前被选中的记录ID的数组，并且转换为JSON对象
function getSelRowIDJSONArray(jqStr){
	try{
		var idArray=getTheSelectedRowID(jqStr);
		//转换为JSON
		var paramJSON=JSON.stringify(idArray);
		return paramJSON;
	}catch(e){
		alert(e.message);
	}
}

//将选中的ID进行拼接
function processTheIDArray(idArray) {
	var result = "";
	jQuery.each(idArray, function (i, n) {
		result += "|" + n;
	});
	result = result.replace("|", "");
	return result;
}