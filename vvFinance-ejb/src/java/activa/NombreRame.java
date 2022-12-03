package activa;

import bean.*;
import java.util.*;
import java.sql.Connection;

public class NombreRame extends ClassMAPTable
{
  private String idNombreRame;
  private int valeur;

  public NombreRame(){
    super.setNomTable("nombreRame");
  }
  public void construirePK(Connection c) throws Exception{
     super.setNomTable("nombreRame");
     this.preparePk("NBRAME","getSeqNbrame");
     this.setIdNombreRame(makePK(c));
  }

  public NombreRame(String t){
     super.setNomTable("nombreRame");
     setValeur(utilitaire.Utilitaire.stringToInt(t));
     setIndicePk("NBRAME");
     setNomProcedureSequence("getSeqNombreRame");
     setIdNombreRame(makePK());
  }

  public NombreRame(String i,int t,Connection c) {
    super.setNomTable("nombreRame");
     this.setIdNombreRame(i);
     setValeur(t);
     if(c==null)
       c = new utilitaire.UtilDB().GetConn();
  }

  public String getAttributIDName() {
   return "idNombreRame";
  }
  public String getTuppleID() {
   return idNombreRame;
  }
  public void setIdNombreRame(String idNombreRame) {
    this.idNombreRame = idNombreRame;
  }
  public String getIdNombreRame() {
    return idNombreRame;
  }
  public void setValeur(int valeur) {
    this.valeur = valeur;
  }
  public int getValeur() {
    return valeur;
  }

}
