// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3)
// Source File Name:   Client.java

package facture;

import bean.*;
import java.sql.Connection;

public class Client extends ClassMAPTable
{

    public Client(String i, String no, String reg, String adr, String tel, String fa, String sta,
            String ni, String r, String tp, String quit) {
        
        super.setNomTable("client");
        setIdClient(i);
        setNom(no);
        setNif(ni);
        setAdresse(adr);
        setTelephone(tel);
        setFax(fa);
        setIdRegime(reg);
        setRc(r);
        setQuittance(quit);
        setNumstat(sta);
        setTp(tp);
    }
    
    public Client(String no, String reg, String tel, String fa, String adr, String sta, String ni,
            String r, String tp, String quit)
    {
        super.setNomTable("client");
        if(no.compareTo("") == 0 || no == null)
            setNom("-");
        else
            setNom(no);
        if(ni.compareTo("") == 0 || ni == null)
            setNif("-");
        else
            setNif(ni);
        if(adr.compareTo("") == 0 || adr == null)
            setAdresse("-");
        else
            setAdresse(adr);
        if(tel.compareTo("") == 0 || tel == null)
            setTelephone("-");
        else
            setTelephone(tel);
        if(fa.compareTo("") == 0 || fa == null)
            setFax("-");
        else
            setFax(fa);
        if(reg.compareTo("") == 0 || reg == null)
            setIdRegime("-");
        else
            setIdRegime(reg);
        if(r.compareTo("") == 0 || r == null)
            setRc("-");
        else
            setRc(r);
        if(quit.compareTo("") == 0 || quit == null)
            setQuittance("-");
        else
            setQuittance(quit);
        if(sta.compareTo("") == 0 || sta == null)
            setNumstat("-");
        else
            setNumstat(sta);
        if(tp.compareTo("") == 0 || tp == null)
            setTp("-");
        else
            setTp(tp);
        setIndicePk("clt");
        setNomProcedureSequence("getSeqClient");
        setIdClient(makePK());
    }
    
    public Client(String i, String no, String reg, String adr, String tel, String fa, String sta,
            String ni, String r, String tp, String quit, String type_contact, String soustype_contact)
    {
        super.setNomTable("client");
        setIdClient(i);
        setNom(no);
        setNif(ni);
        setAdresse(adr);
        setTelephone(tel);
        setFax(fa);
        setIdRegime(reg);
        setRc(r);
        setQuittance(quit);
        setNumstat(sta);
        setTp(tp);
        setType_contact(type_contact);
        setSoustype_contact(soustype_contact);
    }

    public Client(String no, String reg, String tel, String fa, String adr, String sta, String ni,
            String r, String tp, String quit, String type_contact, String soustype_contact)
    {
        super.setNomTable("client");
        if(no.compareTo("") == 0 || no == null)
            setNom("-");
        else
            setNom(no);
        if(ni.compareTo("") == 0 || ni == null)
            setNif("-");
        else
            setNif(ni);
        if(adr.compareTo("") == 0 || adr == null)
            setAdresse("-");
        else
            setAdresse(adr);
        if(tel.compareTo("") == 0 || tel == null)
            setTelephone("-");
        else
            setTelephone(tel);
        if(fa.compareTo("") == 0 || fa == null)
            setFax("-");
        else
            setFax(fa);
        if(reg.compareTo("") == 0 || reg == null)
            setIdRegime("-");
        else
            setIdRegime(reg);
        if(r.compareTo("") == 0 || r == null)
            setRc("-");
        else
            setRc(r);
        if(quit.compareTo("") == 0 || quit == null)
            setQuittance("-");
        else
            setQuittance(quit);
        if(sta.compareTo("") == 0 || sta == null)
            setNumstat("-");
        else
            setNumstat(sta);
        if(tp.compareTo("") == 0 || tp == null)
            setTp("-");
        else
            setTp(tp);
        if(type_contact.compareTo("") == 0 || type_contact == null)
            setType_contact("-");
        else
            setType_contact(type_contact);
        if(soustype_contact.compareTo("") == 0 || soustype_contact == null)
            setSoustype_contact("-");
        else 
            setSoustype_contact(soustype_contact);
        setIndicePk("clt");
        setNomProcedureSequence("getSeqClient");
        setIdClient(makePK());
    }
    public Client()
    {
      super.setNomTable("Client");
    }
    public String getTuppleID()
    {
        return String.valueOf(getIdClient());
    }

    public String getAttributIDName()
    {
        return "idClient";
    }

    public String getNom()
    {
        return nom;
    }

    public void setNom(String nom)
    {
        if(nom == null)
            this.nom = "";
        else
            this.nom = nom;
    }

    public void setNif(String nif)
    {
        this.nif = nif;
    }

    public String getNif()
    {
        return nif;
    }

    public void setAdresse(String adresse)
    {
        if(adresse == null)
            this.adresse = "";
        else
            this.adresse = adresse;
    }

    public String getAdresse()
    {
        return adresse;
    }

    public void setTelephone(String telephone)
    {
        if(telephone == null)
            this.telephone = "";
        else
            this.telephone = telephone;
    }

    public String getTelephone()
    {
        return telephone;
    }

    public void setFax(String fax)
    {
        if(fax == null)
            this.fax = "";
        else
            this.fax = fax;
    }

    public String getFax()
    {
        return fax;
    }

    public void setIdClient(String idClient)
    {
        this.idClient = idClient;
    }

    public String getIdClient()
    {
        return idClient;
    }

    public void setRc(String rc)
    {
        if(rc == null)
            this.rc = "";
        else
            this.rc = rc;
    }

    public String getRc()
    {
        return rc;
    }

    public void setTp(String tp)
    {
        if(tp == null)
            this.tp = "";
        else
            this.tp = tp;
    }

    public String getTp()
    {
        return tp;
    }

    public void setQuittance(String quittance)
    {
        if(quittance == null)
            this.quittance = "";
        else
            this.quittance = quittance;
    }

    public String getQuittance()
    {
        return quittance;
    }

    public void setIdRegime(String idRegime)
    {
        if(idRegime == null)
            this.idRegime = "-";
        else
            this.idRegime = idRegime;
    }

    public String getIdRegime()
    {
        return idRegime;
    }
    public static String getIdDyn(String idClient)throws Exception
    {
      Connection c=null;
      try {
        c=new utilitaire.UtilDB().GetConn();
        return getIdDyn(idClient,c);
      }
      catch (Exception ex) {
        throw ex;
      }
      finally
      {
        if(c!=null)c.close();
      }
    }
    public static String getIdDyn(String idClient,Connection c) throws Exception
    {
      char[] idc = idClient.toCharArray();
      Client crtc=new Client();
      Client[]lc;
      if(idc.length==9&&idc[0]=='c'&&idc[1]=='l'&&idc[2]=='t')
      {
        crtc.setIdClient(idClient);
        lc=(Client[])CGenUtil.rechercher(crtc,null,null,c,"");
        if(lc.length>0) return (idClient);
        else
        {
          //crtc.setIdClient("");
          //crtc.setNom(idClient);
          crtc.setNumstat(idClient);
          lc=(Client[])CGenUtil.rechercher(crtc,null,null,c,"");
          if(lc.length==0)throw new Exception("Pas de client");
          return (lc[0].getIdClient());
        }
      }
      else
      {
        //crtc.setNom(idClient);
        crtc.setNumstat(idClient);
        lc=(Client[])CGenUtil.rechercher(crtc,null,null,c,"");
        if(lc.length==0)throw new Exception("Pas de client");
        return(lc[0].getIdClient());
      }
    }
    public void setNumstat(String numstat)
    {
        if(numstat == null)
            this.numstat = "-";
        else
            this.numstat = numstat;
    }

    public String getNumstat()
    {
        return numstat;
    }

    public String getType_contact() {
        return type_contact;
    }

    public void setType_contact(String type_contact) {
        this.type_contact = type_contact;
    }

    public String getSoustype_contact() {
        return soustype_contact;
    }

    public void setSoustype_contact(String soustype_contact) {
        this.soustype_contact = soustype_contact;
    }

    public TypeObjet getInfoComptable()
    {
        TypeObjetUtil tu = new TypeObjetUtil();
        tu.setNomTable("compte");
        return (TypeObjet)tu.rechercher(3, getTuppleID())[0];
    }

    public String nom;
    public String nif;
    public String adresse;
    public String telephone;
    public String fax;
    public String rc;
    public String tp;
    public String quittance;
    public String idRegime;
    public String idClient;
    public String numstat;
    public String type_contact;
    public String soustype_contact;
}
