package pointage;

import historique.*;
import javax.ejb.*;
import bean.*;
import java.rmi.RemoteException;

@Stateful
@AccessTimeout(0)
public class PointageEjbBean implements PointageEjb, PointageEjbRemote, SessionBean {
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
  public String createPointage(String user, String daty, String heure, String type, String remarque, String ip, String agence,String machine) throws Exception {
    try {
      System.out.println("agence=========="+agence);
      Pointage p=new Pointage(user, type, remarque,ip,agence, machine);
      MapHistorique h = new MapHistorique("Change", "insert", user, p.getTuppleID());
      p.insertToTable(h);
      return p.getTuppleID();
    }
    catch (ErreurDAO ex) {
            throw new Exception(ex.getMessage());
    }
  }
  public Pointage[] findPointage(String idPointage, String user, String datyInf, String datySup, String heureInf, String heureSup, String type, String rem, String ip, String agence,String machine) throws Exception {
    /**@todo Complete this method*/
    int a[] ={1,2,5,6,7,8,9};
    String apresWhere="";
    String val[] = new String[a.length];
             val[0] = idPointage;
             val[1] = user;
             val[2] = type;
              val[3] = rem;
              val[4] = ip;
              val[5] = agence;
              val[6] = machine;
              PointageUtil pu = new PointageUtil();
              pu.setNomTable("PointageLettre");
              /*if (datyInf.compareTo("")==0 & datySup.compareTo("")==0 & heureInf.compareTo("")==0 & heureSup.compareTo("")==0)
                return (Pointage[])pu.rechercher(a,val," order by daty desc");
              if (datyInf.compareTo("")>0 & datySup.compareTo("")==0)
                return (Pointage[])pu.rechercher(a,val," and daty>='"+datyInf+"' order by daty desc");
              if (datyInf.compareTo("")==0 & datySup.compareTo("")>0)
                return (Pointage[])pu.rechercher(a,val," and daty<='"+datySup+"' order by daty desc");
              if (datyInf.compareTo("")!=0 & datySup.compareTo("")!=0)
                return (Pointage[])pu.rechercher(a,val," and daty>='"+datyInf+"' and daty<='"+datySup+"' order by daty desc");
              */
              if (datyInf.compareTo("")>0) apresWhere=apresWhere+" and daty>='"+datyInf+"'";
              if (datySup.compareTo("")>0) apresWhere=apresWhere+" and daty<='"+datySup+"'";
              if (heureInf.compareTo("")>0) apresWhere=apresWhere+" and heure<='"+heureInf+"'";
              if (heureSup.compareTo("")>0) apresWhere=apresWhere+" and heure>='"+heureSup+"'";
              apresWhere=apresWhere+" order by daty desc";

              return (Pointage[])pu.rechercher(a,val,apresWhere);
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