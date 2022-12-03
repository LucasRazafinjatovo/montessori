package pointage;

import javax.ejb.*;
import java.util.*;

public interface PointageEjbLocal extends javax.ejb.EJBLocalObject {
  public String createPointage(String user, String daty, String heure, String type, String remarque, String ip, String agence,String machine) throws Exception;
  public Pointage[] findPointage(String idPointage, String user, String datyInf, String datySup, String heureInf, String heureSup, String type, String rem, String ip, String agence,String machine) throws Exception;
}