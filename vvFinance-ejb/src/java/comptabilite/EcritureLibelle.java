package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class EcritureLibelle extends Ecriture{
	private String jour, mois, annee;

	public EcritureLibelle() {
		super.setNomTable("journal_compta");
	}

	public String getJour(){
		return jour;
	}
	public void setJour (String jour){
		this.jour = jour;
	}
	
	public String getMois(){
		return mois;
	}
	public void setMois (String mois){
		this.mois = mois;
	}
	
	public String getAnnee(){
		return annee;
	}
	public void setAnnee (String annee){
		this.annee = annee;
	}
}