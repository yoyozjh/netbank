<table width="50%" border="0" cellspacing="0" cellpadding="0"><tr>交易流程提示：</tr>
<tr>第一步：选择业务种类。</tr>
<tr>第二步：输入交费号码，提交。</tr>
<tr>第三步：系统返回相关交费信息，客户确认交费
<tr>第四步：确认交费金额并输入交易密码<%=request.getParameter("loginType")!=null&&request.getParameter("loginType").equals("0")?"和手机动态密码":"" %>，提交。</tr>
<tr>返回交易结果。</tr></table>