/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pcg;

import javax.ejb.EJBObject;
import javax.ejb.Remote;

/**
 *
 * @author anthonyandrianaivoravelona
 */
@Remote
public interface GestionPlanComptableRemote extends EJBObject{
    public String ajouterCompte(String c, String lib, String pc);
  public String majCompte(String idCompte, String cpt, String lib, String pcpt) throws Exception;
  public Pcg[] findCompteTab(String idc, String cpt, String lib, String pcpt) throws Exception;
  public String findCompteTxt(String idc, String cpt, String lib, String pcpt) throws Exception;
}
