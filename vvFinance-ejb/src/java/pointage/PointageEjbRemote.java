/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pointage;

import javax.ejb.EJBObject;
import javax.ejb.Remote;

/**
 *
 * @author anthonyandrianaivoravelona
 */
@Remote
public interface PointageEjbRemote extends EJBObject{
    public String createPointage(String user, String daty, String heure, String type, String remarque, String ip, String agence,String machine) throws Exception;
  public Pointage[] findPointage(String idPointage, String user, String datyInf, String datySup, String heureInf, String heureSup, String type, String rem, String ip, String agence,String machine) throws Exception;
}
