package ladies;

import bean.*;
import java.sql.Connection;
import facture.Client;
import utilitaire.Utilitaire;
import java.sql.Date;


public class TarifPub extends ClassMAPTable {

	private String id;
        private String val;
        private double montant;
        private String description;
        private Date dateffective;
        public TarifPub() {
                super.setNomTable("TarifPub");
	}
        public String getAttributIDName() {
                return "id";
        }
        public String getTuppleID() {
                return id;
	}

        public void construirePK(Connection c) throws Exception
        {
                super.setNomTable("TarifPub");
                this.preparePk("TRF","getSeqTarifPub");
                this.setId(makePK(c));
	}
  public Date getDateffective() {
    return dateffective;
  }
  public String getDescription() {
    return description;
  }
  public String getId() {
    return id;
  }
  public double getMontant() {
    return montant;
  }
  public void setMontant(double montant) {
    this.montant = montant;
  }
  public void setId(String id) {
    this.id = id;
  }
  public void setDescription(String description) {
    this.description = description;
  }
  public void setDateffective(Date dateeffective) {
    this.dateffective = dateeffective;
  }
  public String getVal() {
    return val;
  }
  public void setVal(String val) {
    this.val = val;
  }
}
