/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ded;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import user.UserEJB;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class DedEjbClient {
    public static DedEjb getInterface()
        throws Exception
    {
        try {
            Context c = new InitialContext();
            return (DedEjb) c.lookup("java:module/DedEjbBean!ded.DedEjb");
        } catch (NamingException ne) {
//            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }
}
