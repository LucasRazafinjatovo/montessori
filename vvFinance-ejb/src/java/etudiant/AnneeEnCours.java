package etudiant;

import bean.ClassMAPTable;

public class AnneeEnCours extends ClassMAPTable{
    String id;
    String nom;
    public AnneeEnCours() 
    {
        super.setNomTable("anneeencours");
    
    }
    public String getId() {
        return id;
      }
      public void setId(String id) {
        this.id = id;
      }
    public void setNom(String nom) throws Exception
    {        
        this.nom = nom;
    }
    public String getNom()
    {
      return nom;
    }
    @Override
    public String getTuppleID() {
        // TODO Auto-generated method stub
        return id;
    }
    @Override
    public String getAttributIDName() {
        // TODO Auto-generated method stub
        return "id";
    }
    
}
