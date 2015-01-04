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
		<script type="text/javascript">
			var clickBoolean=true;
			function tj2(){
				if(clickBoolean){
					clickBoolean=false;
					window.location="/personbank/HttpProxy?dse_sessionId=<%=dse_sessionId %>&URL=/midserv/midSelect.jsp";
				}
			}
		</script>
	</head>
	

	<body leftmargin="0" topmargin="0" oncontextmenu=self.event.returnValue=false onselectstart="return false">
		<center>
			<DIV align=center>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							请您仔细阅读涉及的相关协议、章程和业务规则，有不解之处可向交行提出咨询，您应自行决定是否申请办理羊城通自动充值服务。
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
<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
羊城通自动充值服务协议</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;甲方（广州羊城通有限公司）特别提请乙方（自动充值服务使用客户）注意，在签订自动充值协议前，需要认真阅读《羊城通自动充值服务章程》(下称《章程》和《羊城通自动充值服务业务规则》（下称《业务规则》）等文件，并清楚知晓签订本协议后所享有的权利和应承担的义务。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;乙方清楚了解本协议以及与本协议有关的《章程》和《业务规则》(具体细则参见www.gzyct.com)后，同意就“羊城通自动充值服务”事宜，与甲方签订本协议。
<BR><b>第一条	定义</b>
<BR>下列用语在本协议中的含义为：
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1.	羊城通卡：指由甲方按照《羊城通卡发行管理章程》发行，乙方持有并同意按照本协议使用的羊城通“普通卡”、“纪念卡”、“30卡”、“企业卡”等羊城通卡。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2.	羊城通自动充值服务（下称自动充值服务）：指甲方按照本协议约定和《章程》、《业务规则》规定，为乙方提供的快速、便捷的羊城通卡充值服务。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3.	合作银行：指与甲方签订合作协议，负责划付羊城通充值款的银行。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4.	乙方指定账户：指乙方在合作银行开立，通过羊城通自动充值交易与羊城通卡绑定，用于划付羊城通充值款的指定类别银行账户。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;5.	甲方指定账户：指甲方在合作银行开立，用于羊城通充值款划付的银行账户。
<BR><b>第二条	服务项目</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1.	为便于乙方使用自动充值服务，羊城通公司在特定公共场所安装可供乙方进行自动充值的羊城通自动充值终端设备(下称自动充值终端)。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2.	乙方如实录入签约信息自愿向甲方申请，并同意按照本协议和甲方制定的有关《章程》、《业务规则》，接受和使用自动充值服务。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3.	乙方为使用自动充值服务，同意将其持有的羊城通卡，与其指定的银行账户绑定，同意甲方在乙方接受自动充值服务期间，按照自动充值终端统一设定的充值款额度及充值频度，向合作银行发出充值款划付指令，由合作银行从乙方指定账户将充值款划付到甲方指定账户。充值款划付成功后，客户可持羊城通卡，按照《章程》和《业务规则》,自行通过自动充值终端将其充值款登记到其羊城通卡上。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4.	甲方可根据业务发展情况调整统一设定的充值款额度与充值频度，乙方可根据需要在自动充值终端将其充值额度及频度进行个性化选择。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;5.	甲方在自动充值终端上可提供所绑定的羊城通卡增减变更的功能，并根据合作银行规定设置开通与否。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;6.	如果甲方提供与自动充值服务相关的其他增值服务，双方将不再另行签订服务协议，甲方以公告或章程调整等方式通知乙方，乙方可通过自动充值终端进行操作，决定是否使用该增值功能。
<BR><b>第三条	服务费用</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1.	甲方不向客户收取自动充值服务的服务费用，但甲方保留根据实际情况收取服务费的权利。如果甲方决定收取服务费的，应当在收费前以公告的方式通知乙方。如果乙方不同意支付，可按照《章程》和《业务规则》与甲方解除本协议。如果乙方未与甲方解除本协议，即视为同意甲方收费，该服务费将由甲方直接从乙方指定的银行帐户款项中划取。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2.	若甲方提供其他有偿增值服务，收费前以公告或其他方式通知乙方，乙方可以自行决定是否接受，如果乙方同意或实际接受服务，即视为同意按照甲方的收费标准、收费方式支付费用。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3.	甲方可以根据经营成本等因素调整自动充值服务和增值服务的收费标准、收费时间和收费方式等，但应当在调整前以公告的方式通知乙方。如果乙方未按照《章程》和《业务规则》未与甲方解除本协议，即视为同意甲方的调整。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4.	乙方因使用自动充值及有关增值服务已经缴纳的费用，不能因本协议的中止、终止或解除而要求甲方退还。
<BR><b>第四条	双方的权利和义务</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1.	甲方有权根据实际情况，决定是否受理乙方的服务申请。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2.	自动充值服务系统所有权属于甲方，甲方可以按经营需要对其进行升级、改造，并增加或减少服务功能。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3.	在本协议有效期间，甲方提供自动充值交易、暂停和恢复等服务。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4.	甲方通过其网站公布《章程》和《业务规则》，为乙方提供有关的业务咨询、功能介绍、热点解答等服务。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;5.	甲方对乙方的申请资料和交易记录等信息承担保密责任，除非法律另有规定，不得提供给与甲方服务无关的其他方使用。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;6.	乙方须按照《章程》和《业务规则》的规定，持羊城通卡在自动充值终端进行激活操作，激活后该羊城通卡方可进行自动充值。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;7.	乙方可以按照《章程》和《业务规则》的规定，变更具体服务的内容，或暂停自动充值服务，或解除本协议。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;8.	乙方可以通过甲方提供的客户服务模式，进行咨询、投诉及提出建议或意见。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;9.	羊城通自动充值在银行系统进行绑定时录入的资料是本协议不可分割的组成部分，乙方有义务如实录入，保证内容真实准确、完整。乙方在签定本协议后，如果相关信息发生变化，应按照《章程》和《业务规则》办理变更手续，对于因乙方提供信息不真实或不完整，或未及时变更所造成的损失和引起的法律责任，有乙方自行承担。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;10.	乙方应妥善保管其持有的羊城通卡，并对业务密码等相关信息进行保密。自动充值终端只验证羊城通卡的信息、移动电话号码和业务密码，并不排除非乙方本人的操作，对于利用上述信息进行操作造成的损失和引起的法律责任，由乙方自行承担。对于符合《章程》和《业务规则》的操作指令，乙方不能变更或撤消。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;11.	乙方如果遗失羊城通卡，或泄露、遗忘业务密码，应按照《章程》和《业务规则》办理相应的“充值暂停”、“密码重置”手续，对于“充值暂停”、“密码重置“生效前的所造成的损失和引起的法律责任，应由乙方自行承担。 
<BR>&nbsp;&nbsp;&nbsp;&nbsp;12.	本协议有效期内，乙方不得变更指定账户，或将已与乙方指定账户绑定的羊城通卡转让给第三方，对于变更或转让所造成的损失和引起的法律责任，由乙方自行承担。
<BR><b>第五条	服务项目的变更及本协议的解除</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1.	乙方可以按照《章程》和《业务规则》的规定，变更具体服务内容，所作变更从自动充值系统收到乙方的指令并发出确认提示后生效。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2.	乙方按照《章程》和《业务规则》的规定，以与服务申请相同的方式解除本协议，解除于甲方确认受理该业务并将确认信息反馈给合作银行后生效。协议解除后，甲方将按照《章程》和《业务规则》的规定，终止为乙方提供服务。乙方已划付至甲方指定账户但尚未充值到羊城通卡的充值款余额，甲方通过银行转帐方式无息退还到乙方指定账户。若因乙方指定账户注销、变更等原因，造成转账退款不成功的，则退款事宜转由甲方的客户服务部门人工处理，在核实乙方身份后，无息退还充值款余额。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3.	出现下列情况之一，乙方相应的羊城通自动充值服务终止：
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1）乙方在充值款成功划付后的一年内，没有通过自动充值终端对羊称通卡进行充值；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2）羊城通卡的充值暂停时间超过《章程》和《业务规则》规定的时间
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3）法律规定的其他情况；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4.	出现下列情况之一，甲方可以拒绝为乙方羊城通卡提供自动充值服务而不承担违约责任：
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1）乙方指定账户存款余额或信用额度不足；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2）乙方指定账户被冻结或充值款划付不成功；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3）乙方没有按照《章程》和《业务规则》要求进行激活或充值操作；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4）不可抗力或其他不属于甲方责任的原因。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;5.	出现下列情况之一，甲方有权单方解除本协议而不承担违约责任，并保留追究乙方责任的权利：
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1）乙方未按时支付有关费用；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2）因乙方原因造成甲方无法进行充值款划付；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3）乙方不遵守《章程》和《业务规则》及相关业务规定；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4）乙方恶意操作自动充值终端，或恶意攻击自动充值系统；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;5）乙方利用虚假资料申请自动充值服务；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;6）乙方故意诋毁、损害甲方声誉；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;7）乙方利用自动充值服务进行违法活动；
<BR>&nbsp;&nbsp;&nbsp;&nbsp;8）法律法规以及《章程》和《业务规则》规定的其他情况。
<BR><b>第六条	法律适用及争议解决</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本协议适用中华人民共和国法律。因履行本协议而所发生的一切争议由甲方所在地人民法院管辖。
<BR><b>第七条	其他约定</b>
<BR>&nbsp;&nbsp;&nbsp;&nbsp;1.	本协议同时满足下列条件时生效：1）乙方填写并签署《申请表》或以电子、语音等其他方式签订本协议；2）乙方的服务申请经合作银行和甲方审查并同意。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;2.	乙方在本协议成立后生效前的行为，对乙方有约束力。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;3.	本协议、《章程》和《业务规则》是自动充值签约不可分割的组成部分，对双方有约束力。《章程》、《业务规则》等有关自动充值服务和其他增值服务的规定、规则和指引，由甲方根据实际情况制定、修改并公告，若乙方未在公告期满前提出异议或解除本协议，对乙方发生法律效力。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;4.	本协议约定不明的事项，有关双方权利义务的部分按法律法规解释；涉及自动充值终端技术的部分由甲方负责解释。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;5.	因不可抗力导致自动充值服务中断以至影响乙方使用的，甲方不承担任何经济和法律责任。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;6.	不可抗力包括：1）黑客攻击、计算机病毒侵入或发作、电信部门技术调整导致之影响、政府管制；2）国际出口的主干线路及国际出口电信提供商一方出现故障；3）火灾、水灾、雷击、地震、洪水、台风、龙卷风、火山爆发、瘟疫和传染病流行、罢工、战争或暴力行为或类似事件；4）其他非甲方过错的原因。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;7.	自动充值终端所显示的相关信息并不是自动充值服务及其他增值服务交易、变更、终止的最终依据，相关信息以甲方的系统记录为准，乙方同意以其作为羊城通卡交易结算的最终依据。但因合作银行或自动充值系统的技术原因导致甲方的利益受到损害除外。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;8.	所有使用乙方羊城通卡，或乙方羊城通卡号码、移动电话号码、业务密码，符合《章程》和《业务规则》的操作指令，均视为乙方所为，该操作指令所产生的电子信息记录，均为甲方处理自动充值服务和其他增值服务的有效凭据。
<BR>&nbsp;&nbsp;&nbsp;&nbsp;9.	有关本协议项下的通知等服务信息，乙方同意由甲方通过电子方式，包括但不限于以电子邮件、甲方或合作银行网站、移动电话短信等方式进行。
								</div>
							</td>
						</tr>
					</table>
				</FORM>
				<table>
					<tr>
						<td>
							<input type="button" onclick="tj2();" value="不同意" class="button_bg">
							<input type="button" onclick="tj();" value="同 意" class="button_bg">
						</td>
					</tr>
				</table>
			</DIV>
		</center>
	</body>
</html>
