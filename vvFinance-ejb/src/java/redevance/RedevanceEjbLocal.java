// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   RedevanceEjbLocal.java

package redevance;

import bean.ClassMAPTable;
import historique.MapUtilisateur;
import javax.ejb.EJBLocalObject;

public interface RedevanceEjbLocal
    extends EJBLocalObject
{

    public abstract int create(ClassMAPTable classmaptable, MapUtilisateur maputilisateur)
        throws Exception;

    public abstract int update(ClassMAPTable classmaptable, MapUtilisateur maputilisateur)
        throws Exception;

    public abstract int delete(ClassMAPTable classmaptable, MapUtilisateur maputilisateur)
        throws Exception;
}
