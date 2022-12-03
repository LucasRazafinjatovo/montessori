package utilitaire;

import java.beans.*;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ConstanteRecette {

  static private String lcrecette="LigneCreditRecette";
  static private String lcRecetteOr="LCDETAILRECETTEOR";
  static private String lcRecetteMvt="LCDETAILRECETTEMVTCAISSE";
  static private String lcDetailRecette="LCDETAILSRECETTE";
  static private String or="ORDONNERRECETTE";
  static private String visaOr="VISAOR";
  static private String orFacture="orFacture";
  public ConstanteRecette() {
  }
  public static String getLcrecette() {
    return lcrecette;
  }
  public static String getLcRecetteOr() {
    return lcRecetteOr;
  }

  public static String getLcRecetteMvt() {
    return lcRecetteMvt;
  }
  public static String getLcDetailRecette() {
    return lcDetailRecette;
  }

  public static String getOr() {
    return or;
  }
  public static String getVisaOr() {
    return visaOr;
  }
  public static String getOrFacture() {
    return orFacture;
  }
}