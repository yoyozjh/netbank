package com.bocom.midserv.gz;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.gdbocom.util.Constants;

public class GzLog
{
    private FileWriter fw;
    private String LogDirect = new String("");
    
    public GzLog(String Direct)
    {
    	LogDirect = Direct;
    }
    
    public GzLog()
    {
    	LogDirect =Constants.Log.SAVE_ADDRESS;
    }
    

    public void Write(String strLog)
    {
    	Date current = new Date();
        SimpleDateFormat sdf_date = new SimpleDateFormat("yyyy-MM-dd"); 
        SimpleDateFormat sdf_time = new SimpleDateFormat("HH:mm:ss"); 
        String current_date = sdf_date.format(current);
        String current_time = sdf_time.format(current);
        try
        {
	    if(!(new File(LogDirect).isDirectory()))
            	new File(LogDirect).mkdir();
            fw = new FileWriter(LogDirect+"/"+current_date+".log",true);
            fw.write(current_time+"	"+strLog+"\n");
            fw.close();
	}
       	catch(IOException e)
      	{
             //setErrorMessage("Error writting the file: "+e.getMessage());
             return;
      	}
    }
}