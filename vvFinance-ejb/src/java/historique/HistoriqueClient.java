/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package historique;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import user.UserEJB;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class HistoriqueClient {
    public static Historique getInterface()
        throws Exception
    {
    try {
            Context c = new InitialContext();
            return (Historique) c.lookup("java:module/HistoriqueBean!historique.Historique");
        } catch (NamingException ne) {
//            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }
}
