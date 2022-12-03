package comptabilite;

import bean.ClassEjb;
import javax.ejb.*;

public class ComptabiliteBean extends ClassEjb implements SessionBean
{
      SessionContext sessionContext;

    public ComptabiliteBean()
    {
    }

    public void ejbCreate()
        throws CreateException
    {
    }

    public void ejbRemove()
    {
    }

    public void ejbActivate()
    {
    }

    public void ejbPassivate()
    {
    }

    public void setSessionContext(SessionContext sessionContext)
    {
        this.sessionContext = sessionContext;
    }
}
