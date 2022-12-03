package comptabilite;

import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.*;

public class CompteTiers extends ClassMAPTable{
	private String id, idsociete, compte,
	reftiers, nom, nif,
		telephone, adresse, stat, rcs;
    private String typetiers;

	public CompteTiers() {
		super.setNomTable("CompteTiers");
	}

        private String[] specifier (){
          String[] resultat = new String[2];
          resultat[0] = this.typetiers;
          if (this.typetiers.compareTo("C")==0){
            resultat[1] = "GETSEQCOMPTECLIENT";
          }
          else if (this.typetiers.compareTo("F") == 0){
            resultat[1] = "GETSEQCOMPTEFOURNISSEUR";
          }
          else if (this.typetiers.compareTo("E")==0){
            resultat[1] = "GETSEQCOMPTEPERSONNEL";
          }
          return resultat;
        }

	public void construirePK(Connection c) throws Exception{
		super.setNomTable("CompteTiers");
                String[] result = this.specifier();
		this.preparePk(result[0],result[1]);
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
	public void setIdsociete(String idsociete) {
		this.idsociete= idsociete;
	}
	public String getIdsociete() {
		return idsociete;
	}
	public void setCompte(String compte) {
		this.compte= compte;
	}
	public String getCompte() {
		return compte;
	}
	public void setReftiers(String reftiers) {
		this.reftiers= reftiers;
	}
	public String getReftiers() {
		return reftiers;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getNom() {
		return nom;
	}

	public void setAdresse(String adresse) {
		this.adresse = adresse;
	}
	public String getAdresse() {
		return adresse;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setStat(String stat) {
		this.stat = stat;
	}
	public String getStat() {
		return stat;
	}
	public void setNif(String nif) {
		this.nif = nif;
	}
	public String getNif() {
		return nif;
	}
	public void setRcs(String rcs) {
		this.rcs = rcs;
	}
	public String getRcs() {
		return rcs;
	}
        public void setTypetiers(String typrtiers) {
                this.typetiers = typrtiers;
        }
        public String getTypetiers() {
                return typetiers;
	}
}