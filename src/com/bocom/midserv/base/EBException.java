package com.bocom.midserv.base;

/**
 * EBException 类，所有内部异常
 * @author: chengjj
 */
public class EBException extends Exception {

    /**
    异常错误信息描述
    */
    private String errMsg = null;

    /**
    异常错误码
    */
    private String errCode = null;
/**
 * EBBusinessException 构造函数
 * @param aCode java.lang.String 错误码
 * @param aMessage java.lang.String 错误信息
 */
public EBException(String aCode, String aMessage) {

    super(aMessage);

    errCode = aCode;
    errMsg = aMessage;

}
/**
 * 返回异常错误码
 * 创建日期：(2002-1-18 10:37:56)
 * @return java.lang.String
 */
public String getErrorCode() {
    return errCode;
}
/**
 * 返回异常错误信息
 * 创建日期：(2002-1-18 10:37:56)
 * @return java.lang.String
 */
public String getErrorMessage() {
	return errMsg;
}
/**
 * 设置错误码
 * 创建日期：(2002-1-18 10:37:56)
 * @return java.lang.String
 */
public void setErrorCode(String sCode) {
    errCode = sCode;
}
/**
 * 设置异常错误信息
 * 创建日期：(2002-1-18 10:37:56)
 * @return java.lang.String
 */
public void setErrorMessage(String sMsg) {
    errMsg = sMsg;
}
/**
 * 把异常转换成字串
 * 创建日期：(2001-11-21 15:49:57)
 * @return java.lang.String
 */
public String toString() {
    return errCode + ":" + errMsg;
}
}
