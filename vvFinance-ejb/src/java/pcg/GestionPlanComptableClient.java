/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pcg;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class GestionPlanComptableClient {
    public static GestionPlanComptable getInterface()
        throws Exception
    {
        try {
            Context c = new InitialContext();
            return (GestionPlanComptable) c.lookup("java:module/GestionPlanComptableBean!pcg.GestionPlanComptable");
        } catch (NamingException ne) {
//            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exceptihon caught", ne);
            throw new RuntimeException(ne);
        }
    }
}
