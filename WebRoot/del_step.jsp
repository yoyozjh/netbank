
<!-------------------------------------------------------------------
                          标准页面服务对象引用
--------------------------------------------------------------------->
<%@ page contentType="text/html;charset=gb2312" %>


<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.bocom.midserv.base.*" %>
<%@ page import="com.bocom.midserv.web.*" %>
<%@ page import="java.lang.*"%>

<%//获得参数，删除数据
    String biz_id=request.getParameter("biz_id").trim();
    int i_biz_id=Integer.parseInt(biz_id);
    String step_id=request.getParameter("step_id").trim();
    int i_step_id=Integer.parseInt(step_id);
    
    String sql="delete from TRANS_VIEW_DEF where biz_id="+i_biz_id+" and biz_step_id="+i_step_id+"";
    MidObjectView midObjectView =  new MidObjectView();
    
    midObjectView.insertData(sql);
    MidObjectStepView midObjectStepView =  new MidObjectStepView();
    int maxstep=midObjectStepView.getMaxStepId(i_biz_id);
    String sql2="";
    int i,j;
    int k=maxstep;
    i=i_step_id+1;
    while(i<maxstep+1){
        j=i-1;
        sql2="update TRANS_VIEW_DEF set biz_step_id="+j+" where biz_step_id="+i+" and biz_id="+i_biz_id+"";
        midObjectView.insertData(sql2);
        i++;
    }
%>
   <script language="javascript">
	alert("删除成功！");
	location.replace("admin.jsp");
   </script>

<!--------------------------------------------------------------------
                          页面HTML表现部分    
---------------------------------------------------------------------->
