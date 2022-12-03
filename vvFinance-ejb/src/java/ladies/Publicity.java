package ladies;

import bean.*;
import java.sql.Connection;
import facture.Client;
import utilitaire.Utilitaire;
import java.sql.Date;


public class Publicity extends ClassMAPTable {

	private String id;
	private String idClient;
	private String format;
	private String idCat;
	private String idAgence;
	private String datyParution;
	private int numPage;
	private String designation;
	private String numBc;
	private String remarque;
	private String numPiece;
	private int publie;
	private double montant;
	private double remis;
	private Date datycreation;
        private int nombre;

	public Publicity() {
		super.setNomTable("Publicity");

	}
        public void construirePK(Connection c) throws Exception
        {
                super.setNomTable("Publicity");
                this.preparePk("PUB","getSeqPublicity");
                this.setId(makePK(c));
	}


	public String getAttributIDName() {
		return "id";
	}
	public String getTuppleID() {
		return id;
	}
	public void setIdClient(String idClient) {
		this.idClient = idClient;
	}
	public void setIdClientLib(String idClient,Connection c) throws Exception
	{
		setIdClient(Client.getIdDyn(idClient,c));
	}
	public String getIdClient() {
		return idClient;
	}

	public void setIdCat(String idCat) {
		this.idCat = idCat;
	}
	public String getIdCat() {
		return idCat;
	}
	public void setIdAgence(String idAgence) {
		this.idAgence = idAgence;
	}
	public String getIdAgence() {
		return idAgence;
	}
	public void setDatyParution(String idParution) {
		this.datyParution = idParution;
	}
	public String getDatyParution() {
		return datyParution;
	}
	public void setNumPage(int numPage) {
		this.numPage = numPage;
	}
	public int getNumPage() {
		return numPage;
	}
	public void setDesignation(String designation)throws Exception {
		if((designation==null || designation.compareToIgnoreCase("")==0)&&getMode().compareToIgnoreCase("insert")==0)
		{
			throw new Exception("Designation obligatoire");
		}
		this.designation = designation;
	}
	public String getDesignation() {
		return designation;
	}
	public void setNumBc(String numBc) {
		this.numBc = numBc;
	}
	public String getNumBc() {
		return numBc;
	}
	public void setRemarque(String remarque) {
		this.remarque = remarque;
	}
	public String getRemarque() {
		return remarque;
	}
	public void setNumPiece(String numPiece) {
		this.numPiece = numPiece;
	}
	public String getNumPiece() {
		return numPiece;
	}


	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setMontant(double montant) {
		this.montant = montant;
	}
	public double getMontant() {
		return montant;
	}
	public void setRemis(double remis) {
		this.remis = remis;
	}
	public double getRemis() {
		return remis;
	}

  public Date getDatycreation() {
    return datycreation;
  }
  public void setDatycreation(Date datycreation) {
    this.datycreation = datycreation;
  }
  public String getFormat() {
    return format;
  }
  public void setFormat(String format) {
    this.format = format;
  }
  public int getPublie() {
    return publie;
  }
  public void setPublie(int publie) {
    this.publie = publie;
  }
  public int getNombre() {
    return nombre;
  }
  public void setNombre(int nombre) {
    this.nombre = nombre;
  }
}