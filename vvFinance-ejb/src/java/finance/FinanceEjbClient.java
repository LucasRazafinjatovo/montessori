/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package finance;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class FinanceEjbClient {
    public static FinanceEjb getInterface()
        throws Exception
    {
        try {
            Context c = new InitialContext();
            return (FinanceEjb) c.lookup("java:module/FinanceBean!finance.FinanceEjb");
        } catch (NamingException ne) {
//            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }
}
