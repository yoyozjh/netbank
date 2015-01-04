package com.bocom.midserv.base;

import java.io.*;
import java.net.*;

public class MidNetworkTools {

    private String buf_in = null;
    private String buf_out = null;

    public String get_buf_in() {
    //System.out.println("debug buf_in="+buf_in);    
        return buf_in;
    }
    public String get_buf_out() {
        return buf_out;
    }
    public void set_buf_in(String s_buf_in) {
        buf_in = s_buf_in;
    }
    public void set_buf_out(String s_buf_out) {
        buf_out = s_buf_out;
    }
public String tcpConnect(String host_ip, int host_port) throws IOException {
    Socket soc = null;
    BufferedReader in = null; /*receive*/
    //*BufferedWriter   out=null; 
    PrintWriter out = null; /*send*/

    int ret = 0;
    try {
        soc = new Socket(host_ip, host_port);
        if (soc != null) {
            System.out.println("create socket OK");
        }
        System.out.println("buf_in=["+buf_in+"]"); 
        in = new BufferedReader(new InputStreamReader(soc.getInputStream()));
        out =
            new PrintWriter(
                new BufferedWriter(new OutputStreamWriter(soc.getOutputStream())),
                true);
        out.println(buf_in);
        buf_out = in.readLine();
        System.out.println("buf_out=[" + buf_out + "]");

    } catch (Exception e) {
        ret = -1;
        System.out.println("e.getmessage" + e.getMessage());
        System.out.println("e.tostring" + e.toString());
        System.out.println("e.printStack:");
        e.printStackTrace();
    } finally {
        in.close();
        out.close();
        soc.close();

    }
    return buf_out;
}
}
