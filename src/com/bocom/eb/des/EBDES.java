// Decompiled by Jad v1.5.7g. Copyright 2000 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/SiliconValley/Bridge/8617/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi 
// Source File Name:   EBDES.java

package com.bocom.eb.des;

import java.io.PrintStream;
import lava.security.KeyGenerator;
import lava.security.des.DesEngine;
import lava.security.des.DesKey;
import sun.misc.*;

public class EBDES
{

    public EBDES()
    {
    }

    public static String decryptoDES(String s, String s1)
        throws Exception
    {
        byte abyte0[] = s1.getBytes();
        int i = abyte0.length;
        byte abyte1[] = new byte[8];
        int j = abyte1.length;
        KeyGenerator.compressBits(abyte0, i, abyte1, j);
        DesKey deskey = new DesKey(abyte1, 0);
        DesEngine desengine = new DesEngine(deskey);
        byte abyte2[] = (new BASE64Decoder()).decodeBuffer(s);
        int k = abyte2.length;
        int l = ((abyte2.length - 1) / 8 + 1) * 8;
        byte abyte3[] = new byte[l];
        byte abyte4[] = new byte[l];
        byte abyte5[] = new byte[l];
        for(int i1 = 0; i1 < k; i1++)
            abyte4[i1] = abyte2[i1];

        desengine.decrypt(abyte4, abyte3, l);
        return (new String(abyte3)).trim();
    }

    public static String encryptoDES(String s, String s1)
        throws Exception
    {
        byte abyte0[] = s1.getBytes();
        int i = abyte0.length;
        byte abyte1[] = new byte[8];
        int j = abyte1.length;
        KeyGenerator.compressBits(abyte0, i, abyte1, j);
        DesKey deskey = new DesKey(abyte1, 0);
        DesEngine desengine = new DesEngine(deskey);
        byte abyte2[] = s.getBytes();
        int k = abyte2.length;
        int l = ((abyte2.length - 1) / 8 + 1) * 8;
        byte abyte3[] = new byte[l];
        byte abyte4[] = new byte[l];
        byte abyte5[] = new byte[l];
        for(int i1 = 0; i1 < k; i1++)
            abyte4[i1] = abyte2[i1];

        desengine.encrypt(abyte4, abyte3, l);
        return (new BASE64Encoder()).encode(abyte3);
    }

    public static void main(String args[])
    {
        String s = "222222";
        String s1 = "IEIMIYBZDKEPEZEOIADFESIMETIFEUJKIHGTCHBD";
        try
        {
            String s2 = encryptoDES(s, s1);
            System.out.println(s2);
            String s3 = decryptoDES(s2, s1);
            System.out.println(s3);
        }
        catch(Exception exception)
        {
            System.out.println(exception);
        }
    }
}
