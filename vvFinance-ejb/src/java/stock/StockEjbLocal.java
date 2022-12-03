package stock;

import javax.ejb.*;
import java.util.*;
import pub.Parution;
public interface StockEjbLocal extends javax.ejb.EJBLocalObject {
  public String creerMvtStock(String design, String type, String debit, String credit, String compte, String unite, String rmq, String refUser) throws Exception;
  public String creerDossier(String idMvt, String typeDossier, String design, String num, String daty, String tiers, String qte, String mont, String rmq, String refUser) throws Exception;
  public String updateDossier(String id, String idMvt, String typeDossier, String design, String num, String daty, String tiers, String qte, String mont, String rmq, String refUser) throws Exception;
  public String creerDetailBobine(String numBob, String poids, String idMvt, String refUser) throws Exception;
  public String creerParution(String journal, String numP, String datyP, String nbpage, String nbex, String poids, String printer, String idMvt, String rmq, String refUser) throws Exception;
  public String creerLettrageMvt(String parent, String fille, String rmq, String refUser) throws Exception;
  public String creerVerification(String mag, String reste, String unite, String controleur, String rmq, String refUser) throws Exception;
  public String creerDetailVerifi(String numBob, String pourcentage, String verif, String rmq, String refUser) throws Exception;
  public MvtStock[] findMvtStock(String idMvt, String datyInf, String datySup, String typeMvt, String compte) throws Exception;
  public Dossier[] findDossier(String id, String idMvt, String typeDossier, String datyInf, String datySup) throws Exception;
  public DetailBobinePoids[] findDetailBobine(String id, String numBobine, String idMvt) throws Exception;
  public Parution[] findParution(String id, String datyInf, String datySup, String journal, String datyParInf, String datyParSup, String printer, String idMvt) throws Exception;
  public double calculQte(String nbPage, String nbEx, String poids) throws Exception;
  public LettrageMvt[] findLettrageMvt(String id, String parent, String fille) throws Exception;
  public Verification[] findVerification(String id, String datyInf, String datySup, String mag, String controleur) throws Exception;
  public DetailVerif[] findDetailVerif(String id, String numBob, String idVerif) throws Exception;
  public String faireMvtStock(String design, String type, String debitS, String creditS, String debitD, String creditD, String compteS, String compteD, String unite, String rmq, String refUser) throws Exception;
  public String enleverDetailBobine(String id, String refUser) throws Exception;
  public String enleverDossier(String idDossier, String refUser) throws Exception;
  public MvtCompte[] findMvtCompte(String idMvt, String datyInf, String datySup, String typeMvt, String compte, String val, String desce) throws Exception;
  public MvtBobine[] findMvtBobine(String idMvt, String datyInf, String datySup, String typeMvt, String compte, String numB) throws Exception;
}