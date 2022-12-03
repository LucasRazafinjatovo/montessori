package pub;

import bean.*;


/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class Majorationpage extends ClassMAPTable {

  public Majorationpage() {
    super.setNomTable("majorationPage");
  }
  String id;
  private int page;
  private String journal;
  private double majoration;
  public String getAttributIDName() {
    return "id";
  }
  public String getTuppleID() {
    return id;
  }
  public void setPage(int page) {
    this.page = page;
  }
  public int getPage() {
    return page;
  }
  public void setJournal(String journal) {
    this.journal = journal;
  }
  public String getJournal() {
    return journal;
  }
  public void setMajoration(double majoration) {
    this.majoration = majoration;
  }
  public double getMajoration() {
    return majoration;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
}