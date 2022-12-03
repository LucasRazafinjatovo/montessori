// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   Champ.java

package bean;

import java.lang.reflect.Field;


public class Champ
{
  public Champ(Field f)
  {
    nomClasse=f;
    nomColonne=f.getName();
    this.typeJava=f.getType().getName();
    size=10;
    this.javaToSql();
  }
  public Champ(Field f,int precision)
    {
      nomClasse=f;
      nomColonne=f.getName();
      this.typeJava=f.getType().getName();
      size=10;
      this.setPrecision(precision);
      this.javaToSql();
  }
  public Field getField()
  {
    Field e;
    return null;
  }
    public Champ(String nomCol, String typ, int val)
    {
        nomColonne = nomCol;
        type = typ;
        size = val;
        sqlToJava();
    }
    public Champ(String nomCol, String typ, int val,int precis)
    {
        nomColonne = nomCol;
        type = typ;
        size = val;
        this.setPrecision(precis);
        sqlToJava();
    }
    public Champ(String nomCol, String typ)
    {
        nomColonne = nomCol;
        type = typ;
    }

    public String getNomColonne()
    {
        return nomColonne;
    }

    public String getTypeColonne()
    {
        return type;
    }
    public String getTypeJava()
    {
        return typeJava;
    }

    public int getSize()
    {
        return size;
    }

    public void sqlToJava()
    {
        if(type.compareToIgnoreCase("Varchar2") == 0 || type.compareToIgnoreCase("char") == 0)
            typeJava = "java.lang.String";
        if((type.compareToIgnoreCase("Number") == 0)&&(precision==0)&&(size<10))
            typeJava = "int";
        if((type.compareToIgnoreCase("Number") == 0)&&((precision>0)||(size>=10)))
            typeJava = "double";
        if((type.compareToIgnoreCase("Long") == 0)||(type.compareToIgnoreCase("float") == 0))
            typeJava = "double";
        if(type.compareToIgnoreCase("Date") == 0)
            typeJava = "java.sql.Date";
    }

    public void javaToSql()
    {
        if(typeJava.compareToIgnoreCase("java.lang.String") == 0 || typeJava.compareToIgnoreCase("char") == 0)
            type = "Varchar2";
        if(typeJava.compareToIgnoreCase("int") == 0 || typeJava.compareToIgnoreCase("float") == 0 || typeJava.compareToIgnoreCase("Double") == 0)
            type = "Number";
        if(typeJava.compareToIgnoreCase("java.sql.Date") == 0)
            type = "Date";
    }
  public int getPrecision() {
    return precision;
  }
  public void setPrecision(int precision) {
    this.precision = precision;
  }
  public Field getNomClasse() {
    return nomClasse;
  }
  public void setNomClasse(Field nomClasse) {
    this.nomClasse = nomClasse;
  }
  public String toString()
  {
    return getNomColonne();
  }
  public String getType() {
    return type;
  }
  public void setType(String type) {
    this.type = type;
  }

    String nomColonne;
    String type;
    String typeJava;
    int size;
    int precision;
    Field nomClasse;
}
