<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="finance/listeSortie.jsp";
        String lien= null;
        UserEJB u = null;
        String designation="";
        String nomCol[]=null;
        String mois[] = Constante.getMois();
         String moisRang[] = Constante.getMoisRang();
        TypeObjet source[] = null;
        TypeObjet tlc[] = null;    //type ligne credit
        TypeObjet compte[] =null; //compte compta
                Direction dir[] = null;
        LigneCreditComplet lcc[]= null;
        String idLC = "";
        String idType = "";
        int anneeEnCours = Utilitaire.getAneeEnCours();
        String annee = null;
        String direction = null;
        String entite = null;
        String ordre = null;
                String numCompte = null;
                String colonne = null;
                String mois2=null;
                String mois1=null;
                String sender=null;

                int pazy=0;
           int nbParPazy=Parametre.getNbParPage();
           int indiceDebut=0;
           int indiceFin=Parametre.getNbParPage();
           int nbPage=0;
%>
<%
  sender = request.getParameter("sender");if ((sender==null)||sender.compareTo("")==0) sender="LC";
  nomCol=Utilitaire.getNomColonne(new LigneCredit());
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idLC=request.getParameter("idLC");if ((idLC==null)||idLC.compareTo("")==0) idLC="%";
  direction=request.getParameter("direction");if ((direction==null)||direction.compareTo("")==0) direction="%";
  entite=request.getParameter("entite");if ((entite==null)||entite.compareTo("")==0) entite="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
  numCompte=request.getParameter("numCompte");if ((numCompte==null)||numCompte.compareTo("")==0) numCompte="%";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne="idLigne";
  mois1=request.getParameter("mois1");if ((mois1==null)||mois1.compareTo("")==0) mois1= "1";
  mois2=request.getParameter("mois");if ((mois2==null)||mois2.compareTo("")==0) mois2= "12";
  annee = request.getParameter("annee");if ((annee==null)||annee.compareTo("")==0) annee=String.valueOf(anneeEnCours);
  idType=request.getParameter("idType");
  if(sender.compareToIgnoreCase("LC")==0)
          if ((idType==null)||idType.compareTo("")==0) idType="%";
  if(sender.compareToIgnoreCase("entree")==0) idType="Recette";
  if(sender.compareToIgnoreCase("sortie")==0) idType="Dépense";

  if (request.getParameter("pazy")==null)
  {
    pazy=1;
  }
  else
  {
    pazy= Utilitaire.stringToInt(request.getParameter("pazy"));
  }

 %>
<%

try{
   UserEJBClient uc=new UserEJBClient();
u=uc.getInterface();
                u.testLogin("dg","dgxdg");
                //String visa=u.annulerMvtDepense ("MVT000030");
                //out.println("Visa = "+visa);
                ded.DedEssai[] de=(ded.DedEssai[])new ded.DedEssaiUtil().rechercher(1,"%");
                System.out.println("Le nombre d'enreg "+de.length+" l id ="+de[0].getId() );
               //System.out.println("Taille ut "+ut.length+ " ut id="+ut[0].getId()+" id mappage= SFF000029");

}
catch (Exception e){
  e.printStackTrace();
  return;
}
%>

