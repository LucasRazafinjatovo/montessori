package pcg;

import javax.ejb.*;
import java.util.*;

public interface GestionPlanComptableLocal extends javax.ejb.EJBLocalObject{
  public String ajouterCompte(String c, String lib, String pc);
  public String majCompte(String idCompte, String cpt, String lib, String pcpt) throws Exception;
  public Pcg[] findCompteTab(String idc, String cpt, String lib, String pcpt) throws Exception;
  public String findCompteTxt(String idc, String cpt, String lib, String pcpt) throws Exception;
}