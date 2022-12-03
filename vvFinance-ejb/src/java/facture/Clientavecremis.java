// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   Client.java

package facture;

import bean.*;
import java.sql.Connection;
import java.sql.Date;
public class Clientavecremis extends ClassMAPTable
{
  private String id;
  private  String idClient;
  private String client;
  private Date datedebut;
  private int etat;
    public Clientavecremis()
    {
      super.setNomTable("Clientavecremise");
      setNomProcedureSequence("getSeqClientAvecRemise");
    }
    public String getTuppleID()
    {
        return id;
    }

    public String getAttributIDName()
    {
        return "id";
    }

    public void setIdClient(String idClient)
    {
        this.idClient = idClient;
    }

    public String getIdClient()
    {
        return idClient;
    }
  public Date getDatedebut() {
    return datedebut;
  }
  public int getEtat() {
    return etat;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setEtat(int etat) {
    this.etat = etat;
  }
  public void setDatedebut(Date datedebut) {
    this.datedebut = datedebut;
  }
  public String getClient() {
    return client;
  }
  public void setClient(String client) {
    this.client = client;
  }
}
