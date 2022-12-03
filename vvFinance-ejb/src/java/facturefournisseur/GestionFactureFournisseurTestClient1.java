package facturefournisseur;

import javax.naming.*;
import javax.rmi.PortableRemoteObject;

public class GestionFactureFournisseurTestClient1 {
  static final private String ERROR_NULL_REMOTE = "Remote interface reference is null.  It must be created by calling one of the Home interface methods first.";
  static final private int MAX_OUTPUT_LINE_LENGTH = 100;
  private boolean logging = true;
  private GestionFactureFournisseurHome gestionFactureFournisseurHome = null;
  private GestionFactureFournisseur gestionFactureFournisseur = null;

  //Construct the EJB test client
  public GestionFactureFournisseurTestClient1() {
    long startTime = 0;
    if (logging) {
      log("Initializing bean access.");
      startTime = System.currentTimeMillis();
    }

    try {
      //get naming context
      Context ctx = new InitialContext();

      //look up jndi name
      Object ref = ctx.lookup("GestionFactureFournisseur");

      //cast to Home interface
      gestionFactureFournisseurHome = (GestionFactureFournisseurHome) PortableRemoteObject.narrow(ref, GestionFactureFournisseurHome.class);
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

  public GestionFactureFournisseur create() {
    long startTime = 0;
    if (logging) {
      log("Calling create()");
      startTime = System.currentTimeMillis();
    }
    try {
      gestionFactureFournisseur = gestionFactureFournisseurHome.create();
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
      log("Return value from create(): " + gestionFactureFournisseur + ".");
    }
    return gestionFactureFournisseur;
  }

  //----------------------------------------------------------------------------
  // Methods that use Remote interface methods to access data through the bean
  //----------------------------------------------------------------------------

  public String creerFactureFournisseur(String designation, String dE, String dR, String idFrns, String mTHT, String idTVA, String mTTC, String rmq, String idP, String etat, String idDevise) {
    String returnValue = "";
    if (gestionFactureFournisseur == null) {
      System.out.println("Error in creerFactureFournisseur(): " + ERROR_NULL_REMOTE);
      return returnValue;
    }
    long startTime = 0;
    if (logging) {
      log("Calling creerFactureFournisseur(" + designation + ", " + dE + ", " + dR + ", " + idFrns + ", " + mTHT + ", " + idTVA + ", " + mTTC + ", " + rmq + ", " + idP + ", " + etat + ", " + idDevise + ")");
      startTime = System.currentTimeMillis();
    }

    try {
      //returnValue = gestionFactureFournisseur.creerFactureFournisseur(designation,designation, dE, dR, idFrns, mTHT, idTVA, mTTC, rmq, idP, etat, idDevise);
      if (logging) {
        long endTime = System.currentTimeMillis();
        log("Succeeded: creerFactureFournisseur(" + designation + ", " + dE + ", " + dR + ", " + idFrns + ", " + mTHT + ", " + idTVA + ", " + mTTC + ", " + rmq + ", " + idP + ", " + etat + ", " + idDevise + ")");
        log("Execution time: " + (endTime - startTime) + " ms.");
      }
    }
    catch(Exception e) {
      if (logging) {
        log("Failed: creerFactureFournisseur(" + designation + ", " + dE + ", " + dR + ", " + idFrns + ", " + mTHT + ", " + idTVA + ", " + mTTC + ", " + rmq + ", " + idP + ", " + etat + ", " + idDevise + ")");
      }
      e.printStackTrace();
    }

    if (logging) {
      log("Return value from creerFactureFournisseur(" + designation + ", " + dE + ", " + dR + ", " + idFrns + ", " + mTHT + ", " + idTVA + ", " + mTTC + ", " + rmq + ", " + idP + ", " + etat + ", " + idDevise + "): " + returnValue + ".");
    }
    return returnValue;
  }

  public String cloturerFactureFournisseur(String designation, String dE, String dR, String idFrns, String mTHT, String idTVA, String mTTC, String rmq, String idP, String etat, String idDevise) {
    String returnValue = "";
    if (gestionFactureFournisseur == null) {
      System.out.println("Error in cloturerFactureFournisseur(): " + ERROR_NULL_REMOTE);
      return returnValue;
    }
    long startTime = 0;
    if (logging) {
      log("Calling cloturerFactureFournisseur(" + designation + ", " + dE + ", " + dR + ", " + idFrns + ", " + mTHT + ", " + idTVA + ", " + mTTC + ", " + rmq + ", " + idP + ", " + etat + ", " + idDevise + ")");
      startTime = System.currentTimeMillis();
    }

    try {
      returnValue = gestionFactureFournisseur.cloturerFactureFournisseur(designation, dE, dR, idFrns, mTHT, idTVA, mTTC, rmq, idP, etat, idDevise);
      if (logging) {
        long endTime = System.currentTimeMillis();
        log("Succeeded: cloturerFactureFournisseur(" + designation + ", " + dE + ", " + dR + ", " + idFrns + ", " + mTHT + ", " + idTVA + ", " + mTTC + ", " + rmq + ", " + idP + ", " + etat + ", " + idDevise + ")");
        log("Execution time: " + (endTime - startTime) + " ms.");
      }
    }
    catch(Exception e) {
      if (logging) {
        log("Failed: cloturerFactureFournisseur(" + designation + ", " + dE + ", " + dR + ", " + idFrns + ", " + mTHT + ", " + idTVA + ", " + mTTC + ", " + rmq + ", " + idP + ", " + etat + ", " + idDevise + ")");
      }
      e.printStackTrace();
    }

    if (logging) {
      log("Return value from cloturerFactureFournisseur(" + designation + ", " + dE + ", " + dR + ", " + idFrns + ", " + mTHT + ", " + idTVA + ", " + mTTC + ", " + rmq + ", " + idP + ", " + etat + ", " + idDevise + "): " + returnValue + ".");
    }
    return returnValue;
  }

  public FactureFournisseur[] findFactureFournisseur(String num, String dateDebut, String dateFin, String fournisseur, String projet, String etat, String colonne, String ordre, String apresW) {
    FactureFournisseur[] returnValue = null;
    if (gestionFactureFournisseur == null) {
      System.out.println("Error in findFactureFournisseur(): " + ERROR_NULL_REMOTE);
      return returnValue;
    }
    long startTime = 0;
    if (logging) {
      log("Calling findFactureFournisseur(" + num + ", " + dateDebut + ", " + dateFin + ", " + fournisseur + ", " + projet + ", " + etat + ", " + colonne + ", " + ordre + ", " + apresW + ")");
      startTime = System.currentTimeMillis();
    }

    try {
      //returnValue = gestionFactureFournisseur.findFactureFournisseur(num, dateDebut, dateFin, fournisseur, projet, etat, colonne, ordre, apresW);
      if (logging) {
        long endTime = System.currentTimeMillis();
        log("Succeeded: findFactureFournisseur(" + num + ", " + dateDebut + ", " + dateFin + ", " + fournisseur + ", " + projet + ", " + etat + ", " + colonne + ", " + ordre + ", " + apresW + ")");
        log("Execution time: " + (endTime - startTime) + " ms.");
      }
    }
    catch(Exception e) {
      if (logging) {
        log("Failed: findFactureFournisseur(" + num + ", " + dateDebut + ", " + dateFin + ", " + fournisseur + ", " + projet + ", " + etat + ", " + colonne + ", " + ordre + ", " + apresW + ")");
      }
      e.printStackTrace();
    }

    if (logging) {
      log("Return value from findFactureFournisseur(" + num + ", " + dateDebut + ", " + dateFin + ", " + fournisseur + ", " + projet + ", " + etat + ", " + colonne + ", " + ordre + ", " + apresW + "): " + returnValue + ".");
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
    GestionFactureFournisseurTestClient1 client = new GestionFactureFournisseurTestClient1();
    GestionFactureFournisseur gff= client.create();

  try{
    System.out.println("start");
 /* FactureFournisseur[] ff=gff.findFactureFournisseur("%", "", "", "%", "%","%", "idFactureFournisseur", "ASC", "");
for (int i=0;i<ff.length;i++){
  System.out.println(ff[i].getidFactureFournisseur()+" - r"+ff[i].getidFournisseur());
}*/
//Fournisseur ff1=gff.findFournisseurFact("F000006","%","%","%","%","%","%","")[0];
//System.out.println("lenght="+ff1.length);
/*for (int i=0;i<ff1.length;i++){
  System.out.println(ff1[i].getnomFournisseur());
}*/
//System.out.println(ff1.getnomFournisseur());
  System.out.println("test");
  }catch(Exception e){

   }
    // Use the client object to call one of the Home interface wrappers
    // aboveqsdfqsfsqdfsdfdf, to create a Remote interface reference to the bean.
    // If the return value is of the Remote interface type, you can use it
    // to access the remote interface methods.  You can also just use the
    // client object to call the Remote interface wrappers.
  }
}