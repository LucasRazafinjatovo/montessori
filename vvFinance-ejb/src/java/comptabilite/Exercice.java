package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class Exercice extends ClassMAPTable{
	private String id, idsociete;
	private Date datedebut, datefin;
	private int etat;

	public Exercice() {
		super.setNomTable("Exercice");
	}

        public Exercice(String id, Date datedebut, Date datefin, int etat, String idsociete) {
                super.setNomTable("Exercice");
                this.setId(id);
                this.setDatedebut(datedebut);
                this.setDatefin(datefin);
                this.setEtat(etat);
                this.setIdsociete(idsociete);
	}

	public void construirePK(Connection c) throws Exception{
		super.setNomTable("Exercice");
		this.preparePk("EXC","GETSEQEXERCICE");
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
	public void setIdsociete(String _idsociete) {
		this.idsociete = _idsociete;
	}
	public String getIdsociete() {
		return idsociete;
	}
	public void setDatedebut(Date _date) {
		this.datedebut = _date;
	}
	public Date getDatedebut() {
		return datedebut;
	}
	public void setDatefin(Date _date) {
		this.datefin = _date;
	}
	public Date getDatefin() {
		return datefin;
	}
	public int getEtat() {
		return etat;
	}
	public void setEtat(int _etat) {
		this.etat = _etat;
	}
	public void ouvrir (){
		this.etat = 0;
	}
	public void cloturer(){
		this.etat = 1;
	}
}