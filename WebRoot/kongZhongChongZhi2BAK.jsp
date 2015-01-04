<%@ page language="java" pageEncoding="gbk"%>
<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog log = new GzLog("c:/gzLog");
	String dse_sessionId = MessManTool.changeChar(request.getParameter("dse_sessionId"));//获取dse_sessionId
	String biz_id = MessManTool.changeChar(request.getParameter("biz_id"));
	if (biz_id.equals("") ) {
		System.out.println("传入参数不正确");
	}
%>
<!-------------------------------------------------------------------
                          标准JavaScript库引用
--------------------------------------------------------------------->
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/public.js&dse_sessionId=<%=dse_sessionId%>"></script>
<script language="JavaScript" src="/personbank/HttpProxy?URL=/midserv/js/common.js&dse_sessionId=<%=dse_sessionId%>"></script>

<!--------------------------------------------------------------------
   当前页面JavaScript函数部分，包括提交验证，页面动作，具体目标等代码
---------------------------------------------------------------------->

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->
<html>
	<head>
		<title>交通银行网上服务</title>
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/personbank.css&dse_sessionId=<%=dse_sessionId%>">
		<link rel="stylesheet"
			href="/personbank/HttpProxy?URL=/midserv/css/midserv.css&dse_sessionId=<%=dse_sessionId%>">
		<link href="/personbank/css/csspt.css" rel="stylesheet"
			type="text/css">
		<link href="/personbank/css/content.css" rel="stylesheet" type="text/css">
	</head>
	

	<body leftmargin="0" topmargin="0" oncontextmenu=self.event.returnValue=false onselectstart="return false">
		<center>
			<DIV align=center>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td
							background="/personbank/HttpProxy?URL=/midserv/images/pageTitle.gif&dse_sessionId=<%=dse_sessionId%>"
							class="pageTitle">
							&nbsp;&nbsp;签 约 协 议
						</td>
						<td rowspan="2" align="right" valign="top">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td>
							<img
								src="/personbank/HttpProxy?URL=/midserv/images/xianb.gif&dse_sessionId=<%=dse_sessionId%>"
								width="100" height="20">
						</td>
					</tr>
				</table>
				<FORM action="/personbank/HttpProxy" method=post name="f1">
					<input type="hidden" name="dse_sessionId"
						value="<%=dse_sessionId%>">
					<input type="hidden" name="URL" value="/midserv/kongZhongChongZhi3.jsp">
					<input type="hidden" name=biz_id value="<%=biz_id %>">
					<input type="hidden" name=step_id value="2">
					<table border="0" cellspacing="2" cellpadding="0" align="center"
						width="85%">
						<tr>
							<td align="left" height="22" width="8%" class="TableRow2">
								<div style="margin-left: 5;margin-right: 5;margin-bottom: 10;margin-top: 15">
<b>第一条	定义下列用语在本协议中的含义为：</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1.	羊城通卡：指由羊城通公司按照《羊城通卡发行管理章程》发行，客户持有并同意按照本协议使用的羊城通“普通卡”、“纪念卡”、“30卡”、“企业卡”等羊城通卡。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2.	羊城通自动充值服务（下称自动充值服务）：指羊城通公司按照本协议约定通过自动充值终端设备（下称自动充值终端），为客户提供的快速、便捷的羊城通卡充值服务。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3.	合作银行：指与羊城通公司签订合作协议，负责划付羊城通充值款的银行。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4.	客户指定账户：指客户在合作银行开立，通过填写有关申请信息通过签约画面指定与羊城通卡绑定，用于划付羊城通充值款的指定类别的账户。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;5.	羊城通公司指定账户：指羊城通公司在合作银行开立，用于羊城通充值款划付的银行账户。
<BR><b>第二条	服务项目</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1.	为便于客户使用自动充值服务，羊城通公司在特定公共场所安装可供客户进行自动充值的羊城通自动充值终端。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2.	客户如实填写签约信息自愿向羊城通公司申请，并同意按照本协议和羊城通公司制定的有关客户手册、业务规则、章程等，接受和使用自动充值服务。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3.	客户为使用自动充值服务，同意将其持有的羊城通卡，与其指定的账户绑定，同意羊城通公司在客户接受自动充值服务期间，按照自动充值终端统一设定的充值款额度及充值频度，向合作银行发出充值款划付指令，由合作银行从客户指定账户将充值款划付到羊城通公司指定账户。充值款划付成功后，客户可持羊城通卡，通过自动充值终端将其充值款登记到其羊城通卡上。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4.	客户可在自动充值设备上实现自动充值、修改充值额度与频度、业务密码与充值密码。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;5.	羊城通公司可根据业务发展情况调整统一设定的充值款额度和充值频度，客户可根据需要在自动充值终端上进行充值额度及频度的个性化选择。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;6.	如果羊城通公司提供与自动充值服务相关的其他增值服务，双方将不再另行签订服务协议，羊城通公司以公告等方式通知客户，客户可通过自动充值终端进行操作，决定是否使用该增值功能。
<BR><b>第三条	服务费用</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1.	羊城通公司不向客户收取自动充值服务的服务费用，但羊城通公司保留根据实际情况收取服务费的权利。如果羊城通公司决定收取服务费的，应当在收费前以公告的方式通知客户。如果客户不同意支付，可以与羊城通公司解除本协议。如果客户未与羊城通公司解除本协议，即视为同意羊城通公司收费，该服务费将由羊城通公司直接从客户指定的银行帐户款项中划取。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2.	若羊城通公司提供其他有偿增值服务，收费前以公告或其他方式通知客户，客户可以自行决定是否接受，如果客户同意或实际接受服务，即视为同意按照羊城通公司的收费标准、收费方式支付费用。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3.	羊城通公司可以根据经营成本等因素调整自动充值服务和增值服务的收费标准、收费时间和收费方式等，但应当在调整前以公告的方式通知客户。如果客户未与羊城通公司解除本协议，即视为同意羊城通公司的调整。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4.	客户因使用自动充值及有关增值服务已经缴纳的费用，不能因本协议的中止、终止或解除而要求羊城通公司退还。
<BR><b>第四条	双方的权利和义务</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1.	羊城通公司有权根据实际情况，决定是否受理客户的服务申请。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2.	自动充值服务系统所有权属于羊城通公司，羊城通公司可以按经营需要对其进行升级、改造，并增加或减少服务功能。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3.	在本协议有效期间，羊城通公司提供自动充值交易、暂停和恢复等服务。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4.	羊城通公司通过其网站公布自动充值服务内容，为客户提供有关的业务咨询、功能介绍、热点解答等服务。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;5.	羊城通公司对客户的申请资料和交易记录等信息承担保密责任，除非法律另有规定，不得提供给与羊城通公司服务无关的其他方使用。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;6.	客户须按照羊城通公司制定的自动充值业务的相关管理，持羊城通卡在自动充值终端进行激活操作，激活后该羊城通卡方可进行自动充值。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;7.	客户可以通过羊城通公司提供的客户服务模式，进行咨询、投诉及提出建议或意见。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;8.	客户应妥善保管其持有的羊城通卡，并对业务密码等相关信息进行保密。羊城通公司以联名卡的羊城通ＩＣ芯片信息、电话号码、业务密码和充值密码（可选）作为识别客户有效身份的标识，作为自动充值服务的合法有效依据。持卡人应妥善保管上述信息，若非持卡人本人操作的，对于利用上述信息进行操作造成的损失和引起的法律责任，由持卡人自行承担。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;9.	对于羊城通公司验证无误并已执行的充值款划付指令和充值交易等操作指令，客户不能变更或撤销。 
<BR>&nbsp;&nbsp;&nbsp;&nbsp;10.	本协议有效期内，客户不得变更指定账户，或将已与客户指定账户绑定的羊城通卡转让给第三方，对于变更或转让所造成的损失和引起的法律责任，由客户自行承担。
<BR><b>第五条	服务项目的变更及本协议的解除</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1.	客户可以按照本协议规定变更具体服务内容，所作变更从自动充值系统收到客户的指令并发出确认提示后生效。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2.	客户可以与服务申请相同的方式解除本协议，解除经合作银行确认后生效。协议解除后，羊城通公司终止为客户提供服务。客户已划付至羊城通公司指定账户但尚未充值到羊城通卡的充值款余额，羊城通公司通过银行转帐方式无息退还到客户指定账户。若因客户指定账户注销、变更等原因，造成转账退款不成功的，则退款事宜转由羊城通公司的客户服务部门人工处理，在核实客户身份后，无息退还充值款余额。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3.	客户在充值款成功划付后的一年内，没有通过自动充值终端对羊城通卡进行充值的，客户相应的羊城通卡自动充值服务终止。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4.	出现下列情况之一，羊城通公司可以拒绝为客户羊城通卡提供自动充值服务而不承担违约责任：
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1）客户指定账户信用额度不足；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2）客户指定账户被冻结或充值款划付不成功；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3）客户没有按要求进行激活或充值操作；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4）不可抗力或其他不属于羊城通公司责任的原因。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;5.	出现下列情况之一，羊城通公司有权单方解除本协议而不承担违约责任，并保留追究客户责任的权利：
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1）客户未按时支付有关费用；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2）因客户原因造成羊城通公司无法进行充值款划付；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3）客户不遵守自动充值服务相关管理规定；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4）客户恶意操作自动充值终端，或恶意攻击自动充值系统；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;5）客户利用虚假资料申请自动充值服务；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;6）客户故意诋毁、损害羊城通公司声誉；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;7）客户利用自动充值服务进行违法活动；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;8）法律法规规定的其他情况。
<BR><b>第六条	法律适用及争议解决</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本协议适用中华人民共和国法律。因履行本协议而所发生的一切争议由羊城通公司所在地人民法院管辖。
<BR><b>第七条	其他约定</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1.	本协议同时满足下列条件时生效：1）客户填写并签署本协议或以电子、语音等其他方式签订本协议；2）客户的服务申请经合作银行和羊城通公司审查并同意。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2.	乙方在本协议成立后生效前的行为，对乙方有约束力。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3.	本协议、《章程》和《业务规则》是自动充值签约不可分割的组成部分，对双方有约束力。《章程》、《业务规则》等有关自动充值服务和其他增值服务的规定、规则和指引，由甲方根据实际情况制定、修改并公告，若乙方未在公告期满前提出异议或解除本协议，对乙方发生法律效力。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4.	本协议约定不明的事项，有关双方权利义务的部分按法律法规解释；涉及自动充值终端技术的部分由羊城通公司负责解释。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;5.	因不可抗力导致自动充值服务中断以至影响客户使用的，羊城通公司不承担任何经济和法律责任。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;6.	不可抗力包括：1）黑客攻击、计算机病毒侵入或发作、电信部门技术调整导致之影响、政府管制；2）国际出口的主干线路及国际出口电信提供商一方出现故障；3）火灾、水灾、雷击、地震、洪水、台风、龙卷风、火山爆发、瘟疫和传染病流行、罢工、战争或暴力行为或类似事件；4）其他非羊城通公司过错的原因。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;7.	自动充值终端所显示的相关信息并不是自动充值服务及其他增值服务交易、变更、终止的最终依据，相关信息以羊城通公司的系统记录为准，客户同意以其作为羊城通卡交易结算的最终依据。但因合作银行或自动充值系统的技术原因导致羊城通公司的利益受到损害除外。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;8.	所有使用客户羊城通卡，或客户羊城通卡号码、移动电话号码、业务密码，符合自动充值业务要求的操作指令，均视为客户所为，该操作指令所产生的电子信息记录，均为羊城通公司处理自动充值服务和其他增值服务的有效凭据。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;9.	有关本协议项下的通知等服务信息，客户同意由羊城通公司通过电子方式，包括但不限于以电子邮件、羊城通公司或合作银行网站、移动电话短信等方式进行。
								</div>
							</td>
						</tr>
					</table>
				</FORM>
				<table>
					<tr>
						<td>
							<input type="button" onclick="window.history.back();" value="不同意" class="button_bg">
							<input type="button" onclick="tj();" value="同 意" class="button_bg">
						</td>
					</tr>
				</table>
			</DIV>
		</center>
	</body>
</html>
