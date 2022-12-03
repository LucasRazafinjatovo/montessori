// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   RedevanceEjb.java

package redevance;

import bean.ClassMAPTable;
import historique.MapUtilisateur;
import java.rmi.RemoteException;
import javax.ejb.EJBObject;

public interface RedevanceEjb
    extends EJBObject
{

    public abstract int create(ClassMAPTable classmaptable, MapUtilisateur maputilisateur)
        throws RemoteException, Exception;

    public abstract int update(ClassMAPTable classmaptable, MapUtilisateur maputilisateur)
        throws RemoteException, Exception;

    public abstract int delete(ClassMAPTable classmaptable, MapUtilisateur maputilisateur)
        throws RemoteException, Exception;
}
