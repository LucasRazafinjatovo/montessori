package ded;

import javax.ejb.*;
import bean.*;
import facture.*;
import prevision.*;
import historique.HistoriqueEtat;
import historique.MapHistorique;
import java.io.PrintStream;
import java.sql.*;

import lc.*;
import utilitaire.Constante;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import facturefournisseur.FactureFournisseur;
import facturefournisseur.Detail;
import finance.FinanceEjb;
import finance.MvtCaisse;
import utilitaire.ConstanteRecette;
import facturefournisseur.FactureFournisseurUtil;
import facturefournisseur.GestionFactureFournisseur;
import facturefournisseur.GestionFactureFournisseurClient;
import finance.FinanceEjbClient;
import java.rmi.RemoteException;
import utilitaire.UtilitaireMetier;

@Stateful
@AccessTimeout(0)
public class DedEjbBean implements DedEjb, DedEjbRemote, SessionBean {
  SessionContext sessionContext;
  public void ejbCreate() throws CreateException {
    /**@todo Complete this method*/
  }
  public void ejbRemove() {
    /**@todo Complete this method*/
  }
  public void ejbActivate() {
    /**@todo Complete this method*/
  }
  public void ejbPassivate() {
    /**@todo Complete this method*/
  }
  public void setSessionContext(SessionContext sessionContext) {
    this.sessionContext = sessionContext;
  }
  public String createDed(String desi, String daty, String mtht, String tax, String rem, String tiers, String idLigne, String refU) throws Exception {
   ded.Ded d=new Ded(desi,daty,mtht,tax,rem,"10",tiers,idLigne);
   LCEjb lci = LCEjbClient.getInterface();
   LigneCredit[] l=lci.findLC(idLigne,"%","%","%","%","%","%",Constante.getObjetLigneCredit());
   if(l.length>0){
     double montant = utilitaire.Utilitaire.stringToDouble(mtht)+utilitaire.Utilitaire.stringToDouble(tax);
       if(l[0].getDisponibleVis()>=montant)
         d.insertToTableWithHisto(refU);
       else throw new Exception("Demande superieur au credit disponible");
   }
   return d.getId();
 }
 public String createDed(String desi, String daty, String mtht, String tax, String rem, String tiers, String idLigne, String refU, Connection c) throws Exception {
  ded.Ded d=new Ded(desi,daty,mtht,tax,rem,"10",tiers,idLigne);
  LCEjb lci = LCEjbClient.getInterface();
  LigneCredit[] l=lci.findLC(idLigne,"%","%","%","%","%","%",Constante.getObjetLigneCredit());
  if(l.length>0){
    double montant = utilitaire.Utilitaire.stringToDouble(mtht)+utilitaire.Utilitaire.stringToDouble(tax);
      if(l[0].getDisponibleVis()>=montant)
        d.insertToTableWithHisto(refU,c);
      else throw new Exception("Demande superieur au credit disponible");
  }
  return d.getId();
 }

 public int reporterOp(String nomTable,String[] idOp, String[] rep, String refU) throws Exception{
      Connection c=null;
          try {
            c=new UtilDB().GetConn();
            c.setAutoCommit(false);
            int i=0;
            for(i=0;i<idOp.length;i++)
            {
              OrdonnerPayement crt=new OrdonnerPayement();
              crt.setNomTable(nomTable);
              crt.setId(idOp[i]);
              crt=((OrdonnerPayement)(bean.CGenUtil.rechercher(crt,null,null,c,"")[0]));
              crt.setDaty(Utilitaire.stringDate(rep[i]));
              crt.updateToTableWithHisto(refU,c);
            }
            c.commit();
            return i;
          }
          catch (Exception ex) {
            c.rollback();
            throw ex;
          }
          finally
          {
            if(c!=null)c.close();
          }
  }
 public String ventilerDed(String idDed, String[] idLcDet, String[] montant, String[] remarque, String[] eta, String refU) throws Exception {
   Connection c=null;
   try {
     int nbAventiler=idLcDet.length;
     Ded[] de=this.findDed(idDed,"%","","","","","%","%","%");
     if(de.length==0) throw new Exception("La demande n existe pas");
     double sommeListe=Utilitaire.calculSomme(montant);
     if(de[0].getMttc()!=sommeListe) throw new Exception("La somme nest pas balancee");
     if(Utilitaire.stringToInt(de[0].getEtat()) >=20) throw new Exception ("La demande est deja vise");
     c=new UtilDB().GetConn();
     c.setAutoCommit(false);
     UnionIntraTable[]liste=new UnionIntraTable[nbAventiler];
     for(int i=0;i<nbAventiler;i++)
     {
       liste[i]=new UnionIntraTable(ConstantesDed.getTableDedLcDet(),ConstantesDed.getFonctDedLcDet(),ConstantesDed.getSuffDedLcDet(),idDed,idLcDet[i],remarque[i],montant[i],eta[i]);
       liste[i].insertToTableWithHisto(refU,c);
     }
     c.commit();
     return "ok";
   }
   catch (Exception ex) {
     c.rollback();
     ex.printStackTrace();
     return null;
   }
   finally{
     if(c!=null) c.close();
   }
  }
  public Ded[] findDed(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne) throws Exception {
   int []a={1,2,6,8,9};
   String []val={id,desi,rem,tiers,idLigne};
   int[]aInt={3,4};
   String[]valInt={daty1,daty2,mont1,mont2};
   DedUtil du=new DedUtil();
   du.setNomTable("DedLettre");
   return (Ded[])du.rechercher(a,val,"",aInt,valInt);
 }
 public DedLc[] findDedLc(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2) throws Exception {
   int []a={1,2,6,8,9,16,17,18,19};
   String []val={id,desi,rem,tiers,idLigne,typeLc,compte,ent,dir};
   int[]aInt={3,4,20};
   String[]valInt={daty1,daty2,mont1,mont2,mois1,mois2};
   DedLcUtil du=new DedLcUtil();
   du.setNomTable("DedLc");
   return (DedLc[])du.rechercher(a,val,"",aInt,valInt);
 }
 public ResultatEtSomme findDedPage(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne, int numPage) throws Exception {
   Connection c = null;
   try {
     c = new UtilDB().GetConn();
     int []a={1,2,6,8,9};
      String []val={id,desi,rem,tiers,idLigne};
      int[]aInt={3,4};
      String[]valInt={daty1,daty2,mont1,mont2};
      DedUtil du=new DedUtil();
      du.setNomTable("DedLettre");
      Ded[] ret = (Ded[])du.rechercher(a,val,"",c,aInt,valInt,numPage);
      String nomColSom[]={"montantHt","taxe"};
      double[] sommeNombre=du.calculSommeNombre(a,val,"",c,aInt,valInt,nomColSom);
      return new ResultatEtSomme(ret,sommeNombre);
   }
   catch (Exception ex) {
     return null;
   }
   finally{
     if(c!=null)c.close();
   }
 }
 public ResultatEtSomme findDedLcPage(String id, String desi, String daty1, String daty2, String mont1, String mont2, String rem, String tiers, String idLigne, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception {
   Connection c=null;
   try {
     c=new UtilDB().GetConn();
     int []a={1,2,6,8,9,16,17,18,19};
     String []val={id,desi,rem,tiers,idLigne,typeLc,compte,ent,dir};
     int[]aInt={3,4,20};
     String[]valInt={daty1,daty2,mont1,mont2,mois1,mois2};
     DedLcUtil du=new DedLcUtil();
     du.setNomTable("DedLc");
     DedLc[] ret= (DedLc[])du.rechercher(a,val,"",c,aInt,valInt);
     String nomColSom[]={"montantHt","montantEng","montantVis","montantFac"};
     double[] sommeNombre=du.calculSommeNombre(a,val,"",c,aInt,valInt,nomColSom);
     return new ResultatEtSomme(ret,sommeNombre);
   }
   catch (Exception ex) {
     throw new Exception(ex.getMessage());
   }
   finally{
     if(c!=null) c.close();
   }
  }
  public String creerOpDirecte(String daty, String designation, String idLigne, String idFacture, String debit, String tier, String remarque, String refU) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      LCEjb lci = LCEjbClient.getInterface();
      LigneCredit[] l=lci.findLC(idLigne,"%","%","%","%","%","%",Constante.getObjetLigneCredit());
      if(l.length==0) throw new Exception("Ligne de credit non existante");
      if(Utilitaire.stringToDouble(debit)+l[0].getMontantVis()>l[0].getCreditModifier()) throw new Exception ("Le montant excede la ligne de credit");
      ded.Ded d=new Ded(designation,daty,debit,"0","creation auto a partir op","30",tier,idLigne);// La demande a dï¿½ja ï¿½tï¿½ op
      Visa v=new Visa("VisaDed",daty,"visa auto",d.getId());
      l[0].setMontantVis(l[0].getMontantVis()+d.getMttc());
      OrdonnerPayement op=new OrdonnerPayement(d.getId(),idLigne,daty,debit,"creation auto a partir op","1");// op deja vise
      Visa vop=new Visa(Constante.getVisaOp(),daty,remarque,op.getId());
      l[0].setMontantFac(l[0].getMontantFac()+d.getMttc());
      d.insertToTableWithHisto(refU,c);
      v.insertToTableWithHisto(refU,c);
      l[0].updateToTableWithHisto(refU,c);
      op.insertToTableWithHisto(refU,c);
      vop.insertToTableWithHisto(refU,c);
      if((idFacture!=null)&&(idFacture.compareToIgnoreCase("")!=0))
      {
        UnionIntraTable uit=new UnionIntraTable(Constante.getOpFactureFournisseur(),op.getId(),idFacture,"Mappage auto",debit);
        uit.setEtat(1);
        uit.insertToTableWithHisto(refU,c);
      }
      c.commit();
      return op.getId();
    }
    catch (Exception ex) {
      c.rollback();
      ex.printStackTrace();
      return null;
    }
    finally
    {
      if(c!=null) c.close();
    }
  }
  public String creerOpDirecteSansVisa(String daty, String designation, String idLigne, String idFacture, String debit, String tier, String remarque, String refU) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      LCEjb lci = LCEjbClient.getInterface();
      LigneCredit[] l=lci.findLC(idLigne,"%","%","%","%","%","%",Constante.getObjetLigneCredit());
      if(l.length==0) throw new Exception("Ligne de credit non existante");
      if(Utilitaire.stringToDouble(debit)+l[0].getMontantVis()>l[0].getCreditModifier()) throw new Exception ("Le montant excede la ligne de credit");
      ded.Ded d=new Ded(designation,daty,debit,"0","creation auto a partir op","30",tier,idLigne);// La demande a dï¿½ja ï¿½tï¿½ op
      Visa v=new Visa("VisaDed",daty,"visa auto",d.getId());
      l[0].setMontantVis(l[0].getMontantVis()+d.getMttc());
      OrdonnerPayement op=new OrdonnerPayement(d.getId(),idLigne,daty,debit,"creation auto a partir op","1");// op deja vise
      d.insertToTableWithHisto(refU,c);
      v.insertToTableWithHisto(refU,c);
      l[0].updateToTableWithHisto(refU,c);
      op.insertToTableWithHisto(refU,c);
       if((idFacture!=null)&&(idFacture.compareToIgnoreCase("")!=0))
      {
        UnionIntraTable uit=new UnionIntraTable(Constante.getOpFactureFournisseur(),op.getId(),idFacture,"Mappage auto",debit);
        uit.setEtat(1);
        uit.insertToTableWithHisto(refU,c);
      }
      c.commit();
      return op.getId();
    }
    catch (Exception ex) {
      c.rollback();
      ex.printStackTrace();
      return null;
    }
    finally
    {
      if(c!=null) c.close();
    }
  }
  public String creerOr(String daty, String idDed, String mont, String eta, String remarque, String refU) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      FactureFournisseurUtil ffu=new FactureFournisseurUtil();
      ffu.setNomTable(Constante.objetFactureClient);
      FactureFournisseur[] ff=(FactureFournisseur[])ffu.rechercher(1,idDed,c);
      if(ff.length==0) throw new Exception("Facture client non existante");
      Visa crtv=new Visa();
      crtv.setNomTable("VisaFactureClient");
      crtv.setIdObjet(ff[0].getIdFactureFournisseur());
      Visa[]ret=(Visa[])CGenUtil.rechercher(crtv,null,null,c,"");
      if(ret.length==0) throw new Exception("Facture non vise");
      double montantDejaOp=AdminGen.calculSommeDouble(ff[0].getOrCree(c),4);
      if (montantDejaOp+Utilitaire.stringToDouble(mont)>ff[0].getMontantTTC()) throw new Exception("Montant op sup facture");
      OrdonnerPayement op=new OrdonnerPayement();
      op.OrdonnerRecette(idDed,ff[0].getRemarque(),daty,mont,remarque,eta);
      op.insertToTableWithHisto(refU,c);
      UnionIntraTableUtil uit=new UnionIntraTableUtil();
      uit.setNomTable("factureclientlcvalide");
      UnionIntraTable[] lcc=(UnionIntraTable[])uit.rechercher(2,idDed,c);
      for(int y=0;y<lcc.length;y++)
        UtilitaireMetier.mapperMereToFille(Constante.tableOrFcLc,"getseqOrFlc","ORL",op.getTuppleID(),lcc[y].getTuppleID(),"auto","0",refU,c);

      c.commit();
      return op.getTuppleID();
    }
    catch (Exception ex) {
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null)c.close();
  }
 }
 public String creerOr(String daty, String idDed, String mont, String eta, String remarque, String typeprevu, String refU) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      FactureFournisseurUtil ffu=new FactureFournisseurUtil();
      ffu.setNomTable(Constante.objetFactureClient);
      FactureFournisseur[] ff=(FactureFournisseur[])ffu.rechercher(1,idDed,c);
      if(ff.length==0) throw new Exception("Facture client non existante");
      Visa crtv=new Visa();
      crtv.setNomTable("VisaFactureClient");
      crtv.setIdObjet(ff[0].getIdFactureFournisseur());
      Visa[]ret=(Visa[])CGenUtil.rechercher(crtv,null,null,c,"");
      if(ret.length==0) throw new Exception("Facture non vise");
      double montantDejaOp=AdminGen.calculSommeDouble(ff[0].getOrCree(c),4);
      if (montantDejaOp+Utilitaire.stringToDouble(mont)>ff[0].getMontantTTC()) throw new Exception("Montant op sup facture");
      OrdonnerPayement op=new OrdonnerPayement();
      op.OrdonnerRecette(idDed,ff[0].getRemarque(),daty,mont,remarque,eta);
      op.insertToTableWithHisto(refU,c);
      UnionIntraTableUtil uit=new UnionIntraTableUtil();
      uit.setNomTable("factureclientlcvalide");
      UnionIntraTable[] lcc=(UnionIntraTable[])uit.rechercher(2,idDed,c);
      for(int y=0;y<lcc.length;y++)
        UtilitaireMetier.mapperMereToFille(Constante.tableOrFcLc,"getseqOrFlc","ORL",op.getTuppleID(),lcc[y].getTuppleID(),"auto","0",refU,c);
      OpVita opv = null;
      if(typeprevu.compareTo("0")!=0){ opv = new OpVita(idDed,op.getIdLigne(),daty,"0",remarque,"0",op.getTuppleID(),"");}
      else opv = new OpVita(idDed,op.getIdLigne(),daty,mont,remarque,"0",op.getTuppleID(),"");
      opv.insertToTableWithHisto(refU,c);
      c.commit();
      return op.getTuppleID();
    }
    catch (Exception ex) {
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null)c.close();
  }
 }
 public String creerOr(String daty, String idDed, String mont, String eta, String remarque, String typeprevu, String refU,Connection c) throws Exception {
    
    try {
      
      FactureFournisseurUtil ffu=new FactureFournisseurUtil();
      ffu.setNomTable(Constante.objetFactureClient);
      FactureFournisseur[] ff=(FactureFournisseur[])ffu.rechercher(1,idDed,c);
      if(ff.length==0) throw new Exception("Facture client non existante");
      Visa crtv=new Visa();
      crtv.setNomTable("VisaFactureClient");
      crtv.setIdObjet(ff[0].getIdFactureFournisseur());
      Visa[]ret=(Visa[])CGenUtil.rechercher(crtv,null,null,c,"");
      if(ret.length==0) throw new Exception("Facture non vise");
      double montantDejaOp=AdminGen.calculSommeDouble(ff[0].getOrCree(c),4);
      if (montantDejaOp+Utilitaire.stringToDouble(mont)>ff[0].getMontantTTC()) throw new Exception("Montant op sup facture");
      OrdonnerPayement op=new OrdonnerPayement();
      op.OrdonnerRecette(idDed,ff[0].getRemarque(),daty,mont,remarque,eta);
      op.insertToTableWithHisto(refU,c);
      UnionIntraTableUtil uit=new UnionIntraTableUtil();
      uit.setNomTable("factureclientlcvalide");
      UnionIntraTable[] lcc=(UnionIntraTable[])uit.rechercher(2,idDed,c);
      for(int y=0;y<lcc.length;y++)
        UtilitaireMetier.mapperMereToFille(Constante.tableOrFcLc,"getseqOrFlc","ORL",op.getTuppleID(),lcc[y].getTuppleID(),"auto","0",refU,c);
      OpVita opv = null;
      if(typeprevu.compareTo("0")!=0){ opv = new OpVita(idDed,op.getIdLigne(),daty,"0",remarque,"0",op.getTuppleID(),"");}
      else opv = new OpVita(idDed,op.getIdLigne(),daty,mont,remarque,"0",op.getTuppleID(),"");
      opv.insertToTableWithHisto(refU,c);
      c.commit();
      return op.getTuppleID();
    }
    catch (Exception ex) {
     
      throw new Exception(ex.getMessage());
    }
    
 }
 public String updateOrdre(String nomtable, String idordre, double sommeCommission, String refUser)throws Exception{
   Connection c = null;
   String ret = "";
   try{
     c= new UtilDB().GetConn();
     c.setAutoCommit(false);
     OrdonnerPayement orp = new OrdonnerPayement();
     orp.setNomTable(nomtable);
     orp.setId(idordre);
     OrdonnerPayement[] lop = (OrdonnerPayement[])CGenUtil.rechercher(orp,null,null,c,"");
     lop[0].setMontant(sommeCommission);
     lop[0].updateToTable(c);

     FactureFournisseur[] ff = (FactureFournisseur[])new FactureFournisseurUtil().rechercher(1,lop[0].getDed_Id(),c);
     ff[0].setMontantTTC(sommeCommission);
     ff[0].updateToTable(c);
     ret = idordre;
     c.commit();
   }catch(Exception ex){
     ex.printStackTrace();
     throw new Exception(ex.getMessage());
   }finally{
     if(c != null){
       c.close();
     }
   }
   return ret;
 }
 public String updateOpVita(String nomtable,String nomtable2,String idornew,String idorancien,String refUser) throws Exception{
   Connection c = null;
   try {
     c= new UtilDB().GetConn();
     c.setAutoCommit(false);
     OpVita o =new OpVita();
     o.setNomTable(nomtable);
     o.setIdor(idorancien);
     OpVita[] lo = (OpVita[])CGenUtil.rechercher(o,null,null,c,"");
     lo[0].setIdor(idornew);
     lo[0].updateToTable(c);
     OrdonnerPayement orp = new OrdonnerPayement();
     orp.setNomTable(nomtable2);
     orp.setId(idorancien);
     OrdonnerPayement[] lop = (OrdonnerPayement[])CGenUtil.rechercher(orp,null,null,c,"");
     lop[0].setMontant(0);
     lop[0].setEtat(2);
     lop[0].updateToTable(c);
     c.commit();
     return idornew;
   }
   catch (Exception ex) {
     ex.printStackTrace();
     return null;
   }
   finally
   {
     if(c!=null) c.close();
   }
}
 public String creerOrResp(String daty, String idDed, String mont, String eta, String remarque,String resp, String refU) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      System.out.println("Le resp globale = "+resp);
      FactureFournisseurUtil ffu=new FactureFournisseurUtil();
      ffu.setNomTable(Constante.objetFactureClient);
      FactureFournisseur[] ff=(FactureFournisseur[])ffu.rechercher(1,idDed,c);
      if(ff.length==0) throw new Exception("Facture client non existante");
      Visa crtv=new Visa();
      crtv.setNomTable("VisaFactureClient");
      crtv.setIdObjet(ff[0].getIdFactureFournisseur());
      Visa[]ret=(Visa[])CGenUtil.rechercher(crtv,null,null,c,"");
      if(ret.length==0) throw new Exception("Facture non vise");
      double montantDejaOp=AdminGen.calculSommeDouble(ff[0].getOrCree(c),4);
      if (montantDejaOp+Utilitaire.stringToDouble(mont)>ff[0].getMontantTTC()) throw new Exception("Montant op sup facture");
      OrdonnerPayement op=new OrdonnerPayement();
      op.OrdonnerRecette(idDed,resp,daty,mont,remarque,eta);
      System.out.println("Le resp = "+op.getIdLigne());
      op.insertToTableWithHisto(refU,c);
      UnionIntraTableUtil uit=new UnionIntraTableUtil();
      uit.setNomTable("factureclientlcvalide");
      UnionIntraTable[] lcc=(UnionIntraTable[])uit.rechercher(2,idDed,c);
      for(int y=0;y<lcc.length;y++)
        UtilitaireMetier.mapperMereToFille(Constante.tableOrFcLc,"getseqOrFlc","ORL",op.getTuppleID(),lcc[y].getTuppleID(),"auto","0",refU,c);
      c.commit();
      return op.getTuppleID();
    }
    catch (Exception ex) {
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null)c.close();
  }
 }
 public String creerOp(String daty, String idDed, String mont, String eta, String remarque, String typeprevu, String refU) throws Exception {
   Connection c = null;
   try {
     c = new UtilDB().GetConn();
      c.setAutoCommit(false);
      FactureFournisseur[] ff = (FactureFournisseur[])new FactureFournisseurUtil().rechercher(1,idDed,c);
      if(ff.length==0) throw new Exception("Facture fournisseur non existante");
      Visa crtv = new Visa();
      crtv.setNomTable("VisaFactureF");
      crtv.setIdObjet(ff[0].getIdFactureFournisseur());
      Visa[]ret=(Visa[])CGenUtil.rechercher(crtv,null,null,c,"");
      if(ret.length==0) throw new Exception("Facture non vise");
      double montantDejaOp=AdminGen.calculSommeDouble(ff[0].getOpCree(c),4);
      if (montantDejaOp+Utilitaire.stringToDouble(mont)>(ff[0].getMontantTTC() + ff[0].getIdTVA())) throw new Exception("Montant op sup facture");
      OrdonnerPayement op=new OrdonnerPayement(idDed,"-",daty,mont,remarque,eta);
      op.insertToTableWithHisto(refU,c);
      UnionIntraTableUtil uit=new UnionIntraTableUtil();
      uit.setNomTable("facturefournisseurlcvalide");
      UnionIntraTable[] lcc=(UnionIntraTable[])uit.rechercher(2,idDed,c);
      for(int y=0;y<lcc.length;y++)
      UtilitaireMetier.mapperMereToFille(Constante.tableOpFfLc,"getseqOpffLc","OFL",op.getTuppleID(),lcc[y].getTuppleID(),"auto","0",refU,c);
      OpVita opv = null;
      if(typeprevu.compareTo("0")!=0){ opv = new OpVita(idDed,op.getIdLigne(),daty,"0",remarque,"0",op.getTuppleID());}
      else opv = new OpVita(idDed,op.getIdLigne(),daty,mont,remarque,"0",op.getTuppleID());
      opv.insertToTableWithHisto(refU,c);
      c.commit();
      return op.getTuppleID();
   }catch (Exception ex) {
     c.rollback();
     throw new Exception(ex.getMessage());
   }
   finally{
     if(c!=null)c.close();
   }
 }
  public String creerOp(String daty, String idDed, String mont, String eta, String remarque, String refU) throws Exception {
    Connection c = null;
    try {
      c = new UtilDB().GetConn();
      c.setAutoCommit(false);
      FactureFournisseur[] ff = (FactureFournisseur[])new FactureFournisseurUtil().rechercher(1,idDed,c);
      if(ff.length==0) throw new Exception("Facture fournisseur non existante");
      Visa crtv = new Visa();
      crtv.setNomTable("VisaFactureF");
      crtv.setIdObjet(ff[0].getIdFactureFournisseur());
      Visa[]ret=(Visa[])CGenUtil.rechercher(crtv,null,null,c,"");
      if(ret.length==0) throw new Exception("Facture non vise");
      double montantDejaOp=AdminGen.calculSommeDouble(ff[0].getOpCree(c),4);
      if (montantDejaOp+Utilitaire.stringToDouble(mont)>(ff[0].getMontantTTC() + ff[0].getIdTVA())) throw new Exception("Montant op sup facture");
        OrdonnerPayement op=new OrdonnerPayement(idDed,"-",daty,mont,remarque,eta);
        op.insertToTableWithHisto(refU,c);
        UnionIntraTableUtil uit=new UnionIntraTableUtil();
        uit.setNomTable("facturefournisseurlcvalide");
        UnionIntraTable[] lcc=(UnionIntraTable[])uit.rechercher(2,idDed,c);
        for(int y=0;y<lcc.length;y++)
          UtilitaireMetier.mapperMereToFille(Constante.tableOpFfLc,"getseqOpffLc","OFL",op.getTuppleID(),lcc[y].getTuppleID(),"auto","0",refU,c);
        c.commit();
        return op.getTuppleID();
    }
    catch (Exception ex) {
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null)c.close();
  }
 }
 public String creerOp(String daty, String idDed, String mont, String eta, String remarque, String refU,Connection c) throws Exception {
    
    try {
      
      FactureFournisseur[] ff = (FactureFournisseur[])new FactureFournisseurUtil().rechercher(1,idDed,c);
      if(ff.length==0) throw new Exception("Facture fournisseur non existante");
      Visa crtv = new Visa();
      crtv.setNomTable("VisaFactureF");
      crtv.setIdObjet(ff[0].getIdFactureFournisseur());
      Visa[]ret=(Visa[])CGenUtil.rechercher(crtv,null,null,c,"");
      if(ret.length==0) throw new Exception("Facture non vise");
      double montantDejaOp=AdminGen.calculSommeDouble(ff[0].getOpCree(c),4);
      if (montantDejaOp+Utilitaire.stringToDouble(mont)>(ff[0].getMontantTTC() + ff[0].getIdTVA())) throw new Exception("Montant op sup facture");
        OrdonnerPayement op=new OrdonnerPayement(idDed,"-",daty,mont,remarque,eta);
        op.insertToTableWithHisto(refU,c);
        UnionIntraTableUtil uit=new UnionIntraTableUtil();
        uit.setNomTable("facturefournisseurlcvalide");
        UnionIntraTable[] lcc=(UnionIntraTable[])uit.rechercher(2,idDed,c);
        for(int y=0;y<lcc.length;y++)
          UtilitaireMetier.mapperMereToFille(Constante.tableOpFfLc,"getseqOpffLc","OFL",op.getTuppleID(),lcc[y].getTuppleID(),"auto","0",refU,c);
        
        return op.getTuppleID();
    }
    catch (Exception ex) {
      
      throw new Exception(ex.getMessage());
    }
    
 }
  public String creerOp(String daty, String idDed, String mont, String eta, String remarque, String typePrevu, String datePaiement, String remarquePaiement, String refU) throws Exception{
   Connection c = null;
   try {
     c = new UtilDB().GetConn();
     c.setAutoCommit(false);
     FactureFournisseur[] ff = (FactureFournisseur[])new FactureFournisseurUtil().rechercher(1,idDed,c);
     if(ff.length==0) throw new Exception("Facture fournisseur non existante");
     Visa crtv = new Visa();
     crtv.setNomTable("VisaFactureF");
     crtv.setIdObjet(ff[0].getIdFactureFournisseur());
     Visa[]ret=(Visa[])CGenUtil.rechercher(crtv,null,null,c,"");
     if(ret.length==0) throw new Exception("Facture non vise");
     double montantDejaOp=AdminGen.calculSommeDouble(ff[0].getOpCree(c),4);
     if (montantDejaOp+Utilitaire.stringToDouble(mont)>(ff[0].getMontantTTC() + ff[0].getIdTVA())) throw new Exception("Montant op sup facture");
     OrdonnerPayement op=new OrdonnerPayement(idDed,"-",daty,mont,remarque,eta);
     op.insertToTableWithHisto(refU,c);
     UnionIntraTableUtil uit=new UnionIntraTableUtil();
     uit.setNomTable("facturefournisseurlcvalide");
     UnionIntraTable[] lcc=(UnionIntraTable[])uit.rechercher(2,idDed,c);
     for(int y=0;y<lcc.length;y++)
       UtilitaireMetier.mapperMereToFille(Constante.tableOpFfLc,"getseqOpffLc","OFL",op.getTuppleID(),lcc[y].getTuppleID(),"auto","0",refU,c);
     this.insertOPTypeDatePaiement(op.getId(), datePaiement, typePrevu, remarquePaiement,refU,c);
     c.commit();
     return op.getTuppleID();
   }
   catch (Exception ex) {
     c.rollback();
     throw new Exception(ex.getMessage());
   }
   finally{
     if(c!=null)c.close();
   }
 }
public String creerOp(String daty, String idDed, String mont, String eta, String remarque, String typePrevu, String datePaiement, String remarquePaiement, String refU,Connection c) throws Exception{
  
   try {
    
     FactureFournisseur[] ff = (FactureFournisseur[])new FactureFournisseurUtil().rechercher(1,idDed,c);
     if(ff.length==0) throw new Exception("Facture fournisseur non existante");
     Visa crtv = new Visa();
     crtv.setNomTable("VisaFactureF");
     crtv.setIdObjet(ff[0].getIdFactureFournisseur());
     Visa[]ret=(Visa[])CGenUtil.rechercher(crtv,null,null,c,"");
     if(ret.length==0) throw new Exception("Facture non vise");
     double montantDejaOp=AdminGen.calculSommeDouble(ff[0].getOpCree(c),4);
     if (montantDejaOp+Utilitaire.stringToDouble(mont)>(ff[0].getMontantTTC() + ff[0].getIdTVA())) throw new Exception("Montant op sup facture");
     OrdonnerPayement op=new OrdonnerPayement(idDed,"-",daty,mont,remarque,eta);
     op.insertToTableWithHisto(refU,c);
     UnionIntraTableUtil uit=new UnionIntraTableUtil();
     uit.setNomTable("facturefournisseurlcvalide");
     UnionIntraTable[] lcc=(UnionIntraTable[])uit.rechercher(2,idDed,c);
     for(int y=0;y<lcc.length;y++)
       UtilitaireMetier.mapperMereToFille(Constante.tableOpFfLc,"getseqOpffLc","OFL",op.getTuppleID(),lcc[y].getTuppleID(),"auto","0",refU,c);
     this.insertOPTypeDatePaiement(op.getId(), datePaiement, typePrevu, remarquePaiement,refU,c);
    
     return op.getTuppleID();
   }
   catch (Exception ex) {
     
     throw new Exception(ex.getMessage());
   }
   
 }
 public FactureFournisseur createOrSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String refU) throws Exception {
   Connection c=null;
  try {
    c=new UtilDB().GetConn();
     c.setAutoCommit(false);
     OrdonnerPayement op=new OrdonnerPayement();
     op.OrdonnerRecette("","",daty,montant,rem,"0");
     FactureFournisseur ff = new FactureFournisseur(Constante.objetFactureClient ,op.getTuppleID(),rem,daty, daty, idFrns, idTva,montant,"orAuto", idDevise);
     ff.insertToTableWithHisto(refU,c);
     op.setDed_Id(ff.getTuppleID());
     op.insertToTableWithHisto(refU,c);
     c.commit();
     ff.setRemarque(op.getTuppleID());
     return ff;
  }
  catch (SQLException ex) {
    c.rollback();
    throw new Exception(ex.getMessage());
  }
  finally{
    if(c!=null)c.close();
  }
  }
  public FactureFournisseur createOrSimpleResp(String daty, String montant, String idTva, String idFrns, String idDevise,String resp, String rem, String refU) throws Exception {
    Connection c=null;
   try {
     c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      FactureFournisseur ff = createOrSimpleResp(daty, montant, idTva, idFrns, idDevise,resp, rem, refU,c);
      c.commit();
      return ff;
   }
   catch (SQLException ex) {
     c.rollback();
     throw new Exception(ex.getMessage());
   }
   finally{
     if(c!=null)c.close();
   }
   }
  public FactureFournisseur createOrSimpleResp(String daty, String montant, String idTva, String idFrns, String idDevise,String resp, String rem, String refU,Connection c) throws Exception {
     try {
      OrdonnerPayement op=new OrdonnerPayement();
      op.OrdonnerRecette("",resp,daty,montant,rem,"0");
      FactureFournisseur ff = new FactureFournisseur(Constante.objetFactureClient ,op.getTuppleID(),rem,daty, daty, idFrns, idTva,montant,"orAuto", idDevise);
      ff.setResp(resp);
      ff.insertToTableWithHisto(refU,c);
      op.setDed_Id(ff.getTuppleID());
      op.insertToTableWithHisto(refU,c);
    
      ff.setRemarque(op.getTuppleID());
      return ff;
   }
   catch (SQLException ex) {
     c.rollback();
     throw new Exception(ex.getMessage());
   }
   }
  public FactureFournisseur createOrFCaDupliquer(FactureFournisseur ff, OrdonnerPayement op, Connection c, String daty, String montant, String refU) throws Exception {
     try {
      OrdonnerPayement or = new OrdonnerPayement();
      or.OrdonnerRecette(op.getDed_Id(),op.getIdLigne(),daty,montant,op.getRemarque(),"0");
      FactureFournisseur ffc = new FactureFournisseur(Constante.objetFactureClient ,or.getTuppleID(),op.getRemarque(),daty, daty, ff.getIdFournisseur(), String.valueOf(ff.getIdTVA()),montant,ff.getRemarque(), ff.getIdDevise());
      ffc.setResp(ff.getResp());
      ffc.insertToTableWithHisto(refU,c);
      or.setDed_Id(ffc.getTuppleID());    
      or.insertToTableWithHisto(refU,c);      
      ffc.setRemarque(or.getTuppleID());
      return ffc;
   }
   catch (SQLException ex) {
     c.rollback();
     throw new Exception(ex.getMessage());
   }
   }
   public FactureFournisseur createOrSimpleResp(String daty, String montant, String idTva, String idFrns, String idDevise,String resp, String rem, String typeprevu, String refU) throws Exception {
     Connection c=null;
    try {
      c=new UtilDB().GetConn();
       c.setAutoCommit(false);
       OrdonnerPayement op=new OrdonnerPayement();
       op.OrdonnerRecette("",resp,daty,montant,rem,"0");
       FactureFournisseur ff = new FactureFournisseur(Constante.objetFactureClient ,op.getTuppleID(),rem,daty, daty, idFrns, idTva,montant,"orAuto", idDevise);
       ff.setResp(resp);
       ff.insertToTableWithHisto(refU,c);
       op.setDed_Id(ff.getTuppleID());
       op.insertToTableWithHisto(refU,c);
       OpVita opv = null;
       if(typeprevu.compareTo("0")!=0){ opv = new OpVita(ff.getIdFactureFournisseur(),op.getIdLigne(),daty,"0",rem,"0",op.getTuppleID(),"");}
       else opv = new OpVita(ff.getIdFactureFournisseur(),op.getIdLigne(),daty,montant,rem,"0",op.getTuppleID(),"");
       opv.insertToTableWithHisto(refU,c);
       c.commit();
       ff.setRemarque(op.getTuppleID());
       return ff;
    }
    catch (SQLException ex) {
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null)c.close();
    }
   }
   public FactureFournisseur createOrSimpleResp(String daty, String montant, String idTva, String idFrns, String idDevise,String resp, String rem, String typeprevu, String refU, Connection c) throws Exception {

    try {

       OrdonnerPayement op=new OrdonnerPayement();
       op.OrdonnerRecette("",resp,daty,montant,rem,"0");
       FactureFournisseur ff = new FactureFournisseur(Constante.objetFactureClient ,op.getTuppleID(),rem,daty, daty, idFrns, idTva,montant,"orAuto", idDevise);
       ff.setResp(resp);
       ff.insertToTableWithHisto(refU,c);
       op.setDed_Id(ff.getTuppleID());
       op.insertToTableWithHisto(refU,c);
       OpVita opv = null;
       if(typeprevu.compareTo("0")!=0){ opv = new OpVita(ff.getIdFactureFournisseur(),op.getIdLigne(),daty,"0",rem,"0",op.getTuppleID(),"");}
       else opv = new OpVita(ff.getIdFactureFournisseur(),op.getIdLigne(),daty,montant,rem,"0",op.getTuppleID(),"");
       opv.insertToTableWithHisto(refU,c);
       c.commit();
       ff.setRemarque(op.getTuppleID());
       return ff;
    }
    catch (SQLException ex) {
      c.rollback();
      throw new Exception(ex.getMessage());
    }
   }
  public OrdonnerPayement annulerOp(String nomTable, String nomTableLiaison, String id, String user) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      OrdonnerPayement crt=new OrdonnerPayement();
      crt.setNomTable(nomTable);
      crt.setId(id);
      crt=((OrdonnerPayement[])CGenUtil.rechercher(crt,null,null,c,""))[0];

      crt.setMontant(0);
      crt.setEtat(0);
      crt.updateToTableWithHisto(user,c);
      UnionIntraTable crtU=new UnionIntraTable();
      crtU.setNomTable(nomTableLiaison);
      crtU.setId1(id);
      UnionIntraTable[]liaison=((UnionIntraTable[])CGenUtil.rechercher(crtU,null,null,c,""));
      for(int i=0;i<liaison.length;i++)
      {
        liaison[i].setMontantMere(0);
        liaison[i].updateToTableWithHisto(user,c);
      }
      c.commit();
      return crt;
    }
    catch (Exception ex) {
      c.rollback();

      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public int dupliquerOR(String numObjet,String[] montantTab,int n_dupl,String[] lmois,String[] lannee,String[] ldate, String refU)throws Exception{
    Connection c = null;
    OrdonnerPayement op = new OrdonnerPayement();
    op.setNomTable("OrdonnerRecette");
    try{

      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      //maka izay idLc mifanaraka amin'ilay op
      UnionIntraTable[] idLcArecup = op.recupererIdLcAttachement("FactureclientLc","OrdonnerRecette",numObjet,c);
      String[] montantLc = new String[idLcArecup.length];
      String[] listidlc = new String[idLcArecup.length];

      for(int k=0;k<idLcArecup.length;k++){
        montantLc[k]=""+idLcArecup[k].getMontantMere();
        listidlc[k] = idLcArecup[k].getId2();
      }
      String idlc = Utilitaire.stringToTab(listidlc,"'",",");
      FactureFournisseur cri = new FactureFournisseur();
      cri.setNomTable("Factureclient");
      op.setId(numObjet);
      OrdonnerPayement ops = ((OrdonnerPayement[])CGenUtil.rechercher(op,null,null,c,""))[0];
      cri.setIdFactureFournisseur(ops.getDed_Id());
      FactureFournisseur[] dem = (FactureFournisseur[])CGenUtil.rechercher(cri,null,null,c,"");
      for(int j = 0; j < n_dupl; j++){
        FactureFournisseur ff = createOrFCaDupliquer(dem[0], ops, c, ldate[j], montantTab[j], refU);
        String[] listeLC = op.construireIDLC("LigneCreditRecette",lmois[j],lannee[j],idlc,c); //manova lc
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();
        lci.mapperOrFactureClientLCTableauDupliquer(ff.getRemarque(), listeLC, "-", montantLc, refU,c);
        lci.validerMappageLCMOrControle(Constante.tableOrFcLc,"FACTURECLIENTLC",ff.getRemarque(),refU,c);
      }
      c.commit();
      return 1;
    }catch(Exception ex){
      throw ex;
    }
    finally{
      if(c != null){
        c.close();
      }
    }
  }
   public int dupliquerORLC(String numObjet,String[] montantTab,int n_dupl,String[] lmois,String[] lannee,String[] ldate, String refU)throws Exception{
    Connection c = null;
    OrdonnerPayement op = new OrdonnerPayement();
    op.setNomTable("OrdonnerRecette");
    try{

      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      UnionIntraTable[] idLcArecup = op.recupererIdLcAttachement("FactureclientLc","OrdonnerRecette",numObjet,c);
      String[] montantLc = new String[idLcArecup.length];
      String[] listidlc = new String[idLcArecup.length];

      for(int k=0;k<idLcArecup.length;k++){
        montantLc[k]=""+idLcArecup[k].getMontantMere();
        listidlc[k] = idLcArecup[k].getId2();
      }
      String idlc = Utilitaire.stringToTab(listidlc,"'",",");
      FactureFournisseur cri = new FactureFournisseur();
      cri.setNomTable("Factureclient");
      op.setId(numObjet);
      OrdonnerPayement ops = ((OrdonnerPayement[])CGenUtil.rechercher(op,null,null,c,""))[0];
      cri.setIdFactureFournisseur(ops.getDed_Id());
      FactureFournisseur[] dem = (FactureFournisseur[])CGenUtil.rechercher(cri,null,null,c,"");
      for(int j = 0; j < n_dupl; j++){
        FactureFournisseur ff = createOrSimpleResp(ldate[j], montantTab[j], dem[0].getIdTVA()+"", dem[0].getIdFournisseur(), dem[0].getIdDevise(),dem[0].getResp(), ops.getRemarque(), refU,c);
        String[] listeLC = op.construireIDLC("LigneCreditRecette",lmois[j],lannee[j],idlc,c); //manova lc
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();
        lci.mapperOrFactureClientLCTableau(ff.getRemarque(), listeLC, "or auto", montantLc, refU,c);
        lci.validerMappageLCMOrControle(Constante.tableOrFcLc,"FACTURECLIENTLC",numObjet,refU,c);
      }
      c.commit();
      return 1;
    }catch(Exception ex){
      throw ex;
    }
    finally{
      if(c != null){
        c.close();
      }
    }
  }
  public int dupliquerOPLC(String numObjet,String[] montantTab,int n_dupl,String[] lmois,String[] lannee,String[] ldate, String refU)throws Exception{
        Connection c = null;
    OrdonnerPayement op = new OrdonnerPayement();
    op.setNomTable("OrdonnerPayement");
    try{

      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      UnionIntraTable[] idLcArecup = op.recupererIdLcAttachement("FactureFournisseurLc","OrdonnerPayement",numObjet,c);
      String[] montantLc = new String[idLcArecup.length];
      String[] listidlc = new String[idLcArecup.length];

      for(int k=0;k<idLcArecup.length;k++){
        montantLc[k]=""+idLcArecup[k].getMontantMere();
        listidlc[k] = idLcArecup[k].getId2();
      }

      String idlc = Utilitaire.stringToTab(listidlc,"'",",");
      FactureFournisseur cri = new FactureFournisseur();
      cri.setNomTable("FactureFournisseur");
      op.setId(numObjet);
      OrdonnerPayement ops = ((OrdonnerPayement[])CGenUtil.rechercher(op,null,null,c,""))[0];
      cri.setIdFactureFournisseur(ops.getDed_Id());
      FactureFournisseur[] dem = (FactureFournisseur[])CGenUtil.rechercher(cri,null,null,c,"");
      
      for(int j = 0; j < n_dupl; j++){
        
        FactureFournisseur ff =  dupliquerOpSimple(numObjet,ldate[j],montantTab[j],String.valueOf(dem[0].getIdTVA()),dem[0].getIdFournisseur(),Utilitaire.champNull(dem[0].getIdDevise()),ops.getRemarque(),refU);
          
        // System.out.println("indice"+j+ff.idFactureFournisseur);
        String[] listeLC = op.construireIDLC("LigneCredit",lmois[j],lannee[j],idlc,c); //manova lc
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();
	//System.out.println(j+" " +ff.getNumFact()+ " "+ listeLC[0]);
        lci.mapperOpFactureFournisseurLCTableau(ff.getRemarque(), listeLC, "facture op auto", montantLc, refU,c);

        lci.validerMappageLCMOpControle(Constante.tableOpFfLc,"FACTUREFOURNISSEURLC",ff.getNumFact(),refU,c);
      }
      c.commit();
      return 1;
    }catch(Exception ex){
      throw ex;
    }finally{
      if(c != null){
        c.close();
      }
    } }
  public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem,String typeprevu, String refU) throws Exception {
   Connection c = null;
   try {
     c = new UtilDB().GetConn();
     c.setAutoCommit(false);
     if(typeprevu == null) typeprevu = "0";
     OrdonnerPayement op = new OrdonnerPayement("","",daty,montant,rem,"0");
     FactureFournisseur ff = new FactureFournisseur(Constante.getObjetFactureFournisseur() ,op.getTuppleID(),rem,daty, daty, idFrns, idTva,montant,"opAuto", idDevise);
     ff.insertToTableWithHisto(refU,c);
     op.setDed_Id(ff.getTuppleID());
     op.insertToTableWithHisto(refU,c);
     OpVita opv = null;
     if(typeprevu.compareTo("0")!=0){ opv = new OpVita(ff.getIdFactureFournisseur(),op.getIdLigne(),daty,"0",rem,"0",op.getTuppleID());}
     else opv = new OpVita(ff.getIdFactureFournisseur(),op.getIdLigne(),daty,montant,rem,"0",op.getTuppleID());
     opv.insertToTableWithHisto(refU,c);
     c.commit();
     ff.setRemarque(op.getTuppleID());
     return ff;
  }
  catch (SQLException ex) {
    c.rollback();
    throw new Exception(ex.getMessage());
  }
  finally{
    if(c!=null)c.close();
  }
  }
  
  public int dupliquerOP(String numObjet,String[] montantTab,int n_dupl,String[] lmois,String[] lannee,String[] ldate, String refU)throws Exception{
    Connection c = null;
    OrdonnerPayement op = new OrdonnerPayement();
    op.setNomTable("OrdonnerPayement");
    try{

      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      UnionIntraTable[] idLcArecup = op.recupererIdLcAttachement("FactureFournisseurLc","OrdonnerPayement",numObjet,c);
      String[] montantLc = new String[idLcArecup.length];
      String[] listidlc = new String[idLcArecup.length];

      for(int k=0;k<idLcArecup.length;k++){
        montantLc[k]=""+idLcArecup[k].getMontantMere();
        listidlc[k] = idLcArecup[k].getId2();
      }

      String idlc = Utilitaire.stringToTab(listidlc,"'",",");
      FactureFournisseur cri = new FactureFournisseur();
      cri.setNomTable("FactureFournisseur");
      op.setId(numObjet);
      OrdonnerPayement ops = ((OrdonnerPayement[])CGenUtil.rechercher(op,null,null,c,""))[0];
      cri.setIdFactureFournisseur(ops.getDed_Id());
      FactureFournisseur[] dem = (FactureFournisseur[])CGenUtil.rechercher(cri,null,null,c,"");
      for(int j = 0; j < n_dupl; j++){
          FactureFournisseur ff = dupliquerOpSimple(c,numObjet,ldate[j], montantTab[j], String.valueOf(dem[0].getIdTVA()), dem[0].getIdFournisseur(), dem[0].getIdDevise().toString(), ops.getRemarque(), refU);
          //FactureFournisseur ff = createOpSimple(ldate[j],montantTab[j],String.valueOf(dem[0].getIdTVA()),dem[0].getIdFournisseur(),dem[0].getIdDevise().toString(),ops.getRemarque(),refU);
        String[] listeLC = op.construireIDLC("LigneCredit",lmois[j],lannee[j],idlc,c); //manova lc
        LCEjb lci = null;
        lci = LCEjbClient.getInterface();
		//System.out.println(j+" " +ff.getNumFact()+ " "+ listeLC[0]);
        lci.mapperOpFactureFournisseurLCTableau(ff.getRemarque(), listeLC, "facture op auto", montantLc, refU, c);

        lci.validerMappageLCMOpControle(Constante.tableOpFfLc,"FACTUREFOURNISSEURLC",ff.getNumFact(),refU, c);
      }
      c.commit();
      return 1;
    }catch(Exception ex){
      throw ex;
    }finally{
      if(c != null){
        c.close();
      }
    } }
  

  public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem,String typeprevu,String datePaiement, String remarquePaiement, String refU) throws Exception {
   Connection c = null;
   try {
     c = new UtilDB().GetConn();
     c.setAutoCommit(false);
     if(typeprevu == null) typeprevu = "0";
     OrdonnerPayement op = new OrdonnerPayement("","",daty,montant,rem,"0");
     FactureFournisseur ff = new FactureFournisseur(Constante.getObjetFactureFournisseur() ,op.getTuppleID(),rem,daty, daty, idFrns, idTva,montant,"opAuto", idDevise);
     ff.insertToTableWithHisto(refU,c);
     op.setDed_Id(ff.getTuppleID());
     op.insertToTableWithHisto(refU,c);
     OpVita opv = null;
     if(typeprevu.compareTo("0")!=0){ opv = new OpVita(ff.getIdFactureFournisseur(),op.getIdLigne(),daty,"0",rem,"0",op.getTuppleID());}
     else opv = new OpVita(ff.getIdFactureFournisseur(),op.getIdLigne(),daty,montant,rem,"0",op.getTuppleID());
     opv.insertToTableWithHisto(refU,c);
     c.commit();
     ff.setRemarque(op.getTuppleID());
     this.insertOPTypeDatePaiement(op.getId(), datePaiement, typeprevu, remarquePaiement,refU,c);
     return ff;
  }
  catch (SQLException ex) {
    c.rollback();
    throw new Exception(ex.getMessage());
  }
  finally{
    if(c!=null)c.close();
  }
  }
 public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String refU) throws Exception {
   Connection c = null;
  try {
    c = new UtilDB().GetConn();
     c.setAutoCommit(false);
     OrdonnerPayement op = new OrdonnerPayement("","",daty,montant,rem,"0");
     FactureFournisseur ff = new FactureFournisseur(Constante.getObjetFactureFournisseur() ,op.getTuppleID(),rem,daty, daty, idFrns, idTva,montant,"opAuto", idDevise);
     ff.insertToTableWithHisto(refU,c);
     op.setDed_Id(ff.getTuppleID());
     op.insertToTableWithHisto(refU,c);
       
     c.commit();
     ff.setRemarque(op.getTuppleID());
     return ff;
  }
  catch (SQLException ex) {
    c.rollback();
    throw new Exception(ex.getMessage());
  }
  finally{
    if(c!=null)c.close();
  }
 }
 public FactureFournisseur dupliquerOpSimple(String numObjet,String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String refU) throws Exception {
   Connection c = null;
  try {
    c = new UtilDB().GetConn();
     c.setAutoCommit(false);
     OrdonnerPayement op = new OrdonnerPayement("","",daty,montant,rem,"1");
     FactureFournisseur ff = new FactureFournisseur(Constante.getObjetFactureFournisseur() ,op.getTuppleID(),rem,daty, daty, idFrns, idTva,montant,"opAuto", idDevise);
     ff.insertToTableWithHisto(refU,c);
     op.setDed_Id(ff.getTuppleID());
     op.insertToTableWithHisto(refU,c);
     //creer date paiement
      OpTypeDatePaiement typeDatePaiement = ((OpTypeDatePaiement[])CGenUtil.rechercher(new OpTypeDatePaiement(),null,null,c," and IDOP='"+numObjet+"'"))[0];
      this.insertOPTypeDatePaiement(op.getId(), daty,typeDatePaiement.getTypee() ,typeDatePaiement.getRemarque() ,refU,c);
      
     c.commit();
     ff.setRemarque(op.getTuppleID());
     return ff;
  }
  catch (SQLException ex) {
    c.rollback();
    throw new Exception(ex.getMessage());
  }
  finally{
    if(c!=null)c.close();
  }
 }
 public FactureFournisseur dupliquerOpSimple(Connection c,String numObjet,String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String refU) throws Exception {
   try {
     OrdonnerPayement op = new OrdonnerPayement(c,daty,montant,rem,"1");
     FactureFournisseur ff = new FactureFournisseur(c,Constante.getObjetFactureFournisseur() ,op.getTuppleID(),rem,daty, daty, idFrns, idTva,montant,"opAuto", idDevise);
     ff.insertToTableWithHisto(refU,c);
     op.setDed_Id(ff.getTuppleID());
     op.insertToTableWithHisto(refU,c);
     //creer date paiement
      OpTypeDatePaiement typeDatePaiement = ((OpTypeDatePaiement[])CGenUtil.rechercher(new OpTypeDatePaiement(),null,null,c," and IDOP='"+numObjet+"'"))[0];
      this.insertOPTypeDatePaiement(op.getId(), daty,typeDatePaiement.getTypee() ,typeDatePaiement.getRemarque() ,refU,c);
     ff.setRemarque(op.getTuppleID());
     return ff;
  }
  catch (SQLException ex) {
    c.rollback();
    throw new Exception(ex.getMessage());
  }
 }
 
  public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String refU,Connection c) throws Exception {

  try {

     OrdonnerPayement op = new OrdonnerPayement("","",daty,montant,rem,"0");
     FactureFournisseur ff = new FactureFournisseur(Constante.getObjetFactureFournisseur() ,op.getTuppleID(),rem,daty, daty, idFrns, idTva,montant,"opAuto", idDevise);
     ff.insertToTableWithHisto(refU,c);
     op.setDed_Id(ff.getTuppleID());
     op.insertToTableWithHisto(refU,c);
     ff.setRemarque(op.getTuppleID());
     return ff;
  }
  catch (SQLException ex) {
    throw new Exception(ex.getMessage());
  }
  }

  public FactureFournisseur createOpSimpleLc(String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String lc, String refU) throws Exception {
     Connection c=null;
    try {
      c=new UtilDB().GetConn();
       c.setAutoCommit(false);
       OrdonnerPayement op=new OrdonnerPayement("","",daty,montant,rem,"0");
       FactureFournisseur ff = new FactureFournisseur(Constante.getObjetFactureFournisseur() ,op.getTuppleID(),rem,daty, daty, idFrns, idTva,montant,"opAuto", idDevise);
       ff.insertToTableWithHisto(refU,c);
       UtilitaireMetier.mapperMereToFille("FACTUREFOURNISSEURLC","getSeqFactLigneF","SFF",ff.getTuppleID(),lc,"lc auto",montant,refU,c);
       op.setDed_Id(ff.getTuppleID());
       op.insertToTableWithHisto(refU,c);
       c.commit();
       ff.setRemarque(op.getTuppleID());
       return ff;
    }
    catch (SQLException ex) {
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null)c.close();
    }
  }
 public String creerOrVise(String daty, String ligne, String mont, String eta, String idFact, String refU) throws Exception {
   String idOr=creerOR(daty,ligne,mont,eta,refU);
   UnionIntraTable uOrFact=new UnionIntraTable(ConstanteRecette.getOrFacture() ,idOr,idFact,"mapp auto",mont);
   uOrFact.insertToTableWithHisto(refU);
   LCEjbClient.getInterface().validerMappageAvecControle(ConstanteRecette.getOrFacture(),uOrFact.getId(),mont,refU);
   return viserOr(daty,"auto",idOr,refU);
 }
 public String creerOR(String daty, String ligne, String mont, String eta, String refU) throws Exception {
   OrdonnerPayement or=new OrdonnerPayement();
   or.OrdonnerRecette(ligne,daty,mont,"-",eta);
   or.insertToTableWithHisto(refU);
   return or.getId();
 }
 public String creerOR(String ded, String ligne, String dt, String mont, String rem, String eta, String refU) throws Exception {
   OrdonnerPayement or=new OrdonnerPayement();
   or.OrdonnerRecette(ded,ligne,dt,mont,rem,eta);
   or.insertToTableWithHisto(refU);
   return or.getId();
 }
 public String creerOR(String ded, String ligne, String dt, String mont, String rem, String eta, String refU, Connection c) throws Exception {
   OrdonnerPayement or=new OrdonnerPayement();
   or.OrdonnerRecette(ded,ligne,dt,mont,rem,eta);
   or.insertToTableWithHisto(refU,c);
   return or.getId();
 }
 public String viserOr(String daty, String remarque, String idObjet, String refU) throws Exception {
   Connection con=null;
  try {
    con=new UtilDB().GetConn();
     con.setAutoCommit(false);
     String retour = viserOr( daty,  remarque,  idObjet,  refU, con);
     con.commit();
     return retour;
  }
  catch (Exception ex) {
    ex.printStackTrace();
    con.rollback();
    return null;
  }
  finally{
    if(con!=null)con.close();
   }
 }
 
 public String viserOr(String daty, String remarque, String idObjet, String refU, Connection con) throws Exception {

     OpUtil ou=new OpUtil();
     ou.setNomTable("OrdonnerRecette");
     OrdonnerPayement[] op=(OrdonnerPayement[] )ou.rechercher(1,idObjet,con);
    if(op.length==0) throw new Exception("L or n existe pas");
     if(op[0].orEstVisable(con)==false) throw new Exception("L or n'est pas visable");
     if(op[0].getEtat()>0) throw new Exception("Or deja vise");
     FactureFournisseurUtil ffu=new FactureFournisseurUtil();
     ffu.setNomTable("FactureClient");
     FactureFournisseur[] ff=(FactureFournisseur[])ffu.rechercher(1,op[0].getDed_Id(),con);
     if (ff.length==0)throw new Exception ("pas de facture correspondante");
     if(ff[0].estIlVise("VisaFactureClient",con)==null) // si la facture n a pas encore ï¿½tï¿½ visï¿½
     {
         GestionFactureFournisseurClient.getInterface().viserFactureC(ff[0].getTuppleID(),"Visa or",con, refU);
     }
     ded.Visa v=new ded.Visa(ConstanteRecette.getVisaOr(),daty,remarque,idObjet);
     v.insertToTableWithHisto(refU,con);
     op[0].setNomTable(ConstanteRecette.getOr());
     op[0].setEtat(1);
     op[0].updateToTableWithHisto(refU,con);
     
     return v.getId();
  
 }
 
 public String viserOpDed(String daty, String remarque, String idDed, String refU) throws Exception {
     OrdonnerPayement[] op=(OrdonnerPayement[])new OpUtil().rechercher(2,idDed);
     String retour=null;
     for (int i=0;i<op.length;i++)
       retour = viserOp(daty,remarque,op[i].getId(),refU);
     return retour;
 }
 public String viserOp(String daty, String remarque, String idObjet, String refU) throws Exception {
   Connection con=null;
   try {
     con = new UtilDB().GetConn();
     con.setAutoCommit(false);
     OrdonnerPayement[] op=(OrdonnerPayement[] )new OpUtil().rechercher(1,idObjet,con);
     if(op.length==0) throw new Exception("L op n existe pas");
     if(op[0].estVisable(con)==false) throw new Exception("L op n'est pas visable");
     FactureFournisseur[] ff = (FactureFournisseur[])new FactureFournisseurUtil().rechercher(1,op[0].getDed_Id(),con);
     if (ff.length==0)throw new Exception ("pas de facture correspondante");
     if(ff[0].estIlVise(con)==null) // si la facture n a pas encore ï¿½tï¿½ visï¿½
     {
       GestionFactureFournisseurClient.getInterface().viserFactureF(ff[0].getTuppleID(),"Visa op",con, refU);
     }
     ded.Visa v=new ded.Visa(Constante.tableVisaOp,daty,remarque,idObjet);
     v.insertToTableWithHisto(refU,con);
     op[0].setNomTable(Constante.getObjetOp());
     op[0].setEtat(1);
     op[0].updateToTableWithHisto(refU,con);
     con.commit();
     return v.getId();
   }
   catch (Exception ex) {
     ex.printStackTrace();
     con.rollback();
     throw ex;
     
   }
   finally{
     if(con!=null)con.close();
     
   }
  }
  public String ventilerOp(String idOp, String[] idLcDet, String[] montant, String[] remarque, String[] eta, String refU) throws Exception {
   Connection c=null;
    try {
      int nbAventiler=idLcDet.length;
      OrdonnerPayement[] de=this.findOp(idOp,"%","%","","","","","%");
      if(de.length==0) throw new Exception("L op n existe pas");
      double sommeListe=Utilitaire.calculSomme(montant);
      if(de[0].getMontant()!=sommeListe) throw new Exception("La somme n est pas balancee");
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      UnionIntraTable[]liste=new UnionIntraTable[nbAventiler];
      for(int i=0;i<nbAventiler;i++)
      {
        liste[i]=new UnionIntraTable(ConstantesDed.getTableOpLcDet(),ConstantesDed.getFonctOpLcDet(),ConstantesDed.getSuffOpLcDet(),idOp,idLcDet[i],remarque[i],montant[i],eta[i]);
        liste[i].insertToTableWithHisto(refU,c);
      }
      c.commit();
      return null;
    }
    catch (Exception ex) {
      c.rollback();
      ex.printStackTrace();
      return null;
    }
    finally{
      if(c!=null) c.close();
   }
  }
  public OrdonnerPayement[] findOp(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem) throws Exception {
    int []a={1,2,3,6};
    String []val={id,idDed,idLigne,rem};
    int[]aInt={4,5};
    String[]valInt={daty1,daty2,montant1,mont2};
    OpUtil op=new OpUtil();
    return (OrdonnerPayement[])op.rechercher(a,val,"",aInt,valInt);
 }
 public OrdonnerPayement[] findOr(String id, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem) throws Exception {
   int []a={1,3,6};
   String []val={id,idLigne,rem};
   int[]aInt={4,5};
   String[]valInt={daty1,daty2,montant1,mont2};
   OpUtil op=new OpUtil();
   op.setNomTable("OrdonnerRecette");
   return (OrdonnerPayement[])op.rechercher(a,val,"",aInt,valInt);
 }
 public ResultatEtSomme findOpPage(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception {
      return this.findOpPage("opValide",id,idDed, idLigne, daty1, daty2, montant1, mont2, rem, numPage);

 }
 /*
 Montant1 represente le montant de l'op
 Mont2 represente l'etat de l'op
 */
 public ResultatEtSomme findOpPage(String nomtable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception {
   Connection c = null;
   try {
     c= new UtilDB().GetConn();
     int []a={1,2,3,6,5,7};
      String []val={id,idDed,idLigne,rem,montant1,mont2};
      int[]aInt={4};
      String[]valInt={daty1,daty2};
      String nomColSom[]={"montant"};
      OpUtil op=new OpUtil();
      op.setNomTable(nomtable);
      return(op.rechercherPage(a,val,"",c,aInt,valInt,numPage,nomColSom));
   }
   catch (Exception ex) {
     ex.printStackTrace();
     return null;
   }
   finally
   {
     if(c!=null) c.close();
   }
 }
 public ResultatEtSomme findPrevPage(String nomtable, String id, String description, String idLigne, String daty1, String daty2, String montant1, String mont2, String rang, int numPage) throws Exception {
   Connection c = null;
   try {
     c= new UtilDB().GetConn();
     int []a={1,2,6,5,4};
      String []val={id,description,idLigne,rang,montant1,mont2};
      int[]aInt={3};
      String[]valInt={daty1,daty2};
      String nomColSom[]={"montant"};
      PrevUtil prev=new PrevUtil();
      prev.setNomTable(nomtable);
      return(prev.rechercherPage(a,val,"",c,aInt,valInt,numPage,nomColSom));
   }
   catch (Exception ex) {
     ex.printStackTrace();
     return null;
   }
   finally
   {
     if(c!=null) c.close();
   }
 }
 public ResultatEtSomme findOpPageLc(String nomtable, String id, String idDed, String idLigne, String daty1, String daty2, String etat, String desiLc, String mois1Lc, String mois2Lc, String anneeLc, String dirLc, String entiteLc, String typeLc, String compteLc, int numPage) throws Exception {
  Connection c = null;
  try {
    c= new UtilDB().GetConn();
    int []a={1,2,3,7,8,14,15,16,17,19};
     String []val={id,idDed,idLigne,etat,desiLc,typeLc,compteLc,entiteLc,dirLc,anneeLc};
     int[]aInt={4,18};
     String[]valInt={daty1,daty2,mois1Lc,mois2Lc};
     String nomColSom[]={"montant"};
     OpUtil op=new OpUtil(nomtable);
     //op.setNomTable();
     return(op.rechercherPage(a,val,"",c,aInt,valInt,numPage,nomColSom));
  }
  catch (Exception ex) {
    ex.printStackTrace();
    return null;
  }
  finally
  {
    if(c!=null) c.close();
  }
 }
 public ResultatEtSomme findOrPage(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception {
      return this.findOpPage("orValide",id,idDed, idLigne, daty1, daty2, montant1, mont2, rem, numPage);

 }
  /*
 Montant1 represente le montant de l'or
 Mont2 represente l'etat de l'or
 */
 public ResultatEtSomme findOrPage(String nomtable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, int numPage) throws Exception {
   Connection c = null;
   try {
     c= new UtilDB().GetConn();
     int []a={1,2,3,6,5,7};
      String []val={id,idDed,idLigne,rem,montant1,mont2};
      int[]aInt={4};
      String[]valInt={daty1,daty2};
      String nomColSom[]={"montant"};
      OpUtil op=new OpUtil();
      op.setNomTable(nomtable);
      return(op.rechercherPage(a,val,"",c,aInt,valInt,numPage,nomColSom));
   }
   catch (Exception ex) {
     ex.printStackTrace();
     return null;
   }
   finally
   {
     if(c!=null) c.close();
   }
 }
 public String viserDed(String daty, String remarque, String idObjet, String refU) throws Exception {
   Connection con=null;
   try {
     con=new UtilDB().GetConn();
     con.setAutoCommit(false);
     Ded[] d = (Ded[])new DedUtil().rechercher(1,idObjet);
     d[0].setNomTable(Constante.getObjetDed());
     if(Utilitaire.stringToInt(d[0].getEtat())>=20) throw new Exception("La demande est deja vise");
     if(d.length>0)
       d[0].setEtat("20");
       d[0].updateToTableWithHisto(refU,con);
     Visa v=new Visa("VisaDed",daty,remarque,idObjet);
     v.insertToTableWithHisto(refU,con);
     LCEjb lci = LCEjbClient.getInterface();
     LigneCredit[] l=lci.findLC(d[0].getIdLigne(),"%","%","%","%","%","%",Constante.getObjetLigneCredit());
     if(l.length>0){
       l[0].setMontantVis(l[0].getMontantVis()+d[0].getMontantHt()+d[0].getTaxe());
       l[0].updateToTableWithHisto(refU,con);
     }
     bean.UnionIntraTableUtil uti=new UnionIntraTableUtil();
     uti.setNomTable(ConstantesDed.getTableDedLcDet());
     bean.UnionIntraTable[] ui=uti.findUnionIntraTable(ConstantesDed.getTableDedLcDet(),"%",idObjet,"%","%","","","%","");
     for(int i=0;i<ui.length;i++)
     {
         LcDetail[] ld = lci.findDetailLc(ui[i].getId1(),"%","%","%");
         if(ld.length>0)
           ld[0].setMontantVis(ld[0].getMontantVis()+ui[i].getMontantMere());
           ld[0].updateToTableWithHisto(refU,con);
     }
     con.commit();
     return v.getId();
   }
   catch (Exception ex) {
     ex.printStackTrace();
     con.rollback();
     return null;
   }
   finally{
     if(con!=null)con.close();
   }
   }
   public String updateDed(String idDed, String desi, String daty, String mtht, String tax, String rem, String tiers, String refU) throws Exception {
   Ded[] d=findDed(idDed,"%","","","%","%","%","%","%");
   if(d[0].getEtat().compareTo("10")==0){
   LCEjb lci = LCEjbClient.getInterface();
   LigneCredit[] l=lci.findLC(d[0].getIdLigne(),"%","%","%","%","%","%","%");
   if(l.length>0){
     d[0].setDesignation(desi);
     d[0].setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy",daty));
     d[0].setRemarque(rem);
     d[0].setTiers(tiers);
     double montant = utilitaire.Utilitaire.stringToDouble(mtht)+utilitaire.Utilitaire.stringToDouble(tax);
       if(l[0].getDisponibleVis()>=montant){
        d[0].setMontantHt(utilitaire.Utilitaire.stringToDouble(mtht));
        d[0].setTaxe(utilitaire.Utilitaire.stringToDouble(tax));
       }
       else throw new Exception("Demande superieur au credit disponible");
      d[0].updateToTableWithHisto(refU);
   }
   }
   else throw new Exception("Impossible de modifier. Demande deja vise");
   return d[0].getId();
 }
 public String updateOp(String id, String daty, String mont, String refU) throws Exception {
    OrdonnerPayement[] op =findOp(id,"%","%","","","%","%","%");
    if(op.length>0)
      op[0].setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy", daty));
      op[0].setMontant(utilitaire.Utilitaire.stringToDouble(mont));
      op[0].updateToTableWithHisto(refU);
    return null;
 }
 public OpLc[] findOpLc(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, String typeLc, String compte, String ent, String dir, String mois1, String mois2) throws Exception {
   int []a={1,2,3,6,14,15,16,17};
   String []val={id,idDed,idLigne,rem,typeLc,compte,ent,dir};
   int[]aInt={4,5,20};
   String[]valInt={daty1,daty2,montant1,mont2,mois1,mois2};
   OpUtil op=new OpUtil();
   op.setNomTable("OpLc");
   return (OpLc[])op.rechercher(a,val,"",aInt,valInt);
 }
 public ResultatEtSomme findOpLcPage(String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String rem, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception {
   Connection c= null;
  try {
    c = new UtilDB().GetConn();
    int []a={1,2,3,6,14,15,16,17};
     String []val={id,idDed,idLigne,rem,typeLc,compte,ent,dir};
     int[]aInt={4,5,20};
     String[]valInt={daty1,daty2,montant1,mont2,mois1,mois2};
     OpUtil op=new OpUtil();
     op.setNomTable("OpLc");
      OpLc[] ret=(OpLc[])op.rechercher(a,val,"",c,aInt,valInt,numPage);
     String nomColSom[]={"montant","montantEng","montantVis","montantFac"};
     double[] sommeNombre=op.calculSommeNombre(a,val,"",c,aInt,valInt,nomColSom);
     return new ResultatEtSomme(ret,sommeNombre);
  }

  catch (Exception ex) {
    return null;
  }
  finally{
    if(c!=null) c.close();
   }
 }

 public ResultatEtSomme findOpLcApayerPage(String nomTable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String annee1, String annee2, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception {
   Connection c= null;
  try {
    c = new UtilDB().GetConn();
    int []a={1,2,3,14,15,16,17};
     String []val={id,idDed,idLigne,typeLc,compte,ent,dir};
     int[]aInt={4,5,20,18};
     String[]valInt={daty1,daty2,montant1,mont2,mois1,mois2,annee1,annee2};
     OpUtil op=new OpUtil();
     op.setNomTable(nomTable);
      OpLc[] ret=(OpLc[])op.rechercher(a,val,"",c,aInt,valInt,numPage);
     String nomColSom[]={"montant","montantEng","montantVis","montantFac"};
     double[] sommeNombre=op.calculSommeNombre(a,val,"",c,aInt,valInt,nomColSom);
     return new ResultatEtSomme(ret,sommeNombre);
  }


  catch (Exception ex) {
    return null;
  }
  finally{
    if(c!=null) c.close();
   }
 }
 public ResultatEtSomme findOrLcApayerPage(String nomTable, String id, String idDed, String idLigne, String daty1, String daty2, String montant1, String mont2, String annee1, String annee2, String typeLc, String compte, String ent, String dir, String mois1, String mois2, int numPage) throws Exception {
  Connection c= null;
 try {
   c = new UtilDB().GetConn();
   int []a={1,2,3,14,15,16,17};
    String []val={id,idDed,idLigne,typeLc,compte,ent,dir};
    int[]aInt={4,5,20,18};
    String[]valInt={daty1,daty2,montant1,mont2,mois1,mois2,annee1,annee2};
    OpUtil op=new OpUtil();
    op.setNomTable(nomTable);
     OpLc[] ret=(OpLc[])op.rechercher(a,val,"",c,aInt,valInt,numPage);
    String nomColSom[]={"montant","montantEng","montantVis","montantFac"};
    double[] sommeNombre=op.calculSommeNombre(a,val,"",c,aInt,valInt,nomColSom);
    return new ResultatEtSomme(ret,sommeNombre);
 }


 catch (Exception ex) {
   return null;
 }
 finally{
   if(c!=null) c.close();
  }
 }
 public String degagerDed(String idDed, String refU) throws Exception {
   Connection c= null;
  try {
     c = new UtilDB().GetConn();
     c.setAutoCommit(false);
     Ded[] d = findDed(idDed,"%","","","%","%","%","%","%");
     String d1 =createDed("degagement de"+d[0].getId(),utilitaire.Utilitaire.dateDuJour(),"-"+d[0].getMontantHt(),"-"+d[0].getTaxe(),"-",d[0].getTiers(),d[0].getIdLigne(),refU);
     UnionIntraTableUtil u = new UnionIntraTableUtil();
     UnionIntraTable[] ut = u.findUnionIntraTable(ConstantesDed.getTableDedLcDet(),"%","%",idDed,"%","","","%","");
     for(int i=0;i<ut.length;i++){
      UnionIntraTable uit=new UnionIntraTable(ConstantesDed.getTableDedLcDet(),ut[i].getId1(),d1,"-","-"+ut[i].getMontantMere());
      uit.insertToTableWithHisto(refU,c);
     }
     LCEjb lci = LCEjbClient.getInterface();
     lci.validerMappageAvecControle(ConstantesDed.getTableDedLcDet(),d1,"-"+d[0].getMttc(),refU, c);
     viserDed(utilitaire.Utilitaire.dateDuJour(),"-",d1,refU);
     c.commit();
     return d1;
  }
  catch (Exception ex) {
    if(c!=null)
    c.rollback();
    throw new Exception(ex.getMessage());
  }
  finally
  {
    if(c!=null)c.close();
  }
 }
 public String degagerOp(String idOp, String refU) throws Exception {
  Connection c= null;
 try {
    c = new UtilDB().GetConn();
    c.setAutoCommit(false);
    OrdonnerPayement[] op = findOp(idOp,"%","%","","","","","%");
    String d =degagerDed(op[0].getDed_Id(),refU);
    String op1 =creerOp(utilitaire.Utilitaire.dateDuJour(),d,"-"+op[0].getMontant(),"","degage",refU);
    UnionIntraTableUtil u = new UnionIntraTableUtil();
    UnionIntraTable[] ut = u.findUnionIntraTable(ConstantesDed.getTableOpLcDet(),"%","%",idOp,"%","","","%","");
    for(int i=0;i<ut.length;i++){
     UnionIntraTable uit=new UnionIntraTable(ConstantesDed.getTableOpLcDet(),ut[i].getId1(),op1,"-","-"+ut[i].getMontantMere());
     uit.insertToTableWithHisto(refU,c);
    }
    LCEjb lci = LCEjbClient.getInterface();
    lci.validerMappageAvecControle(ConstantesDed.getTableOpLcDet(),op1,"-"+op[0].getMontant(),refU, c);
    viserOp(utilitaire.Utilitaire.dateDuJour(),"-",op1,refU);
    c.commit();
    return op1;
 }
 catch (Exception ex) {
   if(c!=null)
   c.rollback();
   throw new Exception(ex.getMessage());
 }
 finally
 {
   if(c!=null)c.close();
 }
 }
 public String degagerMvtCaisse(String idMvt, String refU) throws Exception {
   Connection c= null;
   try {
     c = new UtilDB().GetConn();
     c.setAutoCommit(false);
     FinanceEjb fi = FinanceEjbClient.getInterface();
     MvtCaisse[] m =fi.findMvtCaisse(idMvt,"","","","","%","%","%","%","%","%","%","%","%");
     String op = degagerOp(m[0].getIdOrdre(),refU);
     String m1 = fi.createMvtCaisseDepense(utilitaire.Utilitaire.dateDuJour(),"","degagement de"+idMvt,"-"+m[0].getDebit(),m[0].getIdDevise(),m[0].getIdMode(),m[0].getIdCaisse(),"-",m[0].getAgence(),m[0].getTiers(),m[0].getNumPiece(),m[0].getTypeMvt(),op,refU);
     UnionIntraTableUtil u = new UnionIntraTableUtil();
     UnionIntraTable[] ut = u.findUnionIntraTable(ConstantesDed.getTableMvtLcDet(),"%","%",idMvt,"%","","","%","");
     for(int i=0;i<ut.length;i++){
      UnionIntraTable uit=new UnionIntraTable(ConstantesDed.getTableMvtLcDet(),ut[i].getId1(),m1,"-","-"+ut[i].getMontantMere());
      uit.insertToTableWithHisto(refU,c);
     }
     LCEjb lci = LCEjbClient.getInterface();
     lci.validerMappageAvecControle(ConstantesDed.getTableMvtLcDet(),m1,"-"+m[0].getDebit(),refU, c);
     c.commit();
     return m1;
   }
   catch (Exception ex) {
    if(c!=null)
    c.rollback();
    throw new Exception(ex.getMessage());
   }
   finally
   {
    if(c!=null)c.close();
   }
 }

 public void insertOPTypeDatePaiement(String idOP, String datePaiement, String typePrevu, String remarque,String refU,Connection c) throws Exception{
  try{
    OpTypeDatePaiement temp = new OpTypeDatePaiement();
    temp.setIdop(idOP);
    temp.setDate_paiement(Utilitaire.string_date("dd/MM/yyyy",datePaiement));
    temp.setTypee(typePrevu);
    temp.setRemarque(remarque);
    temp.construirePK(c);
    temp.insertToTableWithHisto(refU,c);
  }
  catch(Exception ex){
    throw new Exception(ex.getMessage());
  }
 }

    @Override
    public EJBHome getEJBHome() throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Object getPrimaryKey() throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void remove() throws RemoteException, RemoveException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Handle getHandle() throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean isIdentical(EJBObject obj) throws RemoteException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }


}