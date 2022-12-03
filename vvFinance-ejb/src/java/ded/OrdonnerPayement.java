package ded;

import bean.*;
import java.sql.Connection;
import utilitaire.UtilDB;
import finance.MvtCaisse;
import finance.MvtCaisseUtil;
import facturefournisseur.FactureFournisseurLc;
import utilitaire.Utilitaire;
import lc.LigneCredit;
import utilitaire.Utilitaire;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class OrdonnerPayement extends ClassMAPTable {

  private String id;
  private String ded_Id;
  private String idLigne;
  private java.sql.Date daty;
  private double montant;
  private String remarque;
  private int etat;
  public OrdonnerPayement() {
    this.setNomTable("OrdonnerPayement");
  }
  public OrdonnerPayement(String id,String ded,String ligne,String dt,String mont,String rem,String eta) {
    this.setId(id);
    this.setDed_Id(ded);
    this.setIdLigne(ligne);
    this.setDaty((utilitaire.Utilitaire.string_date("dd/MM/yyyy",dt)));
    this.setMontant(utilitaire.Utilitaire.stringToDouble(mont));
    this.setRemarque(rem);
    this.setEtat(utilitaire.Utilitaire.stringToInt(eta));
  }
  public OrdonnerPayement(String id,String ded,java.sql.Date dt,double mont,String rem) {
    this.setId(id);
    this.setDed_Id(ded);
    this.setDaty(dt);
    this.setMontant(mont);
    this.setRemarque(rem);
  }
  public OrdonnerPayement(String ded,String ligne,String dt,String mont,String rem,String eta)throws Exception {
    this.setNomTable("OrdonnerPayement");
    this.preparePk("ORP","getSeqOp");
    this.setId(makePK());
    this.setDed_Id(ded);
    this.setIdLigne(ligne);
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dt));
    this.setMontant(utilitaire.Utilitaire.stringToDouble(mont));
    this.setRemarque(rem);
    this.setEtat(utilitaire.Utilitaire.stringToInt(eta));
  }
  public OrdonnerPayement(Connection c, String dt,String mont,String rem,String eta)throws Exception {
    this.setNomTable("OrdonnerPayement");
    this.preparePk("ORP","getSeqOp");
    this.setId(makePK(c));
    this.setDed_Id("");
    this.setIdLigne("");
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dt));
    this.setMontant(utilitaire.Utilitaire.stringToDouble(mont));
    this.setRemarque(rem);
    this.setEtat(utilitaire.Utilitaire.stringToInt(eta));
  }
  public void OrdonnerRecette(String ligne,String dt,String mont,String rem, String eta)throws Exception{
    this.setNomTable("OrdreRecette");
    this.preparePk("ORR","getSeqOr");
    this.setId(makePK());
    this.setIdLigne(ligne);
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dt));
    this.setMontant(utilitaire.Utilitaire.stringToDouble(mont));
    this.setRemarque(rem);
    this.setEtat(utilitaire.Utilitaire.stringToInt(eta));
  }
  public void OrdonnerRecette(String ded,String ligne,String dt,String mont,String rem, String eta)throws Exception{
    this.setNomTable("ORDONNERRECETTE");
    this.preparePk("ORR","getSeqOr");
    this.setDed_Id(ded);
    this.setId(makePK());
    this.setIdLigne(ligne);
    this.setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",dt));
    this.setMontant(utilitaire.Utilitaire.stringToDouble(mont));
    this.setRemarque(rem);
    this.setEtat(utilitaire.Utilitaire.stringToInt(eta));
  }
  public Visa getVisa(Connection c) throws Exception
  {
    VisaUtil vu=new VisaUtil();
    vu.setNomTable(utilitaire.Constante.tableVisaOp);
    Visa[]v=(Visa[])vu.rechercher(4,this.getTuppleID(),c);
    if (v.length==0)return null;
    return v[0];
  }
  public Visa getVisaOr(Connection c) throws Exception
  {
    return getVisa("visaOr",c);
  }
  public Visa getVisa(String nomTable,Connection c) throws Exception
 {
   VisaUtil vu=new VisaUtil();
   vu.setNomTable(nomTable);
   Visa[]v=(Visa[])vu.rechercher(4,this.getTuppleID(),c);
   if (v.length==0)return null;
   return v[0];
  }
  public boolean estVisable(Connection c) throws Exception
  {
    OpUtil op=new OpUtil();
    op.setNomTable("opAviserLc");
    OrdonnerPayement[] o=(OrdonnerPayement[])op.rechercher(1,this.getTuppleID());
    if(o.length==0) return false;
    return true;
  }
  public boolean estVisable()throws Exception
  {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      return estVisable(c);
    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage()) ;
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public boolean orEstVisable(Connection c) throws Exception
  {
    OpUtil op=new OpUtil();
    op.setNomTable("orAviserLc");
    OrdonnerPayement[] o=(OrdonnerPayement[])op.rechercher(1,this.getTuppleID(), c);
    if(o.length==0) return false;
    return true;
  }
  public boolean orEstVisable()throws Exception
  {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      return orEstVisable(c);
    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage()) ;
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public Visa getVisaFacture(Connection c) throws Exception
  {
    VisaUtil vu=new VisaUtil();
    vu.setNomTable("VISAFACTUREF");
    Visa[] ret=(Visa[])vu.rechercher(4,this.getDed_Id(),c);
    if(ret.length==0)return null;
    return ret[0];
  }
  public Visa getVisaFacture() throws Exception
  {
    Connection c=null;
        try {
          c=new UtilDB().GetConn();
          return getVisaFacture(c);
        }
        catch (Exception ex) {
          ex.printStackTrace();
          throw new Exception(ex.getMessage()) ;
        }
        finally{
          if(c!=null)c.close();
        }
  }
  public Visa getVisa()throws Exception
  {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      return getVisa(c);
    }
    catch (Exception ex) {
      ex.printStackTrace();
      throw new Exception(ex.getMessage()) ;
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public Visa getVisaOr()throws Exception
  {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      return getVisaOr(c);
    }
    catch (Exception ex) {
      ex.printStackTrace();
      throw new Exception(ex.getMessage()) ;
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public String[] construireIDLC(String nomTable, String mois,String annee,String idlc,Connection c)throws Exception{
    String[] ret = null;


    try{
      LigneCredit lc = new LigneCredit();
        lc.setNomTable(nomTable);
        //lc.setNomTable("LigneCredit");
        //System.out.println("Ligne credit : "+idlc);
        LigneCredit[] lcn = (LigneCredit[])CGenUtil.rechercher(lc,null,null,c," and upper(idligne) in ("+idlc+")");
        ret = new String[lcn.length];

        if(annee.length()==2){
          if (Integer.valueOf(annee).intValue()<70) annee = "20"+annee;
          else annee = "19"+annee;
        }
        int ans = Utilitaire.stringToInt(annee);
        for (int i = 0; i < lcn.length; i++){
            if(ans!=lcn[i].getAnnee()){
                LigneCredit lct = new LigneCredit();
	        lct.setNomTable(nomTable);
		lct.setIdTypeLigne(lcn[i].getIdTypeLigne());
		lct.setIdEntite(lcn[i].getIdEntite());
		lct.setIdDirection(lcn[i].getIdDirection());                       
		LigneCredit[] listes = (LigneCredit[])CGenUtil.rechercher(lct,null,null,c," and annee = " +annee+" and mois ="+mois);
                
		if (listes.length == 0) 
                    throw new Exception("Ligne de credit non existant pour le mois de "+ Utilitaire.nbToMois(Integer.valueOf(mois)));
		LigneCredit lcr = listes[0];
                ret[i] = lcr.getIdLigne();
            }else{
                ret[i] = lcn[i].getIdLigne();
            }     
	    
        }
    }catch(Exception ex){
      throw ex;
    }
    return ret;
  }
  public UnionIntraTable[] recupererIdLcAttachement(String nomTable1, String nomTable2, String numObjet,Connection c)throws Exception{

    UnionIntraTable cri = new UnionIntraTable();

    cri.setNomTable(nomTable1);
    // cri.setNomTable("FactureFournisseurLc");

    UnionIntraTable[] dem = null;
    try{
      OrdonnerPayement cr = new OrdonnerPayement();
      cr.setNomTable(nomTable2);
      // cr.setNomTable("OrdonnerPayement");
      cr.setId(numObjet);
      OrdonnerPayement op = ((OrdonnerPayement[])CGenUtil.rechercher(cr,null,null,c,""))[0];
      cri.setId1(op.getDed_Id());
      dem = (UnionIntraTable[])CGenUtil.rechercher(cri,null,null,c,"");
    }catch(Exception ex){
      ex.printStackTrace();
    }

    return dem;
  }
  public static void suprimerOp(String id) throws Exception
  {
    Connection c=null;
    try
    {
      MvtCaisse crt=new MvtCaisse();
      crt.setIdOrdre(id);
      c=new UtilDB().GetConn();
      MvtCaisse[]liste=(MvtCaisse[])(CGenUtil.rechercher(crt,null,null,c,"") );
      if(liste.length!=0)
      {
        for(int i=0;i<liste.length;i++)
        {
          liste[i].deleteToTable(c);
        }
      }

    }
    catch (Exception ex)
    {
      ex.printStackTrace();
      throw new Exception(ex.getMessage()) ;
    }
    finally
    {
      if(c!=null)c.close();
    }


  }
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getId() {
    return id;
  }
  public void setDed_Id(String ded_Id) {
    this.ded_Id = ded_Id;
  }
  public String getDed_Id() {
    return ded_Id;
  }
  public void setIdLigne(String idLigne) {
    this.idLigne = idLigne;
  }
  public String getIdLigne() {
    return idLigne;
  }
  public void setDaty(java.sql.Date daty) {
    this.daty = daty;
  }
  public java.sql.Date getDaty() {
    return daty;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public double getMontant() {
    return montant;
  }
  public void setRemarque(String remarque) {
    this.remarque = remarque;
  }
  public String getRemarque() {
    return remarque;
  }
  public void setEtat(int etat) {
    this.etat = etat;
  }
  public int getEtat() {
    return etat;
  }
  public MvtCaisse getPayement()throws Exception
  {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      return getPayement(c);
    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage()) ;
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public MvtCaisse getPayement(Connection c)throws Exception
  {
    MvtCaisseUtil mcu=new MvtCaisseUtil();
    mcu.setNomTable("mvtCaisseValide");
    MvtCaisse []m=(MvtCaisse [])mcu.rechercher(15,this.getTuppleID(),c);

    if(m.length==0)return null;
    return m[0];
  }
  public boolean estAnnulable() throws Exception
  {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      return estAnnulable(c);
    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage()) ;
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public boolean estAnnulable(Connection c) throws Exception
  {
      MvtCaisse pay=getPayement(c);
      Visa v=getVisa(c);
      if(pay==null&&v!=null)
        return true;
      return false;
  }
  public boolean estAnnulableOr() throws Exception
  {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      return estAnnulableOr(c);
    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage()) ;
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public boolean estAnnulableOr(Connection c) throws Exception
  {
      MvtCaisse pay=getPayement(c);
      Visa v=getVisaOr(c);
      if(pay==null&&v!=null)
        return true;
      return false;
  }
  public String getEtatLettre()
  {
    if (getEtat()==1)
      return "vise";
    if(getEtat()==0)
      return "non vise";
    return "";
  }
}