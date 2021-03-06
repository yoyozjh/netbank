package com.viatt.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.HashMap;
import java.util.List;

import com.viatt.bean.BwResult;

/**
 * @time 20090213
 * @author Linghc
 *
 */
public class MidServer {
	private String ip="182.53.15.211";
	private int port=3555;
	
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}


	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public BwResult sendMessage(String content){
		BwResult result=new BwResult();
		try {
			BufferedReader in = null; /* receive */
			// *BufferedWriter out=null;
			PrintWriter out = null; /* send */
			Socket soc = new Socket(ip, port);
			in = new BufferedReader(new InputStreamReader(soc.getInputStream()));
			out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(soc
					.getOutputStream())), true);
			String head="|bocom_mid|";
			int length=MessManTool.getMessLength(head+content);
			if(length<=0){
				return new BwResult("001","报文为空！");
			}
			String lengthStr=String.valueOf(length);
			if(lengthStr.length()>4){
				return new BwResult("001","报文长度太大！");
			}else if(lengthStr.length()==3){
				lengthStr="0"+lengthStr;
			}else if(lengthStr.length()==2){
				lengthStr="00"+lengthStr;
			}else if(lengthStr.length()==1){
				lengthStr="000"+lengthStr;
			}
			head=lengthStr+head;
			String message=head+content;
			out.println(message);
			String tmp=in.readLine();
			//System.out.println("===返回的直接报文是："+tmp);
			if(tmp==null||tmp.equals("")){
				return new BwResult("001","返回结果为空");
			}
			String MGID = MessManTool.getValueByName(tmp, "MGID");
			if(MGID==null||MGID.equals("")||!MGID.equals("000000")){
				String PB_Return_Code_Msg = MessManTool.getValueByName(tmp, "PB_Return_Code_Msg");
				return new BwResult("001",PB_Return_Code_Msg);
			}
			result.setContext(tmp);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	
	
	public static void main(String arg[]){
		String content = "bocom_mid|biz_id,25|i_biz_step_id,1|CDNO,60142890710180319|";
		MidServer midServer=new MidServer();
		BwResult bwResult = midServer.sendMessage(content);
		MessManTool messManTool = new MessManTool();
		System.out.println("==="+bwResult.getContext());
		List list = messManTool.kongZhongChongZhi1(bwResult.getContext());
		for(int i=0;i<list.size();i++){
			System.out.println("==="+((HashMap)list.get(i)).get("param32"));
		}
	}
}
