package historique;

import javax.naming.*;
import javax.rmi.PortableRemoteObject;

public class HistoriqueEJBClient {
  private HistoriqueHome historiqueHome = null;

  //Construct the EJB test client
  public HistoriqueEJBClient() {
    try {
      //get naming context
      Context ctx = new InitialContext();

      //look up jndi name
      Object ref = ctx.lookup("HistoriqueVV");

      //cast to Home interface
      historiqueHome = (HistoriqueHome) PortableRemoteObject.narrow(ref, HistoriqueHome.class);
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }

  //----------------------------------------------------------------------------
  // Utility Methods
  //----------------------------------------------------------------------------

  public HistoriqueHome getHome() {
    return historiqueHome;
  }
}
