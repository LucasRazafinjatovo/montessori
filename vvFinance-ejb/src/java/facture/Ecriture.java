// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   Ecriture.java

package facture;

import bean.ClassMAPTable;
import java.sql.Date;

public class Ecriture extends ClassMAPTable
{

    public Ecriture(Date daty, String compte, String libelle, double debit, double credit, 
            String piece, String idEcriture)
    {
        setNomTable("Ecriture");
        setDaty(daty);
        setCompte(compte);
        setLibelle(libelle);
        setDebit(debit);
        setCredit(credit);
        setPiece(piece);
        setIdEcriture(idEcriture);
    }

    public Ecriture(Date daty, String compte, String libelle, double debit, double credit, 
            String piece)
    {
        setNomTable("Ecriture");
        setDaty(daty);
        setCompte(compte);
        setLibelle(libelle);
        setDebit(debit);
        setCredit(credit);
        setPiece(piece);
        setIndicePk("Ecr");
        setNomProcedureSequence("GetSeqEcriture");
        setIdEcriture(makePK());
    }

    public String getAttributIDName()
    {
        return "idEcriture";
    }

    public String getTuppleID()
    {
        return idEcriture;
    }

    public void setDaty(Date daty)
    {
        this.daty = daty;
    }

    public Date getDaty()
    {
        return daty;
    }

    public void setCompte(String compte)
    {
        this.compte = compte;
    }

    public String getCompte()
    {
        return compte;
    }

    public void setLibelle(String libelle)
    {
        this.libelle = libelle;
    }

    public String getLibelle()
    {
        return libelle;
    }

    public void setDebit(double debit)
    {
        this.debit = debit;
    }

    public double getDebit()
    {
        return debit;
    }

    public void setCredit(double credit)
    {
        this.credit = credit;
    }

    public double getCredit()
    {
        return credit;
    }

    public void setPiece(String piece)
    {
        this.piece = piece;
    }

    public String getPiece()
    {
        return piece;
    }

    public void setIdEcriture(String idEcriture)
    {
        this.idEcriture = idEcriture;
    }

    public String getIdEcriture()
    {
        return idEcriture;
    }

    public Date daty;
    public String compte;
    public String libelle;
    public String piece;
    public String idEcriture;
    public double credit;
    public double debit;
}
