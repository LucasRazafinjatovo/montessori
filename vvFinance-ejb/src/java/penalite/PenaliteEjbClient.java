/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package penalite;

import ded.DedEjb;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 *
 * @author anthonyandrianaivoravelona
 */
public class PenaliteEjbClient {
    public static PenaliteEjb getInterface()
        throws Exception
    {
        try {
            Context c = new InitialContext();
            return (PenaliteEjb) c.lookup("java:module/PenaliteBean!penalite.PenaliteEjb");
        } catch (NamingException ne) {
//            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }
}
