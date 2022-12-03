package lc;

import bean.ClassMAPTable;

public class LigneCreditNature extends LigneCreditCompletCompte {

	private String nature;

	private double impaye;

	public LigneCreditNature(){
		this.setNomTable("LIGNECREDITDEPENSENATURE");
	}

	public String getNature() {
		return nature;
	}

	public void setNature(String nature) {
		this.nature = nature;
	}

	public double getImpaye(){
		return impaye;
	}
	public void setImpaye(double impaye){
		this.impaye = impaye;
	}

	public String getAttributIDName() {
		return "idLigne";
	}

	public String getTuppleID() {
		return idLigne;
	}

}
