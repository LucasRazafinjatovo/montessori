package stock;

import java.rmi.RemoteException;
import javax.ejb.*;
import java.sql.Connection;
import utilitaire.UtilDB;
import pub.Parution;

@Stateful
@AccessTimeout(0)
public class StockEjbBean implements StockEjb, StockEjbRemote, SessionBean {
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
  public String creerMvtStock(String design, String type, String debit, String credit, String compte, String unite, String rmq, String refUser) throws Exception {
    try {
      MvtStock m = new MvtStock(design,type,debit,credit,compte,unite,rmq);
      m.insertToTableWithHisto(refUser);
      return m.getTuppleID();
    }
    catch (Exception ex) {
      throw new Exception(ex.getMessage());
    }

}
public String creerDossier(String idMvt, String typeDossier, String design, String num, String daty, String tiers, String qte, String mont, String rmq, String refUser) throws Exception {
  try {
    Dossier d = new Dossier(idMvt, typeDossier,design,num,daty,tiers,qte,mont,rmq);
    d.insertToTableWithHisto(refUser);
    return d.getTuppleID();
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public String updateDossier(String id, String idMvt, String typeDossier, String design, String num, String daty, String tiers, String qte, String mont, String rmq, String refUser) throws Exception {
  try {
    Dossier[] d = findDossier(id,"%","%","","");
    if(d.length!=0){
      d[0].setMvtStock(idMvt);
      d[0].setTypeDossier(typeDossier);
      d[0].setDesignation(design);
      d[0].setNumero(num);
      d[0].setDaty(utilitaire.Utilitaire.string_date("dd/MM/yyyy", daty));
      d[0].setTiers(tiers);
      d[0].setQtetot(utilitaire.Utilitaire.stringToDouble(qte));
      d[0].setMonttot(utilitaire.Utilitaire.stringToDouble(mont));
      d[0].setRemarque(rmq);
      d[0].updateToTableWithHisto(refUser);
    }
    else throw new Exception("Impossible de trouver le dossier correcspondant");
      return d[0].getTuppleID();
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public String creerDetailBobine(String numBob, String poids, String idMvt, String refUser) throws Exception {
  try {
    DetailBobinePoids d = new DetailBobinePoids(numBob,poids,idMvt);
    d.insertToTableWithHisto(refUser);
    return d.getTuppleID();
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public String creerParution(String journal, String numP, String datyP, String nbpage, String nbex, String poids, String printer, String idMvt, String rmq, String refUser) throws Exception {
  /*try {

    Parution p = new Parution(journal,numP,datyP,nbpage,nbex,poids,printer,idMvt,rmq);
    p.insertToTableWithHisto(refUser);
    return p.getTuppleID();
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }*/
    return null;
}
public String creerLettrageMvt(String parent, String fille, String rmq, String refUser) throws Exception {
  try {
    LettrageMvt l = new LettrageMvt(parent,fille,rmq);
    l.insertToTableWithHisto(refUser);
    return l.getTuppleID();
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public String creerVerification(String mag, String reste, String unite, String controleur, String rmq, String refUser) throws Exception {
  try {
    Verification v = new Verification(mag,reste,unite,controleur,rmq);
    v.insertToTableWithHisto(refUser);
    return v.getTuppleID();
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public String creerDetailVerifi(String numBob, String pourcentage, String verif, String rmq, String refUser) throws Exception {
  try {
    DetailVerif v = new DetailVerif(numBob,pourcentage,verif,rmq);
    v.insertToTableWithHisto(refUser);
    return v.getTuppleID();
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public MvtStock[] findMvtStock(String idMvt, String datyInf, String datySup, String typeMvt, String compte) throws Exception {
  try {
    int[] a ={1,4,7};
    String[] val={idMvt,typeMvt,compte};
    int[] b={2};
    String[] bval={datyInf,datySup};
    MvtStockUtil m = new MvtStockUtil();
    return(MvtStock[])(m.rechercher(a,val,b,bval));
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }

}
public Dossier[] findDossier(String id, String idMvt, String typeDossier, String datyInf, String datySup) throws Exception {
  try {
    int[] a ={1,2,3};
    String[] val={id,idMvt,typeDossier};
    int[] b={6};
    String[] bval={datyInf,datySup };
    DossierUtil m = new DossierUtil();
    return(Dossier[])(m.rechercher(a,val,b,bval));
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public DetailBobinePoids[] findDetailBobine(String id, String numBobine, String idMvt) throws Exception {
  try {
    int[] a ={1,2,4};
    String[] val={id,numBobine,idMvt};
    DetailBobinePoidsUtil m = new DetailBobinePoidsUtil();
    return(DetailBobinePoids[])(m.rechercher(a,val));
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}

public Parution[] findParution(String id, String datyInf, String datySup, String journal, String datyParInf, String datyParSup, String printer, String idMvt) throws Exception {
  /*try {
    int[] a ={1,3,9,10};
    String[] val={id,journal,printer, idMvt};
    int[] b ={2,5};
    String[] bval={datyInf, datySup, datyParInf, datyParSup};
    ParutionUtil m = new ParutionUtil();
    return(Parution[])(m.rechercher(a,val,b,bval));
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }*/
  return null;
}
public double calculQte(String nbPage, String nbEx, String poids) throws Exception {
  try {

    double qte = 0;
    return qte;
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public LettrageMvt[] findLettrageMvt(String id, String parent, String fille) throws Exception {
  try {
    int[] a ={1,2,3};
    String[] val={id,parent,fille};
    LettrageMvtUtil m = new LettrageMvtUtil();
    return(LettrageMvt[])(m.rechercher(a,val));
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public Verification[] findVerification(String id, String datyInf, String datySup, String mag, String controleur) throws Exception {
  try {
    int[] a ={1,3,6};
    String[] val={id,mag,controleur};
    int[] b ={2};
    String[] bval={datyInf,datySup};
    VerificationUtil m = new VerificationUtil();
    return(Verification[])(m.rechercher(a,val,b,bval));
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public DetailVerif[] findDetailVerif(String id, String numBob, String idVerif) throws Exception {
  try {
    int[] a ={1,2,4};
    String[] val={id,numBob,idVerif};
    DetailVerifUtil m = new DetailVerifUtil();
    return(DetailVerif[])(m.rechercher(a,val));
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public String faireMvtStock(String design, String type, String debitS, String creditS, String debitD, String creditD, String compteS, String compteD, String unite, String rmq, String refUser) throws Exception {
  Connection con= null;
   try {
     con = (new UtilDB()).GetConn();
     con.setAutoCommit(false);
     MvtStock ms = new MvtStock(design,type,debitS,creditS,compteS,unite,rmq);
     MvtStock md = new MvtStock(design,type,debitD,creditD,compteD,unite,rmq);
     ms.insertToTableWithHisto(refUser,con);
     md.insertToTableWithHisto(refUser,con);
     String idDebit = ms.getTuppleID();
     String idCredit = md.getTuppleID();
     LettrageMvt l= new LettrageMvt(idCredit,idDebit,rmq);
     l.insertToTableWithHisto(refUser,con);
     con.commit();
     return l.getTuppleID();
   }
   catch(Exception ex)
   {
     con.rollback();
     throw new Exception(ex.getMessage());
    }
    finally
    {
      con.close();
    }

}
public String enleverDetailBobine(String id, String refUser) throws Exception {
  try {
    DetailBobinePoids[] d = findDetailBobine(id,"%","%");
    d[0].deleteToTable();
    return d[0].getTuppleID();
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public String enleverDossier(String idDossier, String refUser) throws Exception {
  try {
    Dossier[] d = findDossier(idDossier,"%","%","","");
    d[0].deleteToTable();
    return d[0].getTuppleID();
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }
}
public MvtCompte[] findMvtCompte(String idMvt, String datyInf, String datySup, String typeMvt, String compte, String val, String desce) throws Exception {
  try {
    int[] a ={1,4,7,10,11};
    String[] aval={idMvt,typeMvt,compte,val,desce};
    int[] b={2};
    String[] bval={datyInf,datySup};
    MvtCompteUtil m = new MvtCompteUtil();
    return(MvtCompte[])(m.rechercher(a,aval,b,bval));
  }
  catch (Exception ex) {
    throw new Exception(ex.getMessage());
  }

}
public MvtBobine[] findMvtBobine(String idMvt, String datyInf, String datySup, String typeMvt, String compte, String numB) throws Exception {
  try {
    int[] a ={1,4,7,10,11};
    String[] aval={idMvt,typeMvt,compte,numB};
    int[] b={2};
    String[] bval={datyInf,datySup};
    MvtBobineUtil m = new MvtBobineUtil();
    return(MvtBobine[])(m.rechercher(a,aval,b,bval));
  }
  catch (Exception ex) {
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

