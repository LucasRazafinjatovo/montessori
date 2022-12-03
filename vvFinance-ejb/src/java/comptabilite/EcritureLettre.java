package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class EcritureLettre extends Ecriture{
	private String lettres;

	public EcritureLettre() {
		super.setNomTable("grand_livre_lettre");
	}

	public void setLettres(String lettres) {
		this.lettres = lettres;
	}
	public String getLettres() {
		return lettres;
	}
}