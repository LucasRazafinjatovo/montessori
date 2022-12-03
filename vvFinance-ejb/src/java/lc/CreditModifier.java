package lc;

import java.sql.Date;
import bean.ClassMAPTable;

public class CreditModifier extends ClassMAPTable {
	
	public String idLCModif;
	public double creditModif;
	public Date datyModif;
	public String heurModif;
	public String motifModif;
	public String idLigne;
	
	
	public CreditModifier(double creditModif, Date datyModif, String heurModif, String motifModif, String idLigne) {
		this.creditModif = creditModif;
		this.datyModif = datyModif;
		this.heurModif = heurModif;
		this.motifModif = motifModif;
		this.idLigne = idLigne;
		
		this.setNomTable("creditmodifier");
		this.setNomProcedureSequence("getSeqCreditModifier");
		this.setIndicePk("CM");
		this.setIdLCModif(makePK());
	}

	
	public CreditModifier(String idLCModif, double creditModif, Date datyModif, String heurModif, String motifModif, String idLigne) {
		this.idLCModif = idLCModif;
		this.creditModif = creditModif;
		this.datyModif = datyModif;
		this.heurModif = heurModif;
		this.motifModif = motifModif;
		this.idLigne = idLigne;
		
		this.setNomTable("creditmodifier");
		
	}

	public double getCreditModif() {
		return creditModif;
	}

	public void setCreditModif(double creditModif) {
		this.creditModif = creditModif;
	}

	public Date getDatyModif() {
		return datyModif;
	}

	public void setDatyModif(Date datyModif) {
		this.datyModif = datyModif;
	}

	public String getHeurModif() {
		return heurModif;
	}

	public void setHeurModif(String heurModif) {
		this.heurModif = heurModif;
	}

	public String getIdLCModif() {
		return idLCModif;
	}

	public void setIdLCModif(String idLCModif) {
		this.idLCModif = idLCModif;
	}

	public String getIdLigne() {
		return idLigne;
	}

	public void setIdLigne(String idLigne) {
		this.idLigne = idLigne;
	}

	public String getMotifModif() {
		return motifModif;
	}

	public void setMotifModif(String motifModif) {
		this.motifModif = motifModif;
	}

	public String getAttributIDName() {
		return "idLCModif";
	}

	public String getTuppleID() {
		return String.valueOf(idLCModif);
	}
	
}
