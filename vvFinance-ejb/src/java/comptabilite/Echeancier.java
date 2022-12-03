package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class Echeancier extends Ecriture{
	private String typetiers, numerotiers;
	private double solde;

	public Echeancier() {
		super.setNomTable("echeancier_vue");
	}

	public void setTypetiers(String typetiers) {
		this.typetiers = typetiers;
	}
	public String getTypetiers() {
		return typetiers;
	}
	public void setNumerotiers(String numerotiers) {
		this.numerotiers = numerotiers;
	}
	public String getNumerotiers() {
		return numerotiers;
	}
	public void setSolde(double _solde) {
		this.solde = _solde;
	}
	public double getSolde() {
		return solde;
	}
}