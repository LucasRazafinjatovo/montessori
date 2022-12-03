/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stock;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import pcg.GestionPlanComptable;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class StockEjbClient {
    public static StockEjb getInterface()
        throws Exception
    {
        try {
            Context c = new InitialContext();
            return (StockEjb) c.lookup("java:module/StockEjbBean!stock.StockEjb");
        } catch (NamingException ne) {
//            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exceptihon caught", ne);
            throw new RuntimeException(ne);
        }
    }
}
