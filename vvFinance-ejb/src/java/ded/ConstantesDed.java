package ded;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class ConstantesDed {

  private static String suffDedLcDet="DLD";
  private static String tableDedLcDet="LCDETAILDED";
  private static  String fonctDedLcDet="GetSEqDedLcDet";
  private static  String suffOpLcDet="OLD";
  private static  String fonctOpLcDet="GetSeqOld";
  private static  String tableOpLcDet="LCDETAILOP";
  private static  String suffMvtLcDet="MLD";
  private static  String tableMvtLcDet="LCDETAILMVTCAISSE";
  private static  String fonctMvtLcDet="getSeqMvtDet";
  private String tableDedLc;
  public ConstantesDed() {
  }
  public static  String getSuffDedLcDet() {
    return suffDedLcDet;
  }

  public static  String getTableDedLcDet() {
    return tableDedLcDet;
  }

  public static  String getFonctDedLcDet() {
    return fonctDedLcDet;
  }

  public static  String getSuffOpLcDet() {
    return suffOpLcDet;
  }

  public static  String getFonctOpLcDet() {
    return fonctOpLcDet;
  }
  public static  String getTableOpLcDet() {
    return tableOpLcDet;
  }

  public static  String getSuffMvtLcDet() {
    return suffMvtLcDet;
  }

  public static  String getTableMvtLcDet() {
    return tableMvtLcDet;
  }

  public static  String getFonctMvtLcDet() {
    return fonctMvtLcDet;
  }
  public void setTableDedLc(String tableDedLc) {
    this.tableDedLc = tableDedLc;
  }
  public String getTableDedLc() {
    return tableDedLc;
  }
}