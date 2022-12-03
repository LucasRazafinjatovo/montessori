package lc;

import bean.ClassMAPTable;

public class Typelcdepense extends ClassMAPTable {

	public String id;
	public String val;
	public String desce;
	public int etat;

	public Typelcdepense(){
		this.setNomTable("typelcdepensetous");
	}

	public Typelcdepense(String libelledir, String descdir, double idDirecteur, String abbrevDir) {
		this.val = val;
		this.desce = desce;
		this.etat = etat;
		this.setNomTable("typelcdepensetous");
		this.setNomProcedureSequence("getSeqtypelcdepense");
		this.setIndicePk("TPS");
		this.setId(makePK());
	}



	public String getAttributIDName() {
		return "id";
	}

	public String getTuppleID() {
		return String.valueOf(id);
	}
  public String getDesce() {
    return desce;
  }
  public int getEtat() {
    return etat;
  }
  public String getId() {
    return id;
  }
  public String getVal() {
    return val;
  }
  public void setVal(String val) {
    this.val = val;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setEtat(int etat) {
    this.etat = etat;
  }
  public void setDesce(String desce) {
    this.desce = desce;
  }

}