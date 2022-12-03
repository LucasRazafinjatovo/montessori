package finance;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ComptaLettrageParam extends ClassMAPTable{
  private String id;
      private String id_compte_tiers;
      private String exercice;
      private String lettre;

      public ComptaLettrageParam(){
          super.setNomTable("COMPTA_LETTRAGE_RAPPRO");
      }

      public ComptaLettrageParam(String id_compte_tiers, String exercice, String lettre){
          super.setNomTable("COMPTA_LETTRAGE_RAPPRO");
          this.setId_compte_tiers(id_compte_tiers);
          this.setExercice(exercice);
          this.setLettre(lettre);
      }

      public ComptaLettrageParam(String id,String id_compte_tiers, String exercice, String lettre){
          super.setNomTable("COMPTA_LETTRAGE_RAPPRO");
          this.setId(id);
          this.setId_compte_tiers(id_compte_tiers);
          this.setExercice(exercice);
          this.setLettre(lettre);
      }
      public void construirePK(Connection c) throws Exception {

          this.preparePk("CLR", "GETSEQCOMPTALETTRAGERAPPRO");
          this.setId(makePK(c));
      }
      public String getTuppleID() {
          return id;
      }
      public String getAttributIDName() {
          return "id";
      }

      /**
       * @return the id
       */
      public String getId() {
          return id;
      }

      /**
       * @param id the id to set
       */
      public void setId(String id) {
          this.id = id;
      }

      /**
       * @return the id_compte_tiers
       */
      public String getId_compte_tiers() {
          return id_compte_tiers;
      }

      /**
       * @param id_compte_tiers the id_compte_tiers to set
       */
      public void setId_compte_tiers(String id_compte_tiers) {
          this.id_compte_tiers = id_compte_tiers;
      }

      /**
       * @return the exercice
       */
      public String getExercice() {
          return exercice;
      }

      /**
       * @param exercice the exercice to set
       */
      public void setExercice(String exercice) {
          this.exercice = exercice;
      }

      /**
       * @return the lettre
       */
      public String getLettre() {
          return lettre;
      }

      /**
       * @param lettre the lettre to set
       */
      public void setLettre(String lettre) {
          this.lettre = lettre;
    }
}