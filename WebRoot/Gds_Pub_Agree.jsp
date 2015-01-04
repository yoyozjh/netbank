<%@ page pageEncoding="GBK"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<% request.setCharacterEncoding("GBK");%>

<%@ page import="com.bocom.midserv.gz.*"%>
<%@ page import="com.viatt.bean.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.*"%>

<%
    String uri = request.getRequestURI();
    /* 获取总行全局参数 */
    //获取客户当前使用的CSS样式
    String cssFileName = request.getParameter("cssFileName");
    //获取dse_sessionId
    String dse_sessionId = request.getParameter("dse_sessionId");
    //获取卡号
    String cardNo = request.getParameter("cardNo");
    //获取卡号
    String custName = request.getParameter("custName");

    //创建日志实例
    GzLog log = new GzLog("c:/gzLog");
    log.Write(cardNo+"进入["+uri+"]");


%>

<html>
    <head>
        <title>交通银行网上服务</title>
        <!-- 总行样式表，定义总体色调与表格等格式 -->
        <link rel="stylesheet" type="text/css" href="/personbank/css/<%=cssFileName%>">
        <!-- 分行样式表，定义段落、超链接格式 -->
        <link rel="stylesheet" type="text/css"
            href="/personbank/HttpProxy?URL=/midserv/css/css.css&dse_sessionId=<%=dse_sessionId%>">
    </head>


    <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  oncontextmenu=self.event.returnValue=false onselectstart="return false">
    <div class="indent">
        <form action="/personbank/HttpProxy" method=post name="form1">
            <input type="hidden" name="URL" value="/midserv/Gds_Qry_9901.jsp"/>
            <input type="hidden" name="dse_sessionId" value="<%=dse_sessionId%>"/>

            <table width="90%" align="center" cellpadding="1" cellspacing="1" class="tab">
                <tr align="center" class="tab_title"> 
                    <td>电子渠道“缴费一站通”客户签约协议</td>
                </tr>
                <tr align="center" class="tab_sub_title"> 
                    <td>缴费通业务委托约定</td>
                </tr>
                <tr class="tab_tr">
                    <td align="left">
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;本人现委托交通银行广东省分行，依照委托扣划的收费单位付款信息，扣划委托银行卡卡号内的相应款项，代理委托人缴纳相应款项。</p>
<p>1．委托人必须是指定委托银行卡持卡人，指定银行卡可以支付委托人本人和他人的已选项目的相关费用。</p>
<p>2．委托人在各渠道办理的业务委托非实时生效，请在扣款前确认签约是否已生效，否则因未及时扣款造成的欠费由委托人自负。各委托项目的自动代缴费业务功能自首次扣款成功之日起开通。因委托人在有关收费单位办理信息变更，造成无法代理缴费，由委托人自负。</p>
<p>3．委托缴费银行卡因存款余额不足或因发生挂失、冻结、结清造成无法代缴费而产生的后果，由委托人自负。</p>
<p>4．委托人不再继续履行委托项目，应及时办理撤销委托手续。否则银行将继续依据本委托书之具体内容办理代缴费手续，由此而造成的损失由委托人自负。</p>
<p>5．委托人需终止委托或因银行卡发生挂失、冻结和结清的，须及时办理撤销委托手续，具体的撤销委托手续，依据银行业务的规定办理。</p>
<p>6．委托人授权银行按照指定收费单位发送的数据从委托银行卡中扣划相应款项，银行不对指定收费单位发送的数据进行审核，对因此造成的扣划错误及延迟支付不承担任何责任。委托人对代缴的款项金额有疑问时，须向有关单位查询。委托人与银行之间委托关系仅为代理转账，相关收费单位与委托人之间的各项服务关系及由此引发的纠纷与银行无关。</p>
<p>7．鉴于代理缴费业务开展的前提为收费单位与银行存在合作关系，因此一旦有关合作关系终止，相关的代缴费服务自动终止，银行不承担任何责任。银行根据合作协议提供打印缴费发票的，发票信息自缴费之日起保留六个月。</p>
<p>8．委托缴费银行卡在同一时间发生委托支付多项费用时，委托人授权银行决定支付顺序，由此造成款项不足的滞纳金与银行无关。</p>
<p>9．本委托业务对委托人暂不收费，银行保留收取相关服务费用的权利。</p>
<p>10．委托人通过交通银行电子渠道（含个人网银、手机银行、自助通等）进行缴费委托签约交易时，银行系统将会根据收费单位业务实现需要，将相关信息发送至对应的收费单位，包括：缴费银行卡号、持卡人姓名、充值或缴费金额、手机号码、身份证号、用户编号、缴费地址、订单号等。</p>
<p>11．上述规定解释权归交通银行广东省分行。</p>

                    </td>
                </tr>
                <tr class="tab_tr">
                    <td align="left"><p>本人已阅读并同意遵守《缴费通业务委托约定》条款。</p></td>
                </tr>
                <tr class="tab_result">
                    <td align="center">
			            <input type="submit"  class="button_bg"  value="同意" style={cursor:hand;}/>
			            <input type="button" class="button_bg" name="Submit3" value="返回" onclick="javascript:history.back()" />      
                     </td>      
               </tr>
           </table>


        </form> 
    </div>
    </body>
</html>