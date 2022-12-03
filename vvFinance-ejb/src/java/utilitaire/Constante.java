package utilitaire;

public class Constante {

  private static String urlStock = "http://192.168.0.108:8080/stock/index.jsp";
  private static String urlPaie = "http://192.168.0.42:8080/paie/index.jsp";
  private static String idTypeLCRecette = "TLC00001";
  private static String idTypeLCDepense = "TLC00002";
  public static String idRoleDirecteur = "directeur";
  public static String idRoleUtilisateur = "utilisateur";
  public static String idRoleAdmin = "admin";
  public static String idRoleAdminFacture = "adminFacture";
  public static String idRoleAdminCompta = "compta";
  public static String idRoleDg = "dg";
  public static String errorFileName = "error.txt";
  public static double tauxSansRemiseCommercial = 0.1;
  public static double tauxSansRemiseDComm = 0.03;
  public static double tauxAvecRemiseCommercial = 0.05;
  public static double tauxCommissionLiliane = 0.05;

  public static String idRoleSaisie = "saisie";
  public static String tableOpFfLc="OpFfLc";
  public static final String[] typeCloture={"caisse","invendu","prise"};
  private static String mois[] = {"Janvier","Février","Mars","Avril","Mai","Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre"};
  private static String moisRang[] = {"1","2","3","4","5","6", "7", "8", "9", "10", "11", "12"};
  private static String objetDepense="depense";
  private static String objetRecette="recette";
  private static String objetFacture="facture";
  private static String objetFactureF="factureF";
  static private String tableRecetteLC="recettesLC";
  static private String tableFactureLC="factureLigneCredit";
  static private String tableFactureFLC="FactureFournisseurLC";
  static private String tableDepenseLC="sortieFF";
  private static String idFournAuto="clt1";
  static private String objFactureProf="FactureProfFournisseur";
  static private String objetBc="BC";
  static private String objetCDetailFactProf="detFactProf";
  static private String objetDetailBC="detBC";
  static private String objetDetailFactFourn="detFactF";
  static private String dedFactProfFourn="DedFACTUREProfFOURNISSEUR";
  static private String DetailLcCree="0";
  static private String DetailLcValide="1";
  static private String objetDedBc="DedBc";
  static private String objetLcDetMvt="LcDetailMvtCaisse";
  static private String objetLcDetDed="LcDetailDed";
  static private String objetLcDetOp="LcDetailop";
  static private String objetOpFf="OPFACTUREFOURNISSEUR";
  static private String objetDed="ded";
  static private String objetOp="ORDONNERPAYEMENT";
  static private String objetOr="ORDONNERRECETTE";
  static private String objetLcDetail="LcDetails";
  static  private String tableDetailBC="detailBC";
  private static String objetMvtCaisse="mvtCaisse";
  static  private String objectDetailFPF="detailFPF";
  public static String objetFactureFournisseur="FactureFournisseur";
  static private String opFactureFournisseur="OPFACTUREFOURNISSEUR";
  static private String orFactureFournisseur="ORFACTUREFOURNISSEUR";
  static private String objetLigneCredit="LigneCredit";
  static private String objetLigneCreditRecette="LigneCreditRecette";
  static private String visaOp="VISAORDREPAYEMENT";
  static private String visaOr="VISAOR";
  static public String typeOpFacture="facture";
  static public String typeOpNormale="normale";
  static public String tableVisaOp="VISAORDREPAYEMENT";
  static public String objetFactureClient="FACTURECLIENT";
  public static String tableOrFcLc="ORFCLC";
  static public String tableFactureCLC="FactureClientLC";
  static public String factureClient="FACTURECLIENT";
        public static String getIdTypeLCDepense() {
                return idTypeLCDepense;
	}
        public static String getDetailLcCree() {
                        return DetailLcCree;
	}
	public static String getDetailLcValide() {
		return DetailLcValide;
	}
	public static String getIdTypeLCRecette() {
		return idTypeLCRecette;
	}
	public static String getIdRoleDirecteur() {
		return idRoleDirecteur;
	}
  public static String[] getMois() {
    return mois;
  }
  public static String[] getMoisRang() {
    return moisRang;
  }

  public static String getObjetDepense() {
    return objetDepense;
  }
  public static String getObjetRecette() {
    return objetRecette;
  }

  public static String getObjetFacture() {
    return objetFacture;
  }

  public static String getObjetFactureF() {
    return objetFactureF;
  }

  public static String getTableRecetteLC() {
    return tableRecetteLC;
  }

  public static String getTableFactureLC() {
    return tableFactureLC;
  }

  public static String getTableFactureFLC() {
    return tableFactureFLC;
  }

  public static String getTableDepenseLC() {
    return tableDepenseLC;
  }
  public  static String getIdFournAuto() {
    return idFournAuto;
  }

  public static  String getObjFactureProf() {
    return objFactureProf;
  }

  public static  String getObjetBc() {
    return objetBc;
  }
  public static  String getObjetCDetailFactProf() {
    return objetCDetailFactProf;
  }

  public static  String getObjetDetailBC() {
    return objetDetailBC;
  }
  public static  String getObjetDetailFactFourn() {
    return objetDetailFactFourn;
  }
  public static String getDedFactProfFourn() {
    return dedFactProfFourn;
  }
  public static void setObjetDedBc(String objetDedBce) {
    objetDedBc = objetDedBce;
  }
  public static String getObjetDedBc() {
    return objetDedBc;
  }
  public static void setObjetLcDetMvt(String objetLcDetMvte) {
    objetLcDetMvt = objetLcDetMvte;
  }
  public static String getObjetLcDetMvt() {
    return objetLcDetMvt;
  }

  public static String getObjetLcDetDed() {
    return objetLcDetDed;
  }

  public static String getObjetLcDetOp() {
    return objetLcDetOp;
  }

  public static String getObjetOpFf() {
    return objetOpFf;
  }

  public static String getObjetOr() {
    return objetOr;
  }

  public static String getObjetDed() {
    return objetDed;
  }

  public static String getObjetOp() {
    return objetOp;
  }

  public static String getObjetLcDetail() {
    return objetLcDetail;
  }
  public static String getTableDetailBC() {
    return tableDetailBC;
  }
  public static String getObjetMvtCaisse() {
    return objetMvtCaisse;
  }
  public static String getObjectDetailFPF() {
    return objectDetailFPF;
  }
  public static String getObjetFactureFournisseur() {
    return objetFactureFournisseur;
  }
  public static String getOpFactureFournisseur() {
    return opFactureFournisseur;
  }
  public static String getOrFactureFournisseur() {
    return orFactureFournisseur;
  }

  public static String getObjetLigneCredit() {
    return objetLigneCredit;
  }

  public static  String getObjetLigneCreditRecette() {
    return objetLigneCreditRecette;
  }

  public static String getVisaOp() {
    return visaOp;
  }

  public static String getVisaOr() {
    return visaOr;
  }
  public static String getUrlPaie() {
    return urlPaie;
  }
  public static String getUrlStock() {
    return urlStock;
  }

}
