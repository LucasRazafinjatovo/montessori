package affichage;

import ventegazety.Vendeur;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;

public class Essai {

  public Essai() {
  }
  public static void main(String[] args) {
    try{
    Vendeur v=new Vendeur();

    v.setMode("insert");
    Field f=v.getClass().getField("taux");
    Class[] paramT={f.getType()};
    Object[] arg={new Integer(67)};
    v.getClass().getMethod("setTaux",paramT).invoke(v,arg);

    //v.setTaux(67);
    }
    catch(InvocationTargetException x)
    {

      System.out.println(x.getTargetException().getMessage());
    }
    catch(Exception f)
    {
      System.out.println("erreur ambany indray e");
    }
  }
}