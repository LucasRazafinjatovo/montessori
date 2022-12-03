package finance;

import java.util.Vector;
/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class AdminCaisse {

  public AdminCaisse() {
  }

  public static Caisse[] filtreCaisseByResp(Caisse[] c,String respVal){
    try{
     Vector temp = new Vector();
      int i=0, j=0, k=0;
      for(i=0; i<c.length; i++){
        if(c[i].getRespCaisse().compareTo(respVal)==0) {
          temp.add(k, c[i]);
          k++;
        }
      }
      if(k!=0){
        Caisse[] retour = new Caisse[k];
        temp.copyInto(retour);
        return retour;
      }
      else return null;
    }

   catch(Exception e){
    e.printStackTrace();
    return null;
  }
}
}
