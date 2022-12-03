package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class ComptejournalLibelle extends ClassMAPTable{
	private String codejournal;
	private int comptedebit, debutdebit, findebit,
		comptecredit, debutcredit, fincredit;

	public ComptejournalLibelle() {
		super.setNomTable("Comptejournal_libelle");
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
	public void setDebutdebit(int _debutdebit){
		this.debutdebit = _debutdebit;
	}
	public int getDebutdebit(){
		return this.debutdebit;
	}
	public void setFindebit(int findebit){
		this.findebit = findebit;
	}
	public int getFindebit(){
		return this.findebit;
	}
	public void setDebutcredit(int _debutcredit){
		this.debutcredit = _debutcredit;
	}
	public int getDebutcredit(){
		return this.debutcredit;
	}
	public void setFincredit(int fincredit){
		this.fincredit = fincredit;
	}
	public int getFincredit(){
		return this.fincredit;
	}
}