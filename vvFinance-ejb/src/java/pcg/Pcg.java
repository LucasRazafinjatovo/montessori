package pcg;

/**
 * <p>Title: Gestion des recettes : Société du Port à gestion Autonome de Toamasina</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */
import bean.*;
public class Pcg extends ClassMAPTable{
public String IDCOMPTE;
public String COMPTE;
public String LIBELLE;
public String PCOMPTE;
  public Pcg() {
  }
  public Pcg(String cpt,String lib,String pc){
  //insert
    super.setNomTable("Pcg");
    setIndicePk("CPT");
    setNomProcedureSequence("getSeqPCG");
    setIDCOMPTE(makePK());
    setCOMPTE(cpt);
    setLIBELLE(lib);
    setPCOMPTE(pc);
    System.out.println("insertion");

  }
  public Pcg(String idc,String cpt,String lib,String pc){
    //select
     super.setNomTable("Pcg");
    setIDCOMPTE(idc);
    setCOMPTE(cpt);
    setLIBELLE(lib);
    setPCOMPTE(pc);
  }
  public String getIDCOMPTE(){
    return IDCOMPTE;
  }
  public String getCOMPTE(){
    return COMPTE;
  }
  public String getLIBELLE(){
    return LIBELLE;
  }
  public String getPCOMPTE(){
    return PCOMPTE;
  }

  public void  setIDCOMPTE(String idc){
    this.IDCOMPTE=idc;
}
public void  setCOMPTE(String c){
   this.COMPTE=c;
}
public void  setLIBELLE(String l){
  this.LIBELLE=l;
}
public void  setPCOMPTE(String pc){
  this.PCOMPTE=pc;
  }
  public String getTuppleID(){
    return String.valueOf(IDCOMPTE);
  }

    public String getAttributIDName(){
      return "idCompte";
     }
}