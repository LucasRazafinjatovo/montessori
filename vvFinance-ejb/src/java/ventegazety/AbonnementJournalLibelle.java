package ventegazety;

import bean.ClassMAPTable;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AbonnementJournalLibelle extends AbonnementJournal{
  private String journal;
  public String getJournal()
  {
    return journal;
  }
  public void setJournal(String journal)
  {
     this.journal=journal;
  }
  public AbonnementJournalLibelle() {
    this.setNomTable("abonnementJournal_libelle");
  }
}