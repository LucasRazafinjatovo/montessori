package lc;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;

import utilitaire.Utilitaire;
import bean.UnionIntraTable;
import java.sql.Connection;
import java.sql.*;
import bean.*;
import utilitaire.UtilitaireMetier;
import utilitaire.UtilDB;
import historique.MapHistorique;
import facturefournisseur.FactureFournisseur;
import prevision.*;
import facturefournisseur.FactureFournisseurUtil;
import ded.OrdonnerPayement;
import ded.OpUtil;
import javax.ejb.AccessTimeout;
import javax.ejb.EJBHome;
import javax.ejb.EJBObject;
import javax.ejb.Handle;
import javax.ejb.RemoveException;
import javax.ejb.Stateful;

@Stateful
@AccessTimeout(0)
public class LCEjbBean implements LCEjb, LCEjbRemote, SessionBean {

  public void ejbActivate() throws EJBException {
    // TODO Raccord de méthode auto-généré

  }

  public void ejbPassivate() throws EJBException {
    // TODO Raccord de méthode auto-généré

  }

  public void ejbRemove() throws EJBException {
    // TODO Raccord de méthode auto-généré

  }

  public void setSessionContext(SessionContext arg0) throws EJBException {
    // TODO Raccord de méthode auto-généré

  }

  public void ejbCreate() throws CreateException {
  }

  public String createLCRecette(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String rmq, String refUser, Connection c) throws Exception {
      LigneCredit lc=new LigneCredit();
      lc.LigneCreditRecette (designation,Utilitaire.stringToDouble(creditInitial),Utilitaire.stringToDouble(creditInitial), 0, 0, 0,
                                       idTypeLigne, numCompte, idEntite, iddirection, mois,Utilitaire.stringToInt(annee), rmq);
      lc.insertToTableWithHisto(refUser,c);
      return lc.getTuppleID();
  }

  public String createLCRecette(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String rmq, String refUser) throws Exception {
Connection c=null;
    try {
		c=new utilitaire.UtilDB().GetConn();
      c.setAutoCommit(false);
      String res = createLCRecette(designation, creditInitial, idTypeLigne, numCompte, idEntite, iddirection, mois, annee, rmq, refUser, c);
      c.commit();
      return res;
    } catch (Exception ex) {
      c.rollback();
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null) c.close();
    }
  }

  private String createLC(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable, String refUser, Connection c) throws Exception{
		LigneCredit lc = new LigneCredit(designation, creditInitial,creditInitial, 0, 0, 0,
                                       idTypeLigne, numCompte, idEntite, iddirection, mois, annee, rmq);
      lc.setNomTable(nomTable);
      LcDetail ld=new LcDetail(lc.getIdLigne(),numCompte,String.valueOf(creditInitial));//cree detail auto
      lc.insertToTableWithHisto(refUser,c);
      ld.insertToTableWithHisto(refUser,c);
	  return lc.getTuppleID();
  }

  public String createLC(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable, String refUser) throws Exception {
Connection c=null;
    try {

		c=new utilitaire.UtilDB().GetConn();
		c.setAutoCommit(false);
		String res = createLC(designation, creditInitial, idTypeLigne, numCompte, idEntite, iddirection, mois, annee, rmq, nomTable, refUser, c);

		c.commit();
		return res;
    } catch (Exception ex) {
      c.rollback();
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null) c.close();
    }
  }
  public String createDetailLc(String idLC, String compteDet, String cred, String montantEng, String montantVis, String montantFact, String refU) throws Exception {
    try {
      LcDetail lc=new LcDetail(idLC,compteDet,cred,montantEng,montantVis,montantFact,utilitaire.Constante.getDetailLcCree());
      lc.insertToTableWithHisto(refU);
      return lc.getId();
    }
    catch (Exception ex) {
        return null;
    }
  }
  public String valideDetailLc(String idLC, String refU) throws Exception {
   Connection c = null;
   try {
     LcDetail[] lc=findDetailLc("%",idLC,"%",utilitaire.Constante.getDetailLcValide());
     LigneCredit[] l=findLC(idLC,"%","%","%","%","%","%","%");
     c=new utilitaire.UtilDB().GetConn();
      c.setAutoCommit(false);
     if(lc.length>0)
       if(l.length>0)
         if(lc[0].getCredit()==l[0].getCreditInitial())
           lc[0].deleteToTable(c);
     LcDetail[] ld=findDetailLc("%",idLC,"%",utilitaire.Constante.getDetailLcCree());
     if(lc.length>0){
       for(int i =0; i<lc.length;i++){
         lc[i].setEtat(utilitaire.Utilitaire.stringToInt(utilitaire.Constante.getDetailLcValide()));
         lc[i].updateToTableWithHisto(refU,c);
       }
     }
     c.commit();
     return idLC;
   }
   catch (Exception ex) {
      c.rollback();
      return null;
    }
    finally{
      if(c!=null) c.close();
    }
  }
  public String updateDetailLc(String id, String idLC, String compteDet, String cred, String montantEng, String montantVis, String montantFact, String refU) throws Exception {
   try {
     LcDetail[] lc=findDetailLc(id,"%","%",utilitaire.Constante.getDetailLcCree());
     if(lc.length>0){
     lc[0].setCompteDetail(compteDet);
     lc[0].setCredit(utilitaire.Utilitaire.stringToDouble(cred));
     lc[0].setMontantEng(utilitaire.Utilitaire.stringToDouble(montantEng));
     lc[0].setMontantVis(utilitaire.Utilitaire.stringToDouble(montantVis));
     lc[0].setMontantFact(utilitaire.Utilitaire.stringToDouble(montantFact));
     lc[0].updateToTableWithHisto(refU);
     }
     else throw new Exception ("DetailLc déjà validé");
     return lc[0].getId();
   }
   catch (Exception ex) {
       return null;
   }
  }
  public LcDetail[] findDetailLc(String id, String idLC, String compteDet, String etat) throws Exception {
    try {
      int[] a={1,2,3,8};
      String[] val={id,idLC,compteDet,etat};
      LcDetailUtil lc = new LcDetailUtil();
      LcDetail[] ld=(LcDetail[])(lc.rechercher(a,val," order by credit desc"));
      return ld;
    }
    catch (Exception ex) {
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
  }
  public LcDetail[] findDetailLcLigneCredit(String id, String idLC, String compteDet, String etat, String typeLc, String compte, String ent, String dir, String mois1, String mois2, String annee, String paru) throws Exception {
    try {
      int[] a={1,2,3,8,15,16,17,18,20,21};
      String[] val={id,idLC,compteDet,etat};
      LcDetailUtil lc = new LcDetailUtil();
      lc.setNomTable("LcDetailsLc");
      int interv[]={19};String valInt[]={mois1,mois2};
      LcDetail[] ld=(LcDetail[])(lc.rechercher(a,val," order by credit desc",interv,valInt));
      return ld;
    }
    catch (Exception ex) {
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
  }

  public String createLcMultiple(String designation, String creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String annee, String paruInf, String paruSup, String nomTable, String refUser) throws Exception {

    try {
      int infe=0,supe=0;
      if((paruInf==null)||(paruInf.compareTo("")==0)||(paruInf.compareTo("%")==0))
        infe=0;
      else if ((paruSup==null)||(paruSup.compareTo("")==0)||(paruSup.compareTo("%")==0))
      {
        infe=Utilitaire.stringToInt(paruInf);
        supe=infe;
      }
      else
      {
        infe=Utilitaire.stringToInt(paruInf);
        supe=Utilitaire.stringToInt(paruSup);
      }
      for (int i=infe;i<=supe;i++)
        createLC(designation, Utilitaire.stringToDouble(creditInitial),  idTypeLigne, numCompte, idEntite, iddirection, mois, Utilitaire.stringToInt(annee), String.valueOf(i),nomTable, refUser);
      return "ok";
    } catch (Exception ex) {
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
  }
  public String createLCe(String designation, double creditInitial, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, int annee, String rmq, String nomTable, String refUser) throws Exception {

    try {

      return this.createLC(designation, creditInitial, idTypeLigne, numCompte, idEntite, iddirection, mois,
                           annee,rmq,nomTable, refUser);
    } catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }
  }

  public String copierLC(String idLigneToCopy, String idEntite, String iddirection, String mois, int annee, String rmq, String refUser) throws Exception {

    java.sql.Connection con = null;

    try {

      con = new utilitaire.UtilDB().GetConn();
      con.setAutoCommit(false);

      int[] a = { 1 };
      String[] vall = { idLigneToCopy };
      LigneCredit lc = (LigneCredit) new LigneCreditUtil().rechercher(a,
          vall, "", con)[0];

      LigneCredit lc2 = new LigneCredit(lc.getDesignation(), lc
                                        .getCreditInitial(), lc.getCreditInitial(), 0, 0, 0, lc
                                        .getIdTypeLigne(), lc.getNumCompte(), idEntite,
                                        iddirection, mois, annee, rmq);

      lc2.insertToTable(con);

      historique.MapHistorique h = new historique.MapHistorique(
          "LIGNECREDIT", "insert", refUser, lc.getTuppleID());
      h.insertToTable(con);
      con.commit();

      return lc.getTuppleID();
    } catch (Exception ex) {
      con.rollback();
      throw new Exception(ex.getMessage());
    } finally {
      con.close();
    }
  }

  public String createDirection(String libelledir, String descdir, double idDirecteur, String abbrevDir, String refUser) throws Exception {

    java.sql.Connection con = null;

    try {

      con = new utilitaire.UtilDB().GetConn();
      con.setAutoCommit(false);

      Direction dir = new Direction(libelledir, descdir, idDirecteur,
                                    abbrevDir);

      dir.insertToTable(con);

      historique.MapHistorique h = new historique.MapHistorique(
          "DIRECTION", "insert", refUser, dir.getTuppleID());
      h.insertToTable(con);
      con.commit();

      return dir.getTuppleID();
    } catch (Exception ex) {
      con.rollback();
      throw new Exception(ex.getMessage());
    } finally {
      con.close();
    }
  }

  public String updateDirection(String idToUpdate, String libelledir, String descdir, double idDirecteur, String abbrevDir, String refUser) throws Exception {

    java.sql.Connection con = null;

    try {

      con = new utilitaire.UtilDB().GetConn();
      con.setAutoCommit(false);
      Direction dir = new Direction(idToUpdate,libelledir,descdir,idDirecteur,abbrevDir);
      dir.updateToTable(con);
      historique.MapHistorique h = new historique.MapHistorique(
          "DIRECTION", "update", refUser, dir.getTuppleID());
      h.insertToTable(con);
      con.commit();

      return dir.getTuppleID();
    } catch (Exception ex) {
      con.rollback();
      throw new Exception(ex.getMessage());
    } finally {
      con.close();
    }
  }
  public void updateLC(LigneCredit l, String refUser) throws Exception {
    l.updateToTableWithHisto(refUser);
  }
  public String updateCreditLC(String idLigne, double newCredit, String motif, String refUser) throws Exception {

    java.sql.Connection con = null;

    try {

      con = new utilitaire.UtilDB().GetConn();
      con.setAutoCommit(false);

      CreditModifier cr = new CreditModifier(newCredit, utilitaire.Utilitaire
          .dateDuJourSql(), utilitaire.Utilitaire.heureCourante(),
          motif, idLigne);

      cr.insertToTable(con);

      historique.MapHistorique h = new historique.MapHistorique(
          "CREDITMODIFIER", "insert", refUser, cr.getTuppleID());
      h.insertToTable(con);

      // ref avy manao insertion d manao update ny LC
      int[] a = { 1 };
      String[] vall = { idLigne };
      LigneCreditUtil lcu = new LigneCreditUtil();
      LigneCredit lc = (LigneCredit) lcu.rechercher(a, vall, "",con)[0];
      lc.setCreditModifier(newCredit);
      lc.updateToTable(con);
      con.commit();
      return cr.getTuppleID();

    } catch (Exception ex) {
      con.rollback();
      throw new Exception(ex.getMessage());
    } finally {
      con.close();
    }

  }

  public Direction[] findDirection(String idDir, String libelledir, String descdir, String abbrevDir, String idDirecteur) throws Exception {

    try {
      String afterW="";
      int[] numChamp = { 1, 2, 3, 5 };
      String[] val = { idDir, libelledir, descdir, abbrevDir };
      DirectionUtil du = new DirectionUtil();
      du.utiliserChampBase();
      //if(idDirecteur.compareToIgnoreCase("")==0 || idDirecteur.compareToIgnoreCase("%")==0) idDirecteur = "%";
      //afterW=" AND idDirecteur like  '" + idDirecteur +"'";
      return (Direction[]) du.rechercher(numChamp, val,"");

    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }

  }


  public LigneCredit[] findLC(String idLigne, String designation, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String nomTable) throws Exception {

    try {
      int[] numChamp = { 1, 2, 8, 9, 10, 11, 12 };
      String[] val = { idLigne, designation, idTypeLigne, numCompte,
        idEntite, iddirection, mois };
      LigneCreditUtil lcu = new LigneCreditUtil();
      lcu.setNomTable(nomTable);
      lcu.utiliserChampClasse();
      return (LigneCredit[]) lcu.rechercher(numChamp, val,
          " ORDER BY IDLIGNE DESC ");

    } catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }

  }
  public ResultatEtSomme findLCPage(String idLigne, String designation, String idTypeLigne, String numCompte, String idEntite, String iddirection, String mois, String nomTable, int numPage) throws Exception {
    Connection c=null;
    try {
      c = new UtilDB().GetConn();
      int[] numChamp = { 1, 2, 8, 9, 10, 11, 12 };
      String[] val = { idLigne, designation, idTypeLigne, numCompte,
        idEntite, iddirection, mois };
      LigneCreditUtil lcu = new LigneCreditUtil();
      lcu.setNomTable(nomTable);
      lcu.utiliserChampBase();
      LigneCredit[] ret= (LigneCredit[]) lcu.rechercher(numChamp, val, " ORDER BY IDLIGNE DESC ",c,null,null,numPage);
      String nomColSom[]={"montantEng","montantVis","montantFac"};
      double[] sommeNombre=lcu.calculSommeNombre(numChamp,val,"",c,null,null,nomColSom);
      return new ResultatEtSomme(ret,sommeNombre);
    } catch (Exception ex) {
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null) c.close();
    }

  }
  public LigneCreditComplet[] findLCComplet(String idLigne, String designation, String mois, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String nomTable) throws Exception {

    try {
      int[] numChamp = { 1, 2, 8, 10, 11, 12, 13, 14, 16, 17,9 };
      String[] val = { idLigne, designation, mois, typeLC, numCompte,
        descCompte, libelledir, abbrevdir, entite, idDirection,annee };
      String afterW = " ORDER BY "+colonne+" "+sens;
      LigneCreditCompletUtil lcu = new LigneCreditCompletUtil();
      lcu.setNomTable(nomTable);
      //lcu.utiliserChampClasse();
      return (LigneCreditComplet[]) lcu.rechercher(numChamp, val,afterW);

    } catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }

  }
  public LigneCreditComplet[] findFCC(String idLigne, String designation, String mois1, String mois2, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String nomTable) throws Exception {

    try {
      int[] numChamp = { 1, 2, 10, 11, 12, 13, 14, 16, 17,9 };
      String[] val = { idLigne, designation, typeLC, numCompte,
        descCompte, libelledir, abbrevdir, entite, idDirection,annee };
      String afterW = " ORDER BY "+colonne+" "+sens;
      LigneCreditCompletUtil lcu = new LigneCreditCompletUtil();
      lcu.setNomTable(nomTable);
      int[]inte={8};
      String []valInt={mois1,mois2};
      //lcu.utiliserChampClasse();
      return (LigneCreditComplet[]) lcu.rechercher(numChamp,val,afterW,inte,valInt);

    } catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }
  }
  public LigneCreditComplet[] findFCCParution(String idLigne, String designation, String mois1, String mois2, String typeLC, String numCompte, String descCompte, String libelledir, String abbrevdir, String entite, String idDirection, String colonne, String sens, String annee, String paruInf, String paruSup, String nomTable) throws Exception {

    try {
      int[] numChamp = { 1, 2, 10, 11, 12, 13, 14, 16, 17,9 };
      String[] val = { idLigne, designation, typeLC, numCompte,
        descCompte, libelledir, abbrevdir, entite, idDirection,annee };
      String afterW = " ORDER BY "+colonne+" "+sens;
      LigneCreditCompletUtil lcu = new LigneCreditCompletUtil();
      lcu.setNomTable(nomTable);
      int[]inte={8,18};
      String []valInt={mois1,mois2,paruInf,paruSup};
      //lcu.utiliserChampClasse();
      return (LigneCreditComplet[]) lcu.rechercher(numChamp,val,afterW,inte,valInt);

    } catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }
  }
  public void validerMappageFactureLC(String nomTable, String numFact, String refUser) throws Exception {
    UnionIntraTableUtil utu=new UnionIntraTableUtil();
    UnionIntraTable[] ut= utu.findUnionIntraTable(nomTable,"%",numFact,"%","%","","","0","");
    for(int i=0;i<ut.length;i++)
    {
      validerMappageLC(nomTable, ut[i].getId(), refUser);
    }
  }

  public void validerMappage(String nomTable, String numMap, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      validerMappage(nomTable, numMap, refUser,c);
      c.commit();
    }
    catch (Exception ex) {
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null) c.close();
    }
  }
  public void validerMappage(String nomTable, String numMap, String refUser, Connection c) throws Exception {
    UnionIntraTableUtil utu=new UnionIntraTableUtil();
    UnionIntraTable[] ut= utu.findUnionIntraTable(nomTable,numMap,"%","%","%","","","0","");
    if(ut.length==0) throw new Exception("Le mappage n existe pas");
    ut[0].setEtat(1);
    ut[0].updateToTableWithHisto(refUser,c);
  }
  public void validerMappageAvecControle(String nomTable, String numObjet, String montObjTotal, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      validerMappageAvecControle(nomTable, numObjet,montObjTotal, refUser,c);
      c.commit();
    }
    catch (Exception ex) {
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null) c.close();
    }
  }
  public void validerMappageAvecControle(String nomTable, String numObjet, String montObjTotal, String refUser, Connection c) throws Exception {
    UnionIntraTableUtil utu=new UnionIntraTableUtil();
    UnionIntraTable[] ut= utu.findUnionIntraTable(nomTable,"%","%",numObjet,"%","","","%","");
    if(ut.length==0) throw new Exception("Pas de relation a valider");
    if(ut[0].getEtat()>0) throw new Exception("La relation est deja valide");
    AssociationTable at=new AssociationTableUtil().findAssociationTable("%","%","%","%","%",nomTable)[0];
    String nomTableSituation1=at.getVueSituation1();
    if(ut.length==0) throw new Exception("Le mappage n existe pas");
    double sommeTotal=0;
    for (int i=0;i<ut.length;i++)
    {
      SituationUnion[] su=new SituationUnionUtil().findSituationUnion(nomTableSituation1,ut[i].getId1());
      if(su.length==0) throw new Exception("Pas encore de situation");
      if(su[0].getMontantMap()+ut[i].getMontantMere()>su[0].getMontant()) throw new Exception("Le montant de l'objet mere est depasse");
      ut[i].setEtat(1);
      ut[i].updateToTableWithHisto(refUser,c);
      sommeTotal=sommeTotal+ut[i].getMontantMere();
    }
    if(Utilitaire.stringToDouble(montObjTotal)!=sommeTotal)
    {
      c.rollback();
      throw new Exception("Le montant doit être balance");
    }
  }
  public void validerMappageLCMFactureRecette(String nomTable, String idMere, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      c.setAutoCommit(false);
      FactureFournisseurUtil ffu=new FactureFournisseurUtil();
      ffu.setNomTable("FactureClient");
      FactureFournisseur[] ff=(FactureFournisseur[])ffu.rechercher(1,idMere,c);
      if(ff.length==0)throw new Exception("Id mere non existante");
      if((ff[0].getRemarque()!=null)&&(ff[0].getRemarque().compareToIgnoreCase("opAuto")==0))
      {
        throw new Exception("Veuillez valider a partir OP");
       }
      else
      {
        UnionIntraTableUtil uti=new UnionIntraTableUtil();
        uti.setNomTable(nomTable);
        UnionIntraTable[] ui=(UnionIntraTable[])uti.rechercher(2,idMere,c);
        //double sommeFact=AdminGen.calculSommeDouble(ff,5);
        //double sommeUnion=AdminGen.calculSommeDouble(ui,4);
        double sommeFact=Utilitaire.arrondir(AdminGen.calculSommeDouble(ff,5),2);
        double sommeUnion=Utilitaire.arrondir(AdminGen.calculSommeDouble(ui,4),2);

        if(sommeFact!=sommeUnion) throw new Exception("Somme de mappage non correspondante");
        for(int i=0;i<ui.length;i++){
          validerMappageLC(nomTable, ui[i].getTuppleID(),c, refUser);
        }
      }
      c.commit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally
    {
      if(c!=null) c.close();
    }
  }
  public void validerMappageLCMFacture(String nomTable, String idMere, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      c.setAutoCommit(false);
      FactureFournisseur[] ff=(FactureFournisseur[])new FactureFournisseurUtil().rechercher(1,idMere,c);
      if(ff.length==0)throw new Exception("Id mere non existante");
      if((ff[0].getRemarque()!=null)&&(ff[0].getRemarque().compareToIgnoreCase("opAuto")==0))
      {
        throw new Exception("Veuillez valider a partir OP");
       }
      else
      {
        UnionIntraTableUtil uti=new UnionIntraTableUtil();
        uti.setNomTable(nomTable);
        UnionIntraTable[] ui=(UnionIntraTable[])uti.rechercher(2,idMere,c);
        //double sommeFact=AdminGen.calculSommeDouble(ff,5);
        //double sommeUnion=AdminGen.calculSommeDouble(ui,4);
        double sommeFact=Utilitaire.arrondir(AdminGen.calculSommeDouble(ff,5),2);
        double sommeUnion=Utilitaire.arrondir(AdminGen.calculSommeDouble(ui,4),2);
        if(sommeFact!=sommeUnion) throw new Exception("Somme de mappage non correspondante");
        for(int i=0;i<ui.length;i++){
          validerMappageLC(nomTable, ui[i].getTuppleID(),c, refUser);
        }
      }
      c.commit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally
    {
      if(c!=null) c.close();
    }
  }
  public void validerMappageLCMOpControle(String nomTable, String nomTableControl, String idMere, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      c.setAutoCommit(false);
      UnionIntraTableUtil uti = new UnionIntraTableUtil();
      uti.setNomTable(nomTable);
      UnionIntraTable[] ui=(UnionIntraTable[])uti.rechercher(2,idMere,c);
      /*
      Controle facture fournisseur LC
      */

      ded.OrdonnerPayement[] ff = (ded.OrdonnerPayement[])new ded.OpUtil().rechercher(1,idMere,c);
      if(ff.length == 0)throw new Exception("Id mere non existante");
      double sommeFact = Utilitaire.arrondir(AdminGen.calculSommeDouble(ff,4),2);
      double sommeUnion = Utilitaire.arrondir(AdminGen.calculSommeDouble(ui,4),2);

      //System.out.println(" ============== somme fact = " + sommeFact + " union = " + sommeUnion);

      if(sommeFact!=sommeUnion) throw new Exception("Somme de mappage non correspondante");
      for(int ik=0;ik<ui.length;ik++)
      {
        uti.setNomTable(nomTableControl);
        UnionIntraTable[] unionFacture = (UnionIntraTable[])uti.rechercher(1,ui[ik].getId2(),c);
        if(unionFacture.length == 0)throw new Exception("Facture non existante");
        //if(unionFacture[0].getMontantMere()<ui[ik].getMontantMere())throw new Exception("Montant "+ui[ik].getMontantMere()+" invalide");
        //System.out.print("================================================================ + ");
        ui[ik].setEtat(1);
        ui[ik].setNomTable(nomTable);
        ui[ik].updateToTableWithHisto(refUser,c);
        uti.setNomTable(nomTableControl);

          unionFacture[0].setEtat(1);
          unionFacture[0].setNomTable(nomTableControl);
          unionFacture[0].updateToTableWithHisto(refUser,c);
          //System.out.print("================================================================ + " + unionFacture.length);

      }
      c.commit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally
    {
      if(c!=null) c.close();
    }
  }
  
  public void validerMappageLCMOpControle(String nomTable, String nomTableControl, String idMere, String refUser,Connection c) throws Exception {

    try {
     
      UnionIntraTableUtil uti = new UnionIntraTableUtil();
      uti.setNomTable(nomTable);
      UnionIntraTable[] ui=(UnionIntraTable[])uti.rechercher(2,idMere,c);
      /*
      Controle facture fournisseur LC
      */

      ded.OrdonnerPayement[] ff = (ded.OrdonnerPayement[])new ded.OpUtil().rechercher(1,idMere,c);
      if(ff.length == 0)throw new Exception("Id mere non existante");
      double sommeFact = Utilitaire.arrondir(AdminGen.calculSommeDouble(ff,4),2);
      double sommeUnion = Utilitaire.arrondir(AdminGen.calculSommeDouble(ui,4),2);

      //System.out.println(" ============== somme fact = " + sommeFact + " union = " + sommeUnion);

      if(sommeFact!=sommeUnion) throw new Exception("Somme de mappage non correspondante");
      for(int ik=0;ik<ui.length;ik++)
      {
        uti.setNomTable(nomTableControl);
        UnionIntraTable[] unionFacture = (UnionIntraTable[])uti.rechercher(1,ui[ik].getId2(),c);
        if(unionFacture.length == 0)throw new Exception("Facture non existante");
        //if(unionFacture[0].getMontantMere()<ui[ik].getMontantMere())throw new Exception("Montant "+ui[ik].getMontantMere()+" invalide");
        //System.out.print("================================================================ + ");
        ui[ik].setEtat(1);
        ui[ik].setNomTable(nomTable);
        ui[ik].updateToTableWithHisto(refUser,c);
        uti.setNomTable(nomTableControl);

          unionFacture[0].setEtat(1);
          unionFacture[0].setNomTable(nomTableControl);
          unionFacture[0].updateToTableWithHisto(refUser,c);
          //System.out.print("================================================================ + " + unionFacture.length);

      }
   
    }
    catch (Exception ex) {
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
  }
  public void validerMappageLCMOrControle(String nomTable, String nomTableControl, String idMere, String refUser) throws Exception {
      Connection c=null;
 
      try {
       c=new utilitaire.UtilDB().GetConn();
      c.setAutoCommit(false);
      validerMappageLCMOrControle(nomTable, nomTableControl, idMere , refUser, c);
      c.commit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally
    {
      if(c!=null) c.close();
    }
  }
  public void validerMappageLCMOrControle(String nomTable, String nomTableControl, String idMere, String refUser, Connection c) throws Exception {

    try {
      UnionIntraTableUtil uti=new UnionIntraTableUtil();
      uti.setNomTable(nomTable);
      UnionIntraTable[] ui=(UnionIntraTable[])uti.rechercher(2,idMere,c);
      ded.OpUtil ou=new ded.OpUtil();
      ou.setNomTable("OrdonnerRecette");
      ded.OrdonnerPayement[] ff=(ded.OrdonnerPayement[])ou.rechercher(1,idMere,c);
      if(ff.length==0)throw new Exception("Id mere non existante");
      double sommeFact=Utilitaire.arrondir(AdminGen.calculSommeDouble(ff,4),2);
      double sommeUnion=Utilitaire.arrondir(AdminGen.calculSommeDouble(ui,4),2);
      System.out.println(" sommeFact = " + sommeFact + " sommeUnion = " + sommeUnion);
//      if(sommeFact != sommeUnion) throw new Exception("Somme de mappage non correspondante");
      for(int ik=0;ik<ui.length;ik++)
      {
        ui[ik].setEtat(1);
        ui[ik].setNomTable(nomTable);
        ui[ik].updateToTableWithHisto(refUser,c);
        uti.setNomTable(nomTableControl);
        UnionIntraTable[] liefflc=(UnionIntraTable[])uti.rechercher(1,ui[ik].getId2(),c);
        if(liefflc.length==0)throw new Exception("le lien n existe pas");

          liefflc[0].setEtat(1);
          liefflc[0].setNomTable(nomTableControl);
          liefflc[0].updateToTableWithHisto(refUser,c);


      }
      
    }
    catch (Exception ex) {
      ex.printStackTrace();
     
      throw new Exception(ex.getMessage());
    }
  }
  public void validerMappageLCPrevRecControle(String nomTable, String idMere,String idPrev, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      c.setAutoCommit(false);
      UnionIntraTableUtil uti=new UnionIntraTableUtil();
      uti.setNomTable(nomTable);
      UnionIntraTable[] ui=(UnionIntraTable[])uti.rechercher(2,idMere,c);
      prevision.PrevisionRecette p=new prevision.PrevisionRecette();
      //System.out.println("idMere:"+idMere);
      p.setId(idPrev);
      prevision.PrevisionRecette[] ff = (prevision.PrevisionRecette[])CGenUtil.rechercher(p,null,null,c,"");
      if(ff.length==0)throw new Exception("Id prev non existante");
      double sommeFact=Utilitaire.arrondir(ff[0].getMontant(),2);
      //System.out.println(sommeFact);
      double sommeUnion=Utilitaire.arrondir(AdminGen.calculSommeDouble(ui,4),2);
      //System.out.println(sommeUnion);
      //if(sommeFact!=sommeUnion) throw new Exception("Somme de mappage non correspondante");
      for(int ik=0;ik<ui.length;ik++)
      {
        ui[ik].setEtat(1);
        ui[ik].setNomTable(nomTable);
        ui[ik].updateToTableWithHisto(refUser,c);
      }
      c.commit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally
    {
      if(c!=null) c.close();
    }
  }


  public void validerMappageLCPrevDepControle(String nomTable, String idMere, String refUser) throws Exception {
  Connection c=null;
  try {
    c=new utilitaire.UtilDB().GetConn();
    c.setAutoCommit(false);
    UnionIntraTableUtil uti=new UnionIntraTableUtil();
    uti.setNomTable(nomTable);
    UnionIntraTable[] ui=(UnionIntraTable[])uti.rechercher(2,idMere,c);
    prevision.PrevisionDepense p=new prevision.PrevisionDepense();
    p.setId(idMere);
    prevision.PrevisionDepense[] ff=(prevision.PrevisionDepense[])CGenUtil.rechercher(p,null,null,"");
    if(ff.length==0)throw new Exception("Id prev non existante");
    double sommeFact=Utilitaire.arrondir(ff[0].getMontant(),2);
    System.out.println(sommeFact);
    double sommeUnion=Utilitaire.arrondir(AdminGen.calculSommeDouble(ui,4),2);
    System.out.println(sommeUnion);
    if(sommeFact!=sommeUnion) throw new Exception("Somme de mappage non correspondante");
    for(int ik=0;ik<ui.length;ik++)
    {
      ui[ik].setEtat(1);
      ui[ik].setNomTable(nomTable);
      ui[ik].updateToTableWithHisto(refUser,c);
    }
    c.commit();
  }
  catch (Exception ex) {
    ex.printStackTrace();
    c.rollback();
    throw new Exception(ex.getMessage());
  }
  finally{
    if(c!=null) c.close();
  }
}



  public void validerMappageLCMOp(String nomTable, String idMere, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      c.setAutoCommit(false);
      UnionIntraTableUtil uti=new UnionIntraTableUtil();
      uti.setNomTable("opfflc");
      UnionIntraTable[] ui=(UnionIntraTable[])uti.rechercher(2,idMere,c);
      ded.OrdonnerPayement[] ff=(ded.OrdonnerPayement[])new ded.OpUtil().rechercher(1,idMere,c);
      if(ff.length==0)throw new Exception("Id mere non existante");
      double sommeFact=Utilitaire.arrondir(AdminGen.calculSommeDouble(ff,4),2);
      //System.out.println("Somme fact = "+sommeFact);
      double sommeUnion=Utilitaire.arrondir(AdminGen.calculSommeDouble(ui,4),2);
      //System.out.println("Somme union = "+sommeUnion);
      if(sommeFact!=sommeUnion) throw new Exception("Somme de mappage non correspondante");
      for(int ik=0;ik<ui.length;ik++)
      {
        uti.setNomTable("FACTUREFOURNISSEURLC");
        UnionIntraTable[] factLc=(UnionIntraTable[])uti.rechercher(1,ui[ik].getId2(),c);
        double sommeFactlc=AdminGen.calculSommeDouble(factLc,4);
        System.out.println("Le comme Fact Lc = "+sommeFactlc);
        uti.setNomTable("opVisefflc");
        UnionIntraTable[] dejaOpLc=(UnionIntraTable[])uti.rechercher(3,ui[ik].getId2(),c);
        double sommeOplc=AdminGen.calculSommeDouble(dejaOpLc,4);
        System.out.println("Le comme sommeOplc Lc = "+sommeOplc);
        if((sommeFactlc>0)&&(sommeOplc>sommeFactlc)) throw new Exception("Valeur op sup a somme mappage pour la liaison num  "+ik+" valeur " +ui[ik].getId2());
        if((sommeFactlc<0)&&(sommeOplc<sommeFactlc)) throw new Exception("Valeur op sup a somme mappage pour la liaison num  "+ik+" valeur " +ui[ik].getId2());
        ui[ik].setEtat(1);
        ui[ik].setNomTable("opfflc");
        ui[ik].updateToTableWithHisto(refUser,c);
      }
      c.commit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally
    {
      if(c!=null) c.close();
    }
  }
  public void validerMappageLCM(String nomTable, String[] idMappage, String refUser) throws Exception {
    for(int i=0;i<idMappage.length;i++)
      validerMappageLC(nomTable,idMappage[i],refUser);
  }
  public UnionIntraTable validerMappageLCMavecOp(String nomTable, String idMere, String idOp, String refUser) throws Exception {
    Connection c=null;
    UnionIntraTable vaovao=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      c.setAutoCommit(false);
      UnionIntraTableUtil uti=new UnionIntraTableUtil();
      uti.setNomTable(nomTable);
      UnionIntraTable[] ui=(UnionIntraTable[])uti.rechercher(2,idMere,c);
      FactureFournisseur[] ff=(FactureFournisseur[])new FactureFournisseurUtil().rechercher(1,idMere,c);
      if(ff.length==0)throw new Exception("Id mere non existante");
      //double sommeFact=AdminGen.calculSommeDouble(ff,5);
      //double sommeUnion=AdminGen.calculSommeDouble(ui,4);
      double sommeFact=Utilitaire.arrondir(AdminGen.calculSommeDouble(ff,5),2);
      double sommeUnion=Utilitaire.arrondir(AdminGen.calculSommeDouble(ui,4),2);
      if(sommeFact!=sommeUnion) throw new Exception("Somme de mappage non correspondante");
      for(int i=0;i<ui.length;i++)
      {
        validerMappageLC(nomTable,ui[i].getTuppleID(),c,refUser);
        vaovao=new UnionIntraTable("opFFlc","getseqOpffLc","OFL",idOp,ui[i].getTuppleID(),"mappage auto",String.valueOf(ui[i].getMontantMere()),"1");
        vaovao.insertToTableWithHisto(refUser,c);
      }
      c.commit();
      return vaovao;
    }
    catch (Exception ex) {
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public void validerMappageLC(String nomTable, String idMappage, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new utilitaire.UtilDB().GetConn();
      c.setAutoCommit(false);
      validerMappageLC(nomTable, idMappage,c, refUser);
      c.commit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
      c.rollback();
      throw new Exception(ex.getMessage());
    }
    finally
    {
      if(c!=null) c.close();
    }
  }

  public void validerMappageLC(String nomTable, String idMappage, Connection c, String refUser) throws Exception {
    try {
      UnionIntraTableUtil utu=new UnionIntraTableUtil();
      UnionIntraTable[] ut= utu.findUnionIntraTable(nomTable,idMappage,"%","%","%","","","%","");
      LigneCredit lc[]=null;
      LigneCreditUtil lu=new LigneCreditUtil();
      String refLC=ut[0].getId2();
      if(ut.length==0)
        throw new Exception("Le données n existe pas");
      ut[0].setNomTable(nomTable);
      if (nomTable.compareToIgnoreCase(utilitaire.Constante.getTableFactureFLC())==0)// si c'est une facture dépense
      {
        lu.setNomTable("LigneCredit");
        lc=(LigneCredit[])lu.rechercher(1,refLC);
        //if(lc[0].getDisponibleFact()<ut[0].getMontantMere()) throw new Exception("Ligne credit non siffisante");
        ut[0].setEtat(1);
        lc[0].setMontantFac(lc[0].getMontantFac()+ut[0].getMontantMere());
      }
      if (nomTable.compareToIgnoreCase(utilitaire.Constante.tableFactureCLC)==0)// si c'est une facture recette
      {
        lu.setNomTable("LigneCreditRecette");
        lc=(LigneCredit[])lu.rechercher(1,refLC);
        ut[0].setEtat(1);
        lc[0].setMontantFac(lc[0].getMontantFac()+ut[0].getMontantMere());
      }
      ut[0].updateToTableWithHisto(refUser,c);
      lc[0].updateToTableWithHisto(refUser,c);
    }
    catch (Exception ex) {
      c.rollback();
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
  }
  public void validerMappageOpFlc(String nomTable, String idMappage, Connection c, String refUser) throws Exception {
      try {
        UnionIntraTableUtil utu=new UnionIntraTableUtil();
        UnionIntraTable[] ut= utu.findUnionIntraTable(nomTable,idMappage,"%","%","%","","","%","");
        String refLC=ut[0].getId2();
        if(ut.length==0)
          throw new Exception("Le données n existe pas");
        ut[0].setNomTable(nomTable);
        ut[0].updateToTableWithHisto(refUser,c);
      }
      catch (Exception ex) {
        ex.printStackTrace();
        throw new Exception(ex.getMessage());
      }
  }
  public String mapperDepenseLC(String idSortie, String idLC, String rem, String montant, String refUser) throws Exception {
    return UtilitaireMetier.mapperMereToFille("depensesLC","getSeqDepLC","DLC",idSortie,idLC,rem,montant,refUser);
  }
  public String mapperRecettesLC(String idEntree, String idLC, String rem, String montant, String refUser) throws Exception {
    return UtilitaireMetier.mapperMereToFille("recettesLC","getseqRecLC","RLC",idEntree,idLC,rem,montant,refUser);
  }
  public String mapperFactureLC(String idFacture, String idLC, String rem, String montant, String refUser) throws Exception {
    return UtilitaireMetier.mapperMereToFille("factureLigneCredit","getSeqFactLigne","SFL",idFacture,idLC,rem,montant,refUser);
  }
  public String mapperOpFactureFournisseurLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser) throws Exception {
    Connection c=null;
    try {
      String retour="ok";
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      mapperOpFactureFournisseurLCTableau(idOp, idLC, rem, montant, refUser, c);
      c.commit();
      return retour ;
    }
    catch (SQLException ex) {
      c.rollback();
      throw new Exception();
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public String mapperOpFactureFournisseurLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser,Connection c) throws Exception {

    try {
      String retour="ok";
      OrdonnerPayement[] op=(OrdonnerPayement[])new OpUtil().rechercher(1,idOp,c);
      if(op.length==0)throw new Exception("op non existante");
      FactureFournisseur[] ff=(FactureFournisseur[])new FactureFournisseurUtil().rechercher(1,op[0].getDed_Id(),c);
      if(ff.length==0)throw new Exception("Facture non existante");
      for (int i =0;i<idLC.length;i++)
      {
        String ref = UtilitaireMetier.mapperMereToFille("FACTUREFOURNISSEURLC","getSeqFactLigneF","SFF",ff[0].getTuppleID(),idLC[i],rem,montant[i],refUser,"0",c);
        retour = UtilitaireMetier.mapperMereToFille("opFFlc","getSeqOpFFlc","OFL",idOp,ref,rem,montant[i],refUser,"0",c);
      }
      return retour ;
    }
    catch (SQLException ex) {
      throw new Exception(ex.getMessage());
    }
  }
  public String mapperOrFactureClientLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser) throws Exception {
    Connection c=null;
    try {
      String retour="ok";
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      mapperOrFactureClientLCTableau(idOp, idLC, rem, montant, refUser, c);
      c.commit();
      return retour ;
    }
    catch (SQLException ex) {
      c.rollback();
      throw new Exception();
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public String mapperOrFactureClientLCTableau(String idOp, String[] idLC, String rem, String[] montant, String refUser, Connection c) throws Exception {
    try {
      String retour="ok";
      OpUtil o =new OpUtil();
      o.setNomTable("OrdonnerRecette");
        System.out.println("idOp = " + idOp);
      OrdonnerPayement[] op = (OrdonnerPayement[])o.rechercher(1,idOp,c);
      if(op.length==0)throw new Exception("or non existante");
      FactureFournisseurUtil  ffu = new FactureFournisseurUtil();
      ffu.setNomTable("FactureClient");
        System.out.println("op[0].getDed_Id() = " + op[0].getDed_Id());
      FactureFournisseur[] ff=(FactureFournisseur[])ffu.rechercher(1,op[0].getDed_Id(), c);
      if(ff.length==0)throw new Exception("Facture non existante");
      for (int i =0;i<idLC.length;i++)
      {
        System.out.println("miditra impiry = " + i);
        String ref=UtilitaireMetier.mapperMereToFille("FACTURECLIENTLC","getSeqFactureClientLc","SFC",ff[0].getIdFactureFournisseur(),idLC[i],rem,montant[i],refUser,"0",c);
        retour=UtilitaireMetier.mapperMereToFille("orFClc","getSeqOrFlc","ORF",idOp,ref,rem,montant[i],refUser,"0",c);
      }
      return retour ;
    }
    catch (SQLException ex) {
      c.rollback();
      throw new Exception();
    }
  }
  public String mapperOrFactureClientLCTableauDupliquer(String idOp, String[] idLC, String rem, String[] montant, String refUser, Connection c) throws Exception {
    try {
      String retour="ok";
      FactureFournisseur  ffu = new FactureFournisseur();
      ffu.setNomTable("FactureClient");
      ffu.setNumFact(idOp);
      FactureFournisseur[] ff=(FactureFournisseur[])CGenUtil.rechercher(ffu, null, null, c, "");
      if(ff.length==0)throw new Exception("Facture non existante");
      for (int i =0;i<idLC.length;i++)
      {
        String ref=UtilitaireMetier.mapperMereToFille("FACTURECLIENTLC","getSeqFactureClientLc","SFC",ff[0].getIdFactureFournisseur(),idLC[i],rem,montant[i],refUser,"0",c);
        retour=UtilitaireMetier.mapperMereToFille("orFClc","getSeqOrFlc","ORF",idOp,ref,rem,montant[i],refUser,"0",c);
      }
      return retour ;
    }
    catch (SQLException ex) {
      c.rollback();
      throw new Exception();
    }
  }
  public String mapperPrevisionRecetteLCTableau(String idPrev, String[] idLC, String rem, String[] montant, String refUser) throws Exception {
    Connection c=null;
    try {
      String retour="ok";
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      PrevisionRecette o =new PrevisionRecette();
      o.setNomTable("PrevisionRecette");
      o.setId(idPrev);
      PrevisionRecette[] op=(PrevisionRecette[])CGenUtil.rechercher(o,null,null,"");
      if(op.length==0)throw new Exception("prevision non existante");
      for (int i =0;i<idLC.length;i++)
      {
        String ref=UtilitaireMetier.mapperMereToFille("PREVRECETTELC","getSeqPrevisionRecetteLc","SPRL",idPrev,idLC[i],rem,montant[i],refUser,"0",c);
      }
      c.commit();
      return retour ;
    }
    catch (SQLException ex) {
      c.rollback();
      throw new Exception();
    }
    finally{
      if(c!=null)c.close();
    }
  }

  public String mapperPrevisionDepenseLCTableau(String idPrev, String[] idLC, String rem, String[] montant, String refUser) throws Exception {
  Connection c=null;
  try {
    String retour="ok";
    c=new UtilDB().GetConn();
    c.setAutoCommit(false);
    PrevisionDepense o = new PrevisionDepense();
    o.setNomTable("PrevisionDepense");
    o.setId(idPrev);
    PrevisionDepense[] op=(PrevisionDepense[])CGenUtil.rechercher(o,null,null,"");
    if(op.length==0)throw new Exception("prevision non existante");
    for (int i =0;i<idLC.length;i++)
    {
      String ref=UtilitaireMetier.mapperMereToFille("PREVDEPENSELC","getSeqPrevisionDepenseLc","SPDL",idPrev,idLC[i],rem,montant[i],refUser,"0",c);
    }
    c.commit();
    return retour ;
  }
  catch (SQLException ex) {
    c.rollback();
    throw new Exception();
  }
  finally{
    if(c!=null)c.close();
  }
  }



  public String mapperFactureFournisseurLCTableau(String idFacture, String[] idLC, String rem, String[] montant, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      FactureFournisseur[] ff=(FactureFournisseur[])new FactureFournisseurUtil().rechercher(1,idFacture,c);
      if(ff.length==0)throw new Exception("Id mere non existante");
      if((ff[0].getRemarque()!=null)&&(ff[0].getRemarque().compareToIgnoreCase("opAuto")==0))  throw new Exception("Veuillez ajouter a partir OP");
      for (int i =0;i<idLC.length;i++) //mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU,String etat, Connection c)
        UtilitaireMetier.mapperMereToFille("FACTUREFOURNISSEURLC","getSeqFactLigneF","SFF",idFacture,idLC[i],rem,montant[i],refUser,"0",c);
      c.commit();
      return "ok" ;
    }
    catch (SQLException ex) {
      c.rollback();
      throw new Exception();
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public String mapperFactureClientLCTableau(String idFacture, String[] idLC, String rem, String[] montant, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);

      for (int i =0;i<idLC.length;i++) //mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU,String etat, Connection c)
        UtilitaireMetier.mapperMereToFille("FACTURECLIENTLC","getSeqFactureClientLc","SFC",idFacture,idLC[i],rem,montant[i],refUser,"0",c);
      c.commit();
      return "ok" ;
    }
    catch (SQLException ex) {
      c.rollback();
      throw new Exception();
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public String mapperFactureFournisseurLC(String idFacture, String idLC, String rem, String montant, String refUser) throws Exception {
      //for (int i =0;i<idLC.length;i++) //mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU,String etat, Connection c)
    UtilitaireMetier.mapperMereToFille("FACTUREFOURNISSEURLC","getSeqFactLigneF","SFF",idFacture,idLC,rem,montant,refUser);
      return "ok" ;
  }
  public String mapperFactureClientLC(String idFacture, String idLC, String rem, String montant, String refUser) throws Exception {
      //for (int i =0;i<idLC.length;i++) //mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU,String etat, Connection c)
        UtilitaireMetier.mapperMereToFille("FACTURECLIENTLC","getSeqFactureClientLc","SFC",idFacture,idLC,rem,montant,refUser);
      return "ok" ;
  }
  public boolean deleteUnionIntraTable(String nomtable, String id, String refU) throws Exception {
      UnionIntraTableUtil uti=new UnionIntraTableUtil();
      uti.setNomTable(nomtable);
      UnionIntraTable ui=(UnionIntraTable)uti.rechercher(1,id)[0];
      if(ui.estIlModifiable()==false) throw new Exception("Mappage deja valide");
      ui.setNomTable(nomtable);
      ui.deleteToTableWithHisto(refU);
    return true;
  }
  public boolean deleteUnionIntraTableLcOp(String nomtable, String nomTable2, String id, String refU) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      UnionIntraTableUtil uti=new UnionIntraTableUtil();
      uti.setNomTable(nomtable);
      UnionIntraTable ui=(UnionIntraTable)uti.rechercher(1,id,c)[0];
      if(ui.estIlModifiable()==false) throw new Exception("Mappage deja valide");
      ui.setNomTable(nomtable);
      ui.deleteToTableWithHisto(refU,c);
      uti.setNomTable(nomTable2);
      UnionIntraTable ui2=(UnionIntraTable)uti.rechercher(1,ui.getId2(),c)[0];
      if(ui2.estIlModifiable()==true)
      {
        ui2.setNomTable(nomTable2);
        ui2.deleteToTableWithHisto(refU,c);
      }
      return true;
    }
    catch (Exception ex) {
      c.rollback();
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
    finally{
    if(c!=null)c.close();
    }
  }
  public String updateMontantUnionIntra(String nomTable, String id1, String[] id2, String[] montant, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      for (int i =0;i<id2.length;i++) //mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU,String etat, Connection c)
      {
        UnionIntraTable.updateMontantMere(nomTable,id1,id2[i],montant[i],c);
      }
      c.commit();
      return "ok" ;
    }
    catch (SQLException ex) {
      c.rollback();
      ex.printStackTrace();
      throw new Exception();
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public String updateMontantUnionIntraLcOp(String nomTable, String nomTable2, String id1, String[] id2, String[] montant, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      for (int i =0;i<id2.length;i++) //mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU,String etat, Connection c)
      {
        UnionIntraTable.updateMontantMere(nomTable,id1,id2[i],montant[i],c);
        UnionIntraTableUtil uiti=new UnionIntraTableUtil();
        uiti.setNomTable(nomTable2);
        UnionIntraTable[] liefflc=(UnionIntraTable[])uiti.rechercher(1,id2[i],c);
        if(liefflc.length==0)throw new Exception("le lien n existe pas");
        if(liefflc[0].estIlModifiable()==true)
        {
          //System.out.println(" string montant mere ================ " + montant[i]);
          liefflc[0].setMontantMere(Double.parseDouble(montant[i]));
          liefflc[0].setNomTable(nomTable2);
          liefflc[0].updateToTableWithHisto(refUser,c);
        }
      }
      c.commit();
      return "ok" ;
    }
    catch (SQLException ex) {
      ex.printStackTrace();
      c.rollback();
      throw new Exception();
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public String updateMontantUnionIntraLcOp(String nomTable, String nomTable2, String id1, String[] id2, String[] montant, String refUser,Connection c) throws Exception {
    
    try {
      
      for (int i =0;i<id2.length;i++) //mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU,String etat, Connection c)
      {
        UnionIntraTable.updateMontantMere(nomTable,id1,id2[i],montant[i],c);
        UnionIntraTableUtil uiti=new UnionIntraTableUtil();
        uiti.setNomTable(nomTable2);
        UnionIntraTable[] liefflc=(UnionIntraTable[])uiti.rechercher(1,id2[i],c);
        if(liefflc.length==0)throw new Exception("le lien n existe pas");
        if(liefflc[0].estIlModifiable()==true)
        {
          //System.out.println(" string montant mere ================ " + montant[i]);
          liefflc[0].setMontantMere(Double.parseDouble(montant[i]));
          liefflc[0].setNomTable(nomTable2);
          liefflc[0].updateToTableWithHisto(refUser,c);
        }
      }
      return "ok" ;
    }
    catch (SQLException ex) {
      ex.printStackTrace();
      throw new Exception();
    }
    
  }
  public String updateMontantUnionIntraLcPrev(String nomTable, String id1, String[] id2, String[] montant, String refUser) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      for (int i =0;i<id2.length;i++) //mapperMereToFille(String nomtableMappage, String nomFonctMap, String suffixeMap, String idMere, String idFille, String rem, String montant, String refU,String etat, Connection c)
      {
        UnionIntraTable.updateMontantMerePrev(nomTable,id1,id2[i],montant[i],c);
      }
      c.commit();
      return "ok" ;
    }
    catch (SQLException ex) {
      ex.printStackTrace();
      c.rollback();
      throw new Exception();
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public String copierLcDetail(String idDepart, String idArrivee, String refUser) throws Exception {
    Connection c=new utilitaire.UtilDB().GetConn();
    c.setAutoCommit(true);
    copierLcDetail(idDepart,idArrivee,c,refUser);
    c.close();
    return "ok";
  }
  public String copierLcDetail(String idDepart, String idArrivee, Connection c, String refUser) throws Exception {
    LcDetail[]liste=(LcDetail[])new LcDetailUtil().rechercher(2,idDepart);
    for(int i=0;i<liste.length;i++)
    {
      liste[i].setId(liste[i].makePK());
      liste[i].insertToTableWithHisto(refUser,c);
    }
    return "ok";
  }
public String copierLCAvecDetail(String mois, String annee, String mois0, String annee0, String nomTable, String refUser) throws Exception {
Connection c=null;
  try {
      int[] a = { 12,13 };
      String[] vall = {mois,annee};
      LigneCreditUtil lu=new LigneCreditUtil();
      lu.setNomTable(nomTable);
      LigneCredit[] lc = (LigneCredit[])lu.rechercher(a,vall, "");
      int nbCopie=lc.length ;
      c=new utilitaire.UtilDB().GetConn();
      c.setAutoCommit(false);
      for(int i=0;i<lc.length;i++)
      {
        lc[i].setAnnee(Utilitaire.stringToInt(annee0));
        lc[i].setMois(mois0);
        String idTaloha=lc[i].getIdLigne();
        lc[i].setIdLigne(lc[i].makePK());
        /*if(lc[i].getParution().compareToIgnoreCase("0")!=0)
        {
          int temp=Utilitaire.stringToInt(lc[i].getParution())+nbCopie;
          lc[i].setParution(String.valueOf(temp));
        }*/
        lc[i].insertToTableWithHisto(refUser);
        this.copierLcDetail(idTaloha,lc[i].getIdLigne(),c,refUser);
      }
      c.commit();
      return "ok";
  }
  catch (Exception ex) {
    c.rollback();
    return null;
  }
  finally
  {
    if(c!=null) c.close();
  }
}
public String copierLCRecette(String mois, String annee, String mois0, int annee0, String refUser) throws Exception {
  Connection c=null;
  try {
    c=new UtilDB().GetConn();
    c.setAutoCommit(false);
    int[] a = { 12,13 };
    String[] vall = {mois,annee};
    LigneCreditUtil lu=new LigneCreditUtil();
    lu.setNomTable("LigneCreditRecette");
    LigneCredit[] lc = (LigneCredit[])lu.rechercher(a,vall, "",c);
    int nbCopie=lc.length ;
    for(int i=0;i<lc.length;i++)
    {
      lc[i].setAnnee(annee0);
      lc[i].setMois(mois0);
      lc[i].setIndicePk("LCR");
      lc[i].setNomProcedureSequence("getSeqLCRecette");
      lc[i].setIdLigne(lc[i].makePK());
      if(lc[i].getParution().compareToIgnoreCase("0")!=0)
      {
        int temp=Utilitaire.stringToInt(lc[i].getParution())+nbCopie;
        lc[i].setParution(String.valueOf(temp));
      }
      lc[i].setNomTable("LigneCreditRecette");
      lc[i].insertToTableWithHisto(refUser,c);
    }
    c.commit();
    return String.valueOf(lc.length);
  } catch (Exception ex) {
    c.rollback();
    ex.printStackTrace();
    throw new Exception(ex.getMessage());
  }
  finally
  {
    if(c!=null)c.close();
  }
  }

  public String copierLC(String mois, String annee, String mois0, int annee0, String nomTable, String refUser) throws Exception {
    Connection c=null;
    try {
    c=new UtilDB().GetConn();
    c.setAutoCommit(false);
    int[] a = { 12,13 };
      String[] vall = {mois,annee};
      LigneCreditUtil lu=new LigneCreditUtil();
      lu.setNomTable(nomTable);
      LigneCredit[] lc = (LigneCredit[])lu.rechercher(a,vall, "",c);
      int nbCopie=lc.length ;
      for(int i=0;i<lc.length;i++)
      {
        lc[i].setAnnee(annee0);
        lc[i].setMois(mois0);
        lc[i].setIndicePk("LC");
        lc[i].setNomProcedureSequence("GETSEQLIGNECREDIT");
        lc[i].setIdLigne(lc[i].makePK());
        if(lc[i].getParution().compareToIgnoreCase("0")!=0)
        {
          int temp=Utilitaire.stringToInt(lc[i].getParution())+nbCopie;
          lc[i].setParution(String.valueOf(temp));
        }
        lc[i].insertToTableWithHisto(refUser,c);
      }
      c.commit();
      return String.valueOf(lc.length);
    } catch (Exception ex) {
      c.rollback();
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public String updateLC(String idLigne, String designation, String creditIni, String creditMod, String typeLigne, String numCompte, String entite, String dir, String mois, String annee, String nomTable, String refUser) throws Exception {
    try {
      LigneCreditUtil lu=new LigneCreditUtil();
      lu.setNomTable(nomTable);
      LigneCredit[] lc = (LigneCredit[])lu.rechercher(1,idLigne);
      if(lc.length==0) throw new Exception("LigneCredit correspondant non trouvé");
      lc[0].setDesignation(designation);
      lc[0].setCreditInitial(utilitaire.Utilitaire.stringToDouble(creditIni));
      lc[0].setCreditModifier(utilitaire.Utilitaire.stringToDouble(creditMod));
      lc[0].setIdTypeLigne(typeLigne);
      lc[0].setNumCompte(numCompte);
      lc[0].setIdEntite(entite);
      lc[0].setIdDirection(dir);
      lc[0].setMois(mois);
      lc[0].setAnnee(utilitaire.Utilitaire.stringToInt(annee));
      lc[0].updateToTableWithHisto(refUser);
      return lc[0].getTuppleID();
    }
    catch (Exception ex) {
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
  }
public String copierLCRecette(String mois, String annee, String mois0, int annee0, String nomTable, String refUser) throws Exception {

    try {

      int[] a = { 12,13 };
      String[] vall = {mois,annee};
      LigneCreditUtil lu=new LigneCreditUtil();
      lu.setNomTable(nomTable);
      LigneCredit[] lc = (LigneCredit[])lu.rechercher(a,vall, "");
      int nbCopie=lc.length ;
      for(int i=0;i<lc.length;i++)
      {
        lc[i].setAnnee(annee0);
        lc[i].setMois(mois0);
        lc[i].setIndicePk("LCR");
        lc[i].setNomProcedureSequence("GETSEQLCRECETTE");
        lc[i].setIdLigne(lc[i].makePK());
        if(lc[i].getParution().compareToIgnoreCase("0")!=0)
        {
          int temp=Utilitaire.stringToInt(lc[i].getParution())+nbCopie;
          lc[i].setParution(String.valueOf(temp));
        }
        lc[i].setNomTable(nomTable);
        lc[i].insertToTableWithHisto(refUser);
      }
      return String.valueOf(lc.length);
    } catch (Exception ex) {
      ex.printStackTrace();
      throw new Exception(ex.getMessage());
    }
  }
  public String verifLCPrev(String idprev,String refUser)throws Exception{
   Connection c=null;
    try{
       c=new UtilDB().GetConn();
       c.setAutoCommit(false);
       PrevdejaOP p = new PrevdejaOP();
       p.setNomTable("PREVISIONRECDEJAOP");
       p.setIdprev(idprev);
       PrevdejaOP[] lp = (PrevdejaOP[])CGenUtil.rechercher(p,null,null,"");
       UnionIntraTable uil = new UnionIntraTable();
       uil.setNomTable("PREVRECETTELC");
       uil.setId1(idprev);
       UnionIntraTable[] luil = (UnionIntraTable[])CGenUtil.rechercher(uil,null,null,"");
       if(luil.length==0){
       if(lp.length!=0){
         UnionIntraTable ui = new UnionIntraTable();
         ui.setNomTable("ORFCLC");
         ui.setId1(lp[0].getIdop());
         UnionIntraTable[] lui = (UnionIntraTable[])CGenUtil.rechercher(ui,null,null,"");
         UnionIntraTable uii = new UnionIntraTable();
         uii.setNomTable("FACTURECLIENTLC");
         uii.setId(lui[0].getId2());
         UnionIntraTable[] lui2 = (UnionIntraTable[])CGenUtil.rechercher(uii,null,null,"");
         for(int i=0;i<lui2.length;i++){
           UnionIntraTable uit = new UnionIntraTable("PREVRECETTELC","getSeqPrevisionRecetteLc","SPRL",idprev,lui2[i].getId2(),"--",""+lui2[i].getMontantMere(),"0");
           uit.insertToTableWithHisto(refUser,c);
         }
       }
       c.commit();
       }
       return "ok";
    }
    catch( Exception ex){
     c.rollback();
      ex.printStackTrace();
      throw ex;
    }
    finally
    {
      if(c!=null)c.close();
    }
 }

 public double[][] calculResultat(LigneCreditNature[] lc) throws Exception{
	double[][] result = new double[5][3];

	double[] resultats = new double[5];
	double[] resultE = new double[3];

	resultats[0] =0 ; resultats[1] =0 ; resultats[2] =0 ; resultats[3] =0 ; resultats[4] =0 ;
	resultE[0] = 0; resultE[1] = 0; resultE[2] = 0;

	for (int iterator =0; iterator<lc.length; iterator++){
		if (lc[iterator].getNature().startsWith("Fonctionnement")){
			resultats[0] += lc[iterator].getMontantFac();
			resultE[1] += lc[iterator].getMontantEng();
		}
		else if (lc[iterator].getNature().startsWith("Investissement")){
			resultats[1] += lc[iterator].getMontantFac();
			resultE[1] += lc[iterator].getMontantEng();
		}
		else if (lc[iterator].getNature().startsWith("Recette")){
			resultats[2] += lc[iterator].getMontantFac();
			resultE[0] += lc[iterator].getMontantEng();
		}
		else if (lc[iterator].getNature().startsWith("Autre")){
			resultats[3] += lc[iterator].getMontantFac();
			resultE[0] += lc[iterator].getMontantEng();
		}
	}
	resultats[4] = resultats[2] - resultats[0];
	//etat de tresorerie : avant + recette - depense
	resultE[2] += resultE[0] - resultE[1];
	result[4] = resultE;

	double[] resultA = new double[3];
	resultA[0] = resultats[2] + resultats[3];
	resultA[1] = resultats[0] + resultats[1];
	resultA[2] = resultA[0] - resultA[1];
	result[0] = resultA;

	double[] resultB = new double[3];
	resultB[0] = resultats[2];
	resultB[1] = resultats[0];
	resultB[2] = resultats[4];
	result[1] = resultB;

	double[] resultC = new double[3];
	resultC[0] = resultats[2];
	resultC[1] = resultats[3];
	resultC[2] = resultA[0];
	result[2] = resultC;

	double[] resultD = new double[3];
	resultD[0] = resultats[0];
	resultD[1] = resultats[1];
	resultD[2] = resultA[1];
	result[3] = resultD;

	return result;
 }
	public double[][] calculResultatRD(LigneCreditNature[] lc) throws Exception{
		double[][] result = new double[2][5];

		result[0][0] =0.0F; ; result[0][1] =0.0F; ; result[0][2] =0.0F; ; result[0][3] =0.0F; ; result[0][4] =0.0F; ;
		result[1][0] =0.0F; ; result[1][1] =0.0F; ; result[1][2] =0.0F; ; result[1][3] =0.0F; ; result[1][4] =0.0F; ;

		for (int iterator =0; iterator<lc.length; iterator++){
			if (lc[iterator].getNature().startsWith("Fonctionnement") || lc[iterator].getNature().startsWith("Investissement")){
				result[1][0] += (double)lc[iterator].getCreditInitial();
				result[1][1] += (double)lc[iterator].getMontantEng();
				result[1][2] += (double)lc[iterator].getMontantFac();
				result[1][3] += (double)(lc[iterator].getCreditInitial() - lc[iterator].getMontantFac());
				result[1][4] += (double)(lc[iterator].getMontantFac() - lc[iterator].getMontantEng());
			}
			else if (lc[iterator].getNature().startsWith("Recette") || lc[iterator].getNature().startsWith("Autre")){
				result[0][0] += (double)lc[iterator].getCreditInitial();
				result[0][1] += (double)lc[iterator].getMontantEng();
				result[0][2] += (double)lc[iterator].getMontantFac();
				result[0][3] += (double)(lc[iterator].getCreditInitial() - lc[iterator].getMontantFac());
				result[0][4] += (double)(lc[iterator].getMontantFac() - lc[iterator].getMontantEng());
			}
		}

		return result;
	}

	public void dupliquerLC(String numObjet,String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] remarque, String nomtable, String refUser) throws Exception{
		Connection c=null;
		try {
			c=new UtilDB().GetConn();
			c.setAutoCommit(false);
			LigneCredit lc = new LigneCredit();
			lc.setNomTable(nomtable);
			lc.setIdLigne(numObjet);
			LigneCredit[] lcs = (LigneCredit[]) CGenUtil.rechercher(lc,null,null,"");
			if (lcs.length ==0) throw new Exception("Ligne de credit inexistant");
			for (int iterator =0; iterator<n_dupl; iterator++){
				if (nomtable.compareTo("LigneCreditRecette")==0){
					LigneCredit lctest=new LigneCredit();
					lctest.LigneCreditRecette (remarque[iterator], Utilitaire.stringToDouble(montantTab[iterator]), lcs[0].getIdTypeLigne(), lcs[0].getNumCompte(),
						lcs[0].getIdEntite(), lcs[0].getIdDirection(), lmois[iterator], Integer.valueOf(lannee[iterator]).intValue());
					LigneCredit[] listeT = (LigneCredit[]) CGenUtil.rechercher(lctest,null,null,"");
					if (listeT.length > 0) throw new Exception("LC existe deja / mois : "+lmois[iterator]+ " "+lannee[iterator]);
					createLCRecette(remarque[iterator], montantTab[iterator], lcs[0].getIdTypeLigne(), lcs[0].getNumCompte(),
					lcs[0].getIdEntite(), lcs[0].getIdDirection(), lmois[iterator], lannee[iterator], "", refUser, c);

				}
				else {
					LigneCredit lctest = new LigneCredit(remarque[iterator], Utilitaire.stringToDouble(montantTab[iterator]), lcs[0].getIdTypeLigne(), lcs[0].getNumCompte(), lcs[0].getIdEntite(), lcs[0].getIdDirection(), lmois[iterator], Integer.valueOf(lannee[iterator]).intValue());
					LigneCredit[] listeT = (LigneCredit[]) CGenUtil.rechercher(lctest,null,null,"");
					if (listeT.length > 0) throw new Exception("LC existe deja / mois : "+lmois[iterator]+ " "+lannee[iterator]);
					createLC(remarque[iterator], Utilitaire.stringToDouble(montantTab[iterator]), lcs[0].getIdTypeLigne(), lcs[0].getNumCompte(), lcs[0].getIdEntite(), lcs[0].getIdDirection(), lmois[iterator], Integer.valueOf(lannee[iterator]).intValue(), "", nomtable, refUser, c);
				}
			}
			//parution????
			c.commit();
		} catch (Exception ex) {
			c.rollback();
			ex.printStackTrace();
			throw new Exception(ex.getMessage());
		}
		finally{
			if(c!=null)c.close();
		}
	}
	public void dupliquerLCMultiple(String[] ids,String[] montantTab, int n_dupl, String[] lmois, String[] lannee, String[] remarque, String nomtable, String refUser) throws Exception{
		Connection c=null;
		try {
			c=new UtilDB().GetConn();
			c.setAutoCommit(false);
			if (nomtable.compareTo("LIGNECREDITRECETTECOMPLET")==0){
				for (int iterator =0; iterator<n_dupl; iterator++){
					LigneCredit lc = new LigneCredit();
					lc.setNomTable("LigneCreditRecette");
					lc.setIdLigne(ids[iterator]);
					LigneCredit[] lcs = (LigneCredit[]) CGenUtil.rechercher(lc,null,null,c,"");

					if (lcs.length ==0) throw new Exception("Ligne de credit inexistant");
					LigneCredit lctest=lcs[0].cloneLC();
                    lctest.setMois(lmois[iterator]);
					LigneCredit[] listeT = (LigneCredit[]) CGenUtil.rechercher(lctest,null,null,c," and annee="+lannee[iterator]);

					if (listeT.length > 0) throw new Exception("LC existe deja / mois : "+lmois[iterator]+ " "+lannee[iterator]);
					createLCRecette(remarque[iterator], montantTab[iterator], lcs[0].getIdTypeLigne(), lcs[0].getNumCompte(),
					lcs[0].getIdEntite(), lcs[0].getIdDirection(), lmois[iterator], lannee[iterator], "", refUser, c);
				}
			}
			else{
				for (int iterator =0; iterator<n_dupl; iterator++){
					LigneCredit lc = new LigneCredit();
					lc.setNomTable("LIGNECREDIT");
					lc.setIdLigne(ids[iterator]);
					LigneCredit[] lcs = (LigneCredit[]) CGenUtil.rechercher(lc,null,null, c, "");

					if (lcs.length ==0) throw new Exception("Ligne de credit inexistant");
					LigneCredit lctest = lcs[0].cloneLC();
                    lctest.setMois(lmois[iterator]);					
					LigneCredit[] listeT = (LigneCredit[]) CGenUtil.rechercher(lctest,null,null,c, " and annee="+lannee[iterator]);

					if (listeT.length > 0) throw new Exception("LC existe deja / mois : "+lmois[iterator]+ " "+lannee[iterator]+" - "+listeT[0].getIdLigne());
					createLC(remarque[iterator], Utilitaire.stringToDouble(montantTab[iterator]), lcs[0].getIdTypeLigne(),
                                            lcs[0].getNumCompte(), lcs[0].getIdEntite(), lcs[0].getIdDirection(), lmois[iterator], Integer.valueOf(lannee[iterator]).intValue(),
                                            "", "LigneCredit", refUser, c);
				}
			}

			//parution????
			c.commit();
		} catch (Exception ex) {
			c.rollback();
			ex.printStackTrace();
			throw new Exception(ex.getMessage());
		}
		finally{
			if(c!=null)c.close();
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
