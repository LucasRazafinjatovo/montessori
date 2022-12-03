// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   modifTypeEntree.java

package finance;


public class modifTypeEntree
{

    public modifTypeEntree()
    {
        sample = "Start value";
    }

    public String getSample()
    {
        return sample;
    }

    public void setSample(String newValue)
    {
        if(newValue != null)
            sample = newValue;
    }

    private String sample;
}
