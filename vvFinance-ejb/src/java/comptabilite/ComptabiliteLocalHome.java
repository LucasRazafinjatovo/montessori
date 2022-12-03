package comptabilite;

import javax.ejb.CreateException;
import javax.ejb.EJBLocalHome;

public interface ComptabiliteLocalHome
    extends EJBLocalHome
{

    public abstract ComptabiliteEjbLocal create()
        throws CreateException;
}
