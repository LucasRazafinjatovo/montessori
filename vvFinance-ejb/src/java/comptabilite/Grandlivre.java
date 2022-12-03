package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class Grandlivre extends Ecriture{
	private double solde;
	
	public Grandlivre() {
		super.setNomTable("grand_livre");
	}

	public void setSolde(double _solde) {
		this.solde = _solde;
	}
	public double getSolde() {
		return solde;
	}
}