package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class Comptejournal extends ClassMAPTable{
	private String codejournal;
	private int precisiondebit, comptedebit, comptecredit, precisioncredit;

	public Comptejournal() {
		super.setNomTable("Comptejournal");
	}

	public String getTuppleID(){
		return codejournal;
	}
	public String getAttributIDName(){
		return null;
	}
	public void setCodejournal(String codejournal) {
		this.codejournal = codejournal;
	}
	public String getCodejournal() {
		return codejournal;
	}
	public void setComptedebit(int compte) {
		this.comptedebit = compte;
	}
	public int getComptedebit() {
		return comptedebit;
	}
	
	public void setComptecredit(int compte) {
		this.comptecredit = compte;
	}
	public int getComptecredit() {
		return comptecredit;
	}
	public void setPrecisiondebit(int _precision){
		this.precisiondebit = _precision;
	}
	public int getPrecisiondebit(){
		return this.precisiondebit;
	}
	public void setPrecisioncredit(int _precision){
		this.precisioncredit = _precision;
	}
	public int getPrecisioncredit(){
		return this.precisioncredit;
	}
}