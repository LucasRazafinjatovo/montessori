package pcg;

import javax.naming.*;
import javax.rmi.PortableRemoteObject;

public class GestionPlanComptableTestClient1 {
  static final private String ERROR_NULL_REMOTE = "Remote interface reference is null.  It must be created by calling one of the Home interface methods first.";
  static final private int MAX_OUTPUT_LINE_LENGTH = 100;
  private boolean logging = true;
  private GestionPlanComptableHome gestionPlanComptableHome = null;
  private GestionPlanComptable gestionPlanComptable = null;

  //Construct the EJB test client
  public GestionPlanComptableTestClient1() {
    long startTime = 0;
    if (logging) {
      log("Initializing bean access.");
      startTime = System.currentTimeMillis();
    }

    try {
      //get naming context
      Context ctx = new InitialContext();

      //look up jndi name
      Object ref = ctx.lookup("GestionPlanComptable");

      //cast to Home interface
      gestionPlanComptableHome = (GestionPlanComptableHome) PortableRemoteObject.narrow(ref, GestionPlanComptableHome.class);
      if (logging) {
        long endTime = System.currentTimeMillis();
        log("Succeeded initializing bean access.");
        log("Execution time: " + (endTime - startTime) + " ms.");
      }
    }
    catch(Exception e) {
      if (logging) {
        log("Failed initializing bean access.");
      }
      e.printStackTrace();
    }
  }

  //----------------------------------------------------------------------------
  // Methods that use Home interface methods to generate a Remote interface reference
  //----------------------------------------------------------------------------

  public GestionPlanComptable create() {
    long startTime = 0;
    if (logging) {
      log("Calling create()");
      startTime = System.currentTimeMillis();
    }
    try {
      gestionPlanComptable = gestionPlanComptableHome.create();
      if (logging) {
        long endTime = System.currentTimeMillis();
        log("Succeeded: create()");
        log("Execution time: " + (endTime - startTime) + " ms.");
      }
    }
    catch(Exception e) {
      if (logging) {
        log("Failed: create()");
      }
      e.printStackTrace();
    }

    if (logging) {
      log("Return value from create(): " + gestionPlanComptable + ".");
    }
    return gestionPlanComptable;
  }

  //----------------------------------------------------------------------------
  // Methods that use Remote interface methods to access data through the bean
  //----------------------------------------------------------------------------

  public String ajouterCompte(String c, String lib, String pc) {
    String returnValue = "";
    if (gestionPlanComptable == null) {
      System.out.println("Error in ajouterCompte(): " + ERROR_NULL_REMOTE);
      return returnValue;
    }
    long startTime = 0;
    if (logging) {
      log("Calling ajouterCompte(" + c + ", " + lib + ", " + pc + ")");
      startTime = System.currentTimeMillis();
    }

    try {
      returnValue = gestionPlanComptable.ajouterCompte(c, lib, pc);
      if (logging) {
        long endTime = System.currentTimeMillis();
        log("Succeeded: ajouterCompte(" + c + ", " + lib + ", " + pc + ")");
        log("Execution time: " + (endTime - startTime) + " ms.");
      }
    }
    catch(Exception e) {
      if (logging) {
        log("Failed: ajouterCompte(" + c + ", " + lib + ", " + pc + ")");
      }
      e.printStackTrace();
    }

    if (logging) {
      log("Return value from ajouterCompte(" + c + ", " + lib + ", " + pc + "): " + returnValue + ".");
    }
    return returnValue;
  }

  public String majCompte(String idCompte, String cpt, String lib, String pcpt) {
    String returnValue = "";
    if (gestionPlanComptable == null) {
      System.out.println("Error in majCompte(): " + ERROR_NULL_REMOTE);
      return returnValue;
    }
    long startTime = 0;
    if (logging) {
      log("Calling majCompte(" + idCompte + ", " + cpt + ", " + lib + ", " + pcpt + ")");
      startTime = System.currentTimeMillis();
    }

    try {
      returnValue = gestionPlanComptable.majCompte(idCompte, cpt, lib, pcpt);
      if (logging) {
        long endTime = System.currentTimeMillis();
        log("Succeeded: majCompte(" + idCompte + ", " + cpt + ", " + lib + ", " + pcpt + ")");
        log("Execution time: " + (endTime - startTime) + " ms.");
      }
    }
    catch(Exception e) {
      if (logging) {
        log("Failed: majCompte(" + idCompte + ", " + cpt + ", " + lib + ", " + pcpt + ")");
      }
      e.printStackTrace();
    }

    if (logging) {
      log("Return value from majCompte(" + idCompte + ", " + cpt + ", " + lib + ", " + pcpt + "): " + returnValue + ".");
    }
    return returnValue;
  }

  public Pcg[] findCompteTab(String idc, String cpt, String lib, String pcpt) {
    Pcg[] returnValue = null;
    if (gestionPlanComptable == null) {
      System.out.println("Error in findCompteTab(): " + ERROR_NULL_REMOTE);
      return returnValue;
    }
    long startTime = 0;
    if (logging) {
      log("Calling findCompteTab(" + idc + ", " + cpt + ", " + lib + ", " + pcpt + ")");
      startTime = System.currentTimeMillis();
    }

    try {
      returnValue = gestionPlanComptable.findCompteTab(idc, cpt, lib, pcpt);
      if (logging) {
        long endTime = System.currentTimeMillis();
        log("Succeeded: findCompteTab(" + idc + ", " + cpt + ", " + lib + ", " + pcpt + ")");
        log("Execution time: " + (endTime - startTime) + " ms.");
      }
    }
    catch(Exception e) {
      if (logging) {
        log("Failed: findCompteTab(" + idc + ", " + cpt + ", " + lib + ", " + pcpt + ")");
      }
      e.printStackTrace();
    }

    if (logging) {
      log("Return value from findCompteTab(" + idc + ", " + cpt + ", " + lib + ", " + pcpt + "): " + returnValue + ".");
    }
    return returnValue;
  }

  public String findCompteTxt(String idc, String cpt, String lib, String pcpt) {
    String returnValue = "";
    if (gestionPlanComptable == null) {
      System.out.println("Error in findCompteTxt(): " + ERROR_NULL_REMOTE);
      return returnValue;
    }
    long startTime = 0;
    if (logging) {
      log("Calling findCompteTxt(" + idc + ", " + cpt + ", " + lib + ", " + pcpt + ")");
      startTime = System.currentTimeMillis();
    }

    try {
      returnValue = gestionPlanComptable.findCompteTxt(idc, cpt, lib, pcpt);
      if (logging) {
        long endTime = System.currentTimeMillis();
        log("Succeeded: findCompteTxt(" + idc + ", " + cpt + ", " + lib + ", " + pcpt + ")");
        log("Execution time: " + (endTime - startTime) + " ms.");
      }
    }
    catch(Exception e) {
      if (logging) {
        log("Failed: findCompteTxt(" + idc + ", " + cpt + ", " + lib + ", " + pcpt + ")");
      }
      e.printStackTrace();
    }

    if (logging) {
      log("Return value from findCompteTxt(" + idc + ", " + cpt + ", " + lib + ", " + pcpt + "): " + returnValue + ".");
    }
    return returnValue;
  }

  //----------------------------------------------------------------------------
  // Utility Methods
  //----------------------------------------------------------------------------

  private void log(String message) {
    if (message == null) {
      System.out.println("-- null");
      return ;
    }
    if (message.length() > MAX_OUTPUT_LINE_LENGTH) {
      System.out.println("-- " + message.substring(0, MAX_OUTPUT_LINE_LENGTH) + " ...");
    }
    else {
      System.out.println("-- " + message);
    }
  }
  //Main method

  public static void main(String[] args) {
    GestionPlanComptableTestClient1 client = new GestionPlanComptableTestClient1();
    GestionPlanComptable gff= client.create();

 try{
   System.out.println("start");
/* FactureFournisseur[] ff=gff.findFactureFournisseur("%", "", "", "%", "%","%", "idFactureFournisseur", "ASC", "");
for (int i=0;i<ff.length;i++){
 System.out.println(ff[i].getidFactureFournisseur()+" - r"+ff[i].getidFournisseur());
}*/
//System.out.println(gff.ajouterCompte("0","root","0"));
/*System.out.println(gff.ajouterCompte("503","test","50"));
System.out.println(gff.ajouterCompte("5031","test","503"));
System.out.println(gff.ajouterCompte("5032","test","503"));
System.out.println(gff.ajouterCompte("5041","test","504"));*/
Pcg[] p=gff.findCompteTab("%","%","%", "503");
System.out.println(p.length);
System.out.println(gff.findCompteTxt("%","%","%","%"));
//System.out.println("lenght="+ff1.length);
for (int i=0;i<p.length;i++){
 System.out.println(p[i].getCOMPTE());
}
 System.out.println("test");
 }catch(Exception e){

   }

    // Use the client object to call one of the Home interface wrappers
    // above, to create a Remote interface reference to the bean.
    // If the return value is of the Remote interface type, you can use it
    // to access the remote interface methods.  You can also just use the
    // client object to call the Remote interface wrappers.
  }
}