package indicateur;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class ImpressionPrevision extends ClassMAPTable{
	private String id, moisprod;
	private int nbimpression;

	public ImpressionPrevision() {
		super.setNomTable("IMPRESSIONPREVISION");
	}

	public void construirePK(Connection c) throws Exception{
		super.setNomTable("IMPRESSIONPREVISION");
		this.preparePk("IMPPREV","GETSEQIMPRESSIONPREVISION");
		this.setId(makePK(c));
	}

	public String getTuppleID(){
		return id;
	}
	public String getAttributIDName(){
		return "id";
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getId() {
		return id;
	}
	public void setMoisprod(String moisprod) {
		this.moisprod= moisprod;
	}
	public String getMoisprod() {
		return moisprod;
	}

	public void setNbimpression(int _nbimpression) throws Exception{
		if (_nbimpression<0) throw new Exception("Nombre d'impression invalide");
		this.nbimpression= _nbimpression;
	}
	public int getNbimpression() {
		return nbimpression;
	}
}