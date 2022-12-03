/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package lc;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class LCEjbClient {
    public static LCEjb getInterface()
        throws Exception
    {
        try {
            Context c = new InitialContext();
            return (LCEjb) c.lookup("java:module/LCEjbBean!lc.LCEjb");
        } catch (NamingException ne) {
//            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }
}
