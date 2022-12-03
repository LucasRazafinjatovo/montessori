package facturefournisseur;

import javax.ejb.*;
import java.sql.*;
import utilitaire.*;
import historique.*;
import bean.*;
import comptabilite.ComptabiliteEjbClient;
import facturefournisseur.*;
import ded.VisaUtil;
import ded.Visa;
import ded.OrdonnerPayement;
import java.rmi.RemoteException;

@Stateful
@AccessTimeout(0)
public class GestionFactureFournisseurBean implements GestionFactureFournisseur, GestionFactureFournisseurRemote, SessionBean {
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
  public String createDetail(String nomTable, String idMere, String designation, String qte, String puHT, String rem, String refU) throws Exception {
    Detail d = new Detail(nomTable, idMere,designation,qte,puHT,rem);
    d.insertToTableWithHisto(refU);
    return d.getId();
  }
  public String updateDetail(String nomTable, String id, String designation, String qte, String puHT, String rem, String refU) throws Exception {
    Detail[] d = findDetail(nomTable,id,"%","%","%","%","%","%","%");
    if(d.length>0)
      d[0].setDesignation(designation);
      d[0].setQte(utilitaire.Utilitaire.stringToDouble(qte));
      d[0].setPuHT(utilitaire.Utilitaire.stringToDouble(puHT));
      d[0].setRemarque(rem);
      d[0].updateToTableWithHisto(refU);
    return d[0].getId();
  }
  public Detail[] findDetail(String nomTable, String id, String idMere, String designation, String qte1, String qte2, String puHT1, String puHT2, String rem) throws Exception {
     int []a={1,2,3,6};
     String []val={id,idMere,designation,rem};
     int[]aInt={4,5};
     String[]valInt={qte1,qte2,puHT1,puHT2};
     DetailUtil du=new DetailUtil();
     CaractTable ct=(CaractTable)new bean.CaractTableUtil().rechercher(2,nomTable)[0];
     du.setNomTable(ct.getNomFille());
     return (Detail[])du.rechercher(a,val,"",aInt,valInt);

 }
 public FactureFournisseur annulerFact(String nomTable, String nomTableLiaison, String id, String user) throws Exception {
   Connection c=null;
   try {
     c=new UtilDB().GetConn();
     c.setAutoCommit(false);
     FactureFournisseur crt=new FactureFournisseur();
     crt.setNomTable(nomTable);
     crt.setIdFactureFournisseur(id);
     crt=((FactureFournisseur[])CGenUtil.rechercher(crt,null,null,c,""))[0];
     if(nomTable.compareToIgnoreCase("FACTUREFOURNISSEUR")==0)
     {
        if(crt.estAnnulable(c)==false) throw new Exception("Facture Fact non annulable");
     }
     else
     {
       if(crt.estAnnulableClient(c)==false) throw new Exception("Facture Client non annulable");
     }
     crt.setMontantTTC(0);
     crt.setIdTVA(0);
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
   }
   catch (Exception ex) {
     c.rollback();
     throw new Exception(ex.getMessage());
   }
   finally{
     if(c!=null)c.close();
   }
   return null;
 }
public FactureFournisseur createOpSimple(String daty, String montant, String idTva, String idFrns, String idDevise, String rem, String refU) throws Exception {
  Connection c=null;
 try {
   c=new UtilDB().GetConn();
    c.setAutoCommit(false);
    OrdonnerPayement op=new OrdonnerPayement("","",daty,montant,rem,"0");
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
  //public FactureFournisseur createOpSimpleLc(String daty, String montant, String idTva, String idFrns, String idDevise, String rem,
  public String createEntiteFact(String nomT, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String idDevise, String refUser) throws Exception {
    FactureFournisseur ff = new FactureFournisseur(nomT,numFact,designation,date, datee, frns, tva, mTTC,rmq, idDevise);
    int ret=ff.insertToTableWithHisto(refUser);
    return ff.getIdFactureFournisseur();
  }

  /**
   *
   * @param nomT
   * @param numFact
   * @param designation
   * @param date
   * @param frns
   * @param tva
   * @param mTTC
   * @param rmq
   * @param datee
   * @param datyEcheance
   * @param idDevise
   * @param refUser
   * @return
   * @throws Exception
   */
  
  public String modifEntiteFactFseur(String idFct, String nomT, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String datyEcheance, String idDevise, String refUser) throws Exception {
    FactureFournisseur ff = new FactureFournisseur(nomT,numFact,designation,date, datee, frns, tva, mTTC,rmq, idDevise);
    ff.setIdFactureFournisseur(idFct);
    
    if(String.valueOf(datyEcheance).compareTo("") == 0 || datyEcheance == null)
       ff.setDatyecheance(Utilitaire.dateDuJourSql());
     else
       ff.setDatyecheance(Utilitaire.string_date("dd/MM/yyyy", datyEcheance));
    int ret=ff.updateToTableWithHisto(refUser);
    return ff.getIdFactureFournisseur();
  }
  
  public String createEntiteFactFseur(String nomT, String numFact, String designation, String date, String frns, String tva, String mTTC, String rmq, String datee, String datyEcheance, String idDevise, String refUser) throws Exception {
    FactureFournisseur ff = new FactureFournisseur(nomT,numFact,designation,date, datee, frns, tva, mTTC,rmq, idDevise);
    if(String.valueOf(datyEcheance).compareTo("") == 0 || datyEcheance == null)
       ff.setDatyecheance(Utilitaire.dateDuJourSql());
     else
       ff.setDatyecheance(Utilitaire.string_date("dd/MM/yyyy", datyEcheance));
    int ret=ff.insertToTableWithHisto(refUser);
    return ff.getIdFactureFournisseur();
  }

	public java.lang.String creerFactureFournisseur(String numFact, String designation, String dE, String dR, String idFrns, String idTVA, String mTTC, String rmq, String idDevise) throws Exception {
		Connection con=null;
		int d=0;
		FactureFournisseur ff = new FactureFournisseur("FACTUREFOURNISSEUR",numFact,designation,dE, dR, idFrns, idTVA, mTTC,rmq, idDevise);

		try{
			con = (new UtilDB()).GetConn();
			con.setAutoCommit(false);
			MapHistorique h = new MapHistorique("FactureFournisseur", "insert", "refUser", ff.getTuppleID());
			d=ff.insertToTable(con);
			con.commit();
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
		}finally{
			if(con!=null)con.close();
		}
		return ff.getIdFactureFournisseur();
    }
  public java.lang.String cloturerFactureFournisseur(String designation, String dE, String dR, String idFrns, String mTHT, String idTVA, String mTTC, String rmq, String idP, String etat, String idDevise) {
    /**@todo Complete this method*/
   /* Connection con=null;
              FactureFournisseur ff = new FactureFournisseur(designation,dE, dR, idFrns, mTHT, idTVA, mTTC,rmq, idP,etat,idDevise);
              try
              {
                con = (new UtilDB()).GetConn();
                con.setAutoCommit(false);
                MapHistorique h = new MapHistorique("FactureFournisseur", "update", "refUser", ff.getTuppleID());
                ff.updateToTableWithHisto(h);
                h.insertToTable(con);
                con.commit();
                ff.updateToTableWithHisto(h);
                String s = ff.getTuppleID();
                System.out.println("vita fact");
              }
              catch(Exception ex)
              {

              }*/

    return null;
  }
  public FactureFournisseur[] findFactureFournisseur(String num, String dateDebut, String dateFin, String fournisseur, String designation, String colonne, String ordre, String apresW) throws Exception {
    int []a = {1,3,8};
        String []val = {num,fournisseur,designation};
        try
    {
       FactureFournisseurUtil eu = new FactureFournisseurUtil();
        eu.setNomTable("FactureFournisseur");
        String apresWhere=null;
        if(apresW.compareTo("")>0)
        {
          apresW=" and "+apresW + " ";
        }
        if((dateDebut.compareTo("") == 0) & (dateFin.compareTo("") == 0))
        {
          apresWhere=apresW+String.valueOf(String.valueOf((new StringBuffer(" order by ")).append(colonne).append(" ").append(ordre)));
        }
        if((dateDebut.compareTo("") > 0) & (dateFin.compareTo("") == 0))
        {
            apresWhere=apresW+String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(dateDebut).append("' order by ").append(colonne).append(" ").append(ordre)));
         }
        if((dateDebut.compareTo("") == 0) & (dateFin.compareTo("") > 0))
        {
            apresWhere=apresW+String.valueOf(String.valueOf((new StringBuffer(" and daty<='")).append(dateFin).append("' order by ").append(colonne).append(" ").append(ordre)));
        }
        if((dateDebut.compareTo("") != 0) & (dateFin.compareTo("") != 0))
        {
            apresWhere= apresW+String.valueOf(String.valueOf((new StringBuffer(" and daty>='")).append(dateDebut).append("' and daty<='").append(dateFin).append("' order by ").append(colonne).append(" ").append(ordre)));
        }
        return (FactureFournisseur[])(eu.rechercher(a,val,apresWhere));
    }
    catch(Exception ex){
         throw new ErreurDAO(ex.getMessage());
      }


  }
  public ResultatEtSomme findFactureFournisseurPageLc(String nomtable, String id, String fourn, String designation, String numFact, String idLigne, String daty1, String daty2, String desiLc, String mois1Lc, String mois2Lc, String anneeLc, String dirLc, String entiteLc, String typeLc, String compteLc, int numPage, String colonne, String ordre) throws Exception {
   Connection c = null;
   try {
     c= new UtilDB().GetConn();
     int []a={1,3,8,10,11,17,18,19,20,22,24};
      String []val={id,fourn,designation,numFact,desiLc,typeLc,compteLc,entiteLc,dirLc,anneeLc,idLigne};
      int[]aInt={2,21};
      String[]valInt={daty1,daty2,mois1Lc,mois2Lc};
      String nomColSom[]={"montantTTC","idTva"};
      FactureFournisseurUtil op=new FactureFournisseurUtil(nomtable);
      //op.setNomTable();
      //op.rechercherPage(
      return(op.rechercherPage(a,val," order by "+colonne+" "+ordre,c,aInt,valInt,numPage,nomColSom));
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
  public ResultatEtSomme findFactureFournisseurPage(String nomTable, String num, String dateDebut, String dateFin, String fournisseur, String designation, String colonne, String ordre, String apresW, int numPage) throws Exception {
    Connection c=new UtilDB().GetConn();
    try {
      int a[] = {1,3,8};
      String val[] = {num,fournisseur,designation};
      FactureFournisseurUtil eu = new FactureFournisseurUtil();
      eu.setNomTable(nomTable);
      eu.utiliserChampBase();
      String apresWhere=apresW+ " order by "+colonne +" "+ordre;
      int interv[]={2};
      String[] valInt={dateDebut,dateFin};
      String nomColSom[]={"montantTTC"};
      ResultatEtSomme ret=  eu.rechercherPage(a, val, apresWhere,c,interv,valInt,numPage,nomColSom);
      return ret;
    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }
    finally
    {
      if(c!=null) c.close();
    }
  }

  public FactureFournisseur[] findFactureFournisseur(String nomTable, String num, String dateDebut, String dateFin, String fournisseur, String designation, String colonne, String ordre, String apresW) throws Exception {
    Connection c=new UtilDB().GetConn();
    try {
      int a[] = {1,3,8};
      String[]val={num,fournisseur,designation};
      FactureFournisseurUtil eu = new FactureFournisseurUtil();
      eu.setNomTable(nomTable);
      eu.utiliserChampBase();
      String apresWhere=apresW+ " order by "+colonne +" "+ordre;
      int interv[]={2};
      String[] valInt={dateDebut,dateFin};
      return ((FactureFournisseur[]) eu.rechercher(a, val, apresWhere,c,interv,valInt));
    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }
    finally
    {
      if(c!=null) c.close();
    }
  }
  public Fournisseur[] findFournisseurF(String idF, String fournisseur, String nif, String stat, String tel, String email, String adresse, String apresW) throws Exception {
    return null;
  }
  public java.lang.String createFournisseur(String fournisseur, String nif, String stat, String tel, String email, String adresse) {
   Connection con=null;
     int d=0;
     Fournisseur ff=new Fournisseur(fournisseur, nif, stat,tel, email, adresse);


                try
                {
                  con = (new UtilDB()).GetConn();
                  con.setAutoCommit(false);
                //  MapHistorique h = new MapHistorique("FFournisseur", "insert", "refUser", ff.getTuppleID());
                   System.out.println("avant ff");
                  d=ff.insertToTable(con);
                   System.out.println("apres ff");
                  //h.insertToTable(con);

                  System.out.println("vita fact");
                    con.commit();
                }
                catch(Exception ex)
				{
                                       try
					{
					con.rollback();
					}
                                        catch(Exception e)
                                        {
                                                e.printStackTrace();
					}
				}
				finally
				{
					try
					{
						con.close();
					}
					catch(SQLException ex)
					{
						ex.printStackTrace();
					}
				}
      return "cree "+d;

  }

  public java.lang.String cloturerFactureFournisseur(String idf, String numFact, String designation, String daty, String fournisseur, String montantHT, String tva, String montantTTC, String remarque, String etat, String projet, String dateemission, String idDevise) throws Exception {
    Connection con=null;
              FactureFournisseur ff = new FactureFournisseur(idf, numFact, designation,daty,fournisseur, tva,montantTTC,  remarque, dateemission,  idDevise);
              System.out.println("cloture facture fournisseur");
              try
              {
                con = (new UtilDB()).GetConn();
                con.setAutoCommit(false);
                MapHistorique h = new MapHistorique("FactureFournisseur", "update", "refUser", ff.getTuppleID());
                //ff.updateToTableWithHisto(h);
                ff.updateToTable(con);

                //h.insertToTable(con);
                con.commit();
               // ff.updateToTableWithHisto(h);
                String s = ff.getTuppleID();
                System.out.println("vita fact");
              }
			  catch (Exception ex) {
				throw new Exception(ex.getMessage());
				}
				finally
				{
					if(con!=null) con.close();
				}

    return null;
  }
  public String viserFactureF(String idFact, String remarque, Connection c, String refU) throws Exception {
    FactureFournisseur crt=new FactureFournisseur();
    crt.setNomTable("FACTUREFOURNISSEUR");
    crt.setIdFactureFournisseur(idFact);
    FactureFournisseur[] ff=(FactureFournisseur[] )CGenUtil.rechercher(crt,null,null,c,"");
//FactureFournisseurUtil ffu=new FactureFournisseurUtil();
//ffu.setNomTable("FactureClient");
//FactureFournisseur[] ff= (FactureFournisseur[])ffu.rechercher(1,idFact,c); //verifie si existe
    if(ff.length==0)throw new Exception ("pas de facture");
    crt.setNomTable("facturefournisseurAvise");
//ffu.setNomTable("factureclientAvise");
   ff=(FactureFournisseur[] )CGenUtil.rechercher(crt,null,null,c,""); //verifie si c'est visable
    //FactureFournisseurUtil ffu=new FactureFournisseurUtil();
    //FactureFournisseur[] ff= (FactureFournisseur[])ffu.rechercher(1,idFact,c); //verifie si existe
    //if(ff.length==0)throw new Exception ("pas de facture");
    //ffu.setNomTable("facturefournisseurAvise");
    //ff=(FactureFournisseur[])ffu.rechercher(1,idFact,c); //verifie si c'est visable
    if(ff.length==0)throw new Exception ("Facture non visable");
    VisaUtil vu=new VisaUtil();
    vu.setNomTable("VISAFACTUREF");
    Visa []v=(Visa[])vu.rechercher(4,idFact,c);
    if (v.length>0) throw new Exception ("facture deja vise");
    Visa vt=new Visa("VISAFACTUREF",Utilitaire.dateDuJour(),remarque,idFact);
    vt.insertToTableWithHisto(refU,c);
    ComptabiliteEjbClient.getInterface().ecrireFactureF(idFact ,c, refU);
    return vt.getTuppleID();
  }
  public String viserFactureF(String idFact, String remarque, String refU) throws Exception {
    Connection c=null;
    try {
      c=new UtilDB().GetConn();
      c.setAutoCommit(false);
      String ret=viserFactureF(idFact, remarque,c, refU);
      c.commit();
      return ret;
    }
    catch (Exception ex) {
      ex.printStackTrace();
      c.rollback();
      return null;
    }
    finally{
      if(c!=null)c.close();
    }
  }
  public String viserFactureC(String idFact, String remarque, Connection c, String refU) throws Exception {
    FactureFournisseur crt=new FactureFournisseur();
    crt.setNomTable("FactureClient");
    crt.setIdFactureFournisseur(idFact);
    FactureFournisseur[] ff=(FactureFournisseur[] )CGenUtil.rechercher(crt,null,null,c,"");
   //FactureFournisseurUtil ffu=new FactureFournisseurUtil();
   //ffu.setNomTable("FactureClient");
   //FactureFournisseur[] ff= (FactureFournisseur[])ffu.rechercher(1,idFact,c); //verifie si existe
   if(ff.length==0)throw new Exception ("pas de facture");
   crt.setNomTable("factureclientAvise");
   //ffu.setNomTable("factureclientAvise");
   ff=(FactureFournisseur[] )CGenUtil.rechercher(crt,null,null,c,""); //verifie si c'est visable
   if(ff.length==0)throw new Exception ("Facture non visable");
   VisaUtil vu=new VisaUtil();
   vu.setNomTable("VISAFACTURECLIENT");
   Visa []v=(Visa[])vu.rechercher(4,idFact,c);
   if (v.length>0) throw new Exception ("facture deja vise");
   Visa vt = new Visa("VISAFACTURECLIENT",Utilitaire.dateDuJour(),remarque,idFact);
   vt.insertToTableWithHisto(refU,c);
   ComptabiliteEjbClient.getInterface().ecrireFactureC(idFact ,c, refU);
   return vt.getTuppleID();
 }
 public String viserFactureC(String idFact, String remarque, String refU) throws Exception {
   Connection c=null;
   try {
     c=new UtilDB().GetConn();
     c.setAutoCommit(false);
     String ret=viserFactureC(idFact, remarque,c, refU);
     c.commit();
     return ret;
   }
   catch (Exception ex) {
     ex.printStackTrace();
     c.rollback();
     return null;
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