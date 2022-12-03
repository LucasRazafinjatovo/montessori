package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class BalanceTiers extends Balance{
	private String typetiers, comptetiers;
	
	public BalanceTiers() {
		super.setNomTable("balancetiers_groupe_libelle");
	}

	public void setTypetiers(String typetiers) {
		this.typetiers = typetiers;
	}
	public String getTypetiers() {
		return typetiers;
	}
	public void setComptetiers(String comptetiers) {
		this.comptetiers = comptetiers;
	}
	public String getComptetiers() {
		return comptetiers;
	}
}