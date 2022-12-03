/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package facturefournisseur;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import penalite.PenaliteEjb;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class GestionFactureFournisseurClient {
    public static GestionFactureFournisseur getInterface()
        throws Exception
    {
        try {
            Context c = new InitialContext();
            return (GestionFactureFournisseur) c.lookup("java:module/GestionFactureFournisseurBean!facturefournisseur.GestionFactureFournisseur");
        } catch (NamingException ne) {
//            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }
}
