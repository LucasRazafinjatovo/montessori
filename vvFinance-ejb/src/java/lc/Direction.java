package lc;

import bean.ClassMAPTable;

public class Direction extends ClassMAPTable {
	
	public String idDir;
	public String libelledir;
	public String descdir;
	public double idDirecteur;
	public String abbrevDir;
	
	public Direction(){
		this.setNomTable("direction");
	}
	
	public Direction(String libelledir, String descdir, double idDirecteur, String abbrevDir) {
		this.libelledir = libelledir;
		this.descdir = descdir;
		this.idDirecteur = idDirecteur;
		this.abbrevDir = abbrevDir;
		
		this.setNomTable("direction");
		this.setNomProcedureSequence("getSeqDirection");
		this.setIndicePk("DIR");
		this.setIdDir(makePK());
	}

	public Direction(String idDir, String libelledir, String descdir, double idDirecteur, String abbrevDir) {
		this.idDir = idDir;
		this.libelledir = libelledir;
		this.descdir = descdir;
		this.idDirecteur = idDirecteur;
		this.abbrevDir = abbrevDir;
		
		this.setNomTable("direction");
	}

	public String getAttributIDName() {
		return "idDir";
	}

	public String getTuppleID() {
		return String.valueOf(idDir);
	}


	public String getAbbrevDir() {
		return abbrevDir;
	}

	public void setAbbrevDir(String abbrevDir) {
		this.abbrevDir = abbrevDir;
	}

	public String getDescdir() {
		return descdir;
	}

	public void setDescdir(String descdi) {
		if(descdir == null) descdi="-";
		this.descdir = descdi;
	}

	public String getIdDir() {
		return idDir;
	}

	public void setIdDir(String idDir) {
		this.idDir = idDir;
	}

	public double getIdDirecteur() {
		return idDirecteur;
	}

	public void setIdDirecteur(double idDirecteur) {
		this.idDirecteur = idDirecteur;
	}

	public String getLibelledir() {
		return libelledir;
	}

	public void setLibelledir(String libelledir) {
		this.libelledir = libelledir;
	}

	

}