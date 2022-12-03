// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   localdemo.java

package facture;

import java.io.PrintStream;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.TimeZone;

public class localdemo
{

    public localdemo()
    {
    }

    public static void main(String args[])
    {
        try
        {
            String daty = "14/05/2005";
            SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
            formatter.setTimeZone(TimeZone.getTimeZone("Europe/Paris"));
            Date hiredate = new Date(formatter.parse(daty).getTime());
            System.out.println(String.valueOf(hiredate));
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }
}
