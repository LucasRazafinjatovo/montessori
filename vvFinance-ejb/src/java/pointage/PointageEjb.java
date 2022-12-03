package pointage;

import javax.ejb.*;
import java.util.*;
import java.rmi.*;

public interface PointageEjb extends javax.ejb.EJBObject {
  public String createPointage(String user, String daty, String heure, String type, String remarque, String ip, String agence,String machine) throws Exception;
  public Pointage[] findPointage(String idPointage, String user, String datyInf, String datySup, String heureInf, String heureSup, String type, String rem, String ip, String agence,String machine) throws Exception;
}