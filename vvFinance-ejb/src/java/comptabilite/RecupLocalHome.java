package comptabilite;

import javax.naming.*;
import user.UserEJB;

public class RecupLocalHome
{

    public RecupLocalHome()
    {
    }

    public static UserEJB getInterface()
        throws Exception
    {
        try {
            Context c = new InitialContext();
            return (UserEJB) c.lookup("java:module/ComptabiliteEjbBean!comptabilite.ComptabiliteEjb");
        } catch (NamingException ne) {
//            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", ne);
            throw new RuntimeException(ne);
        }
    }
}
