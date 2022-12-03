/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comptabilite;

import comptabilite.ComptabiliteEjb;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 *
 * @author Murielle
 */
public class ComptabiliteEjbClient {
    public static ComptabiliteEjb getInterface()
        throws Exception
    {
        try {
            Context c = new InitialContext();
            return (ComptabiliteEjb) c.lookup("java:module/ComptabiliteEjbBean!comptabilite.ComptabiliteEjb");
        } catch (NamingException ne) {
            throw new RuntimeException(ne);
        }
    }
}
