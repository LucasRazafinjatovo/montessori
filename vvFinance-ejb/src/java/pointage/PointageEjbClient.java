/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pointage;

import facturefournisseur.GestionFactureFournisseur;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class PointageEjbClient {
    public static PointageEjb getInterface()
        throws Exception
    {
        try {
            Context c = new InitialContext();
            return (PointageEjb) c.lookup("java:module/PointageEjbBean!pointage.PointageEjb");
        } catch (NamingException ne) {
//            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }
}
