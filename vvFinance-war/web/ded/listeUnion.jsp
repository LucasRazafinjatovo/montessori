<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="lc/listeSortie.jsp";
        String lien= null;
        UserEJB u = null;
        String designation=null;
        Caisse caiss[] = null;
        Sortie sort[]= null;
        TypeObjet dev[] = null;
        TypeObjet mp[] =null;
        TypeObjet te[] = null;
        String idType = null;
        String caisse=null;
        String idModePaiement = null;
        String idDevise = null;
        String idDepense = null;
        String dateDebut=null;
        String dateFin=null;
        String parution=null;
        String agence=null;
        String idLigne=null;
        historique.MapUtilisateur ut=null;
        TypeObjet ben=null;
        int pazy=0;
        double sommePage=0;
        int nbParPazy=Parametre.getNbParPage();
                int indiceDebut=0;
                int indiceFin=Parametre.getNbParPage();
                int nbPage=0;
                String projet, partenaire, facture;
        String colonne,ordre;
        String nomCol[]=null;
        String devise=null;
                TypeObjet ag[] =null;
%>
<%
  nomCol=Utilitaire.getNomColonne(new Sortie());
  designation=request.getParameter("designation");if ((designation==null)||designation.compareTo("")==0) designation="%";
  idType=request.getParameter("idType");if ((idType==null)||idType.compareTo("")==0) idType="%";
  caisse=request.getParameter("caisse");if ((caisse==null)||caisse.compareTo("")==0) caisse="%";
  //devise=request.getParameter("devise");if ((devise==null)||devise.compareTo("")==0) devise="%";
  parution=request.getParameter("parution");if ((parution==null)||parution.compareTo("")==0) parution="%";
  agence=request.getParameter("agence");if ((agence==null)||agence.compareTo("")==0) agence="%";
  idModePaiement=request.getParameter("idModePaiement");if ((idModePaiement==null)||idModePaiement.compareTo("")==0) idModePaiement="%";
  idDepense=request.getParameter("idDepense");if ((idDepense==null)||idDepense.compareTo("")==0) idDepense="%";
  idLigne = request.getParameter("idLigne");if ((idLigne==null)||idLigne.compareTo("")==0) idLigne="%";
  dateDebut=request.getParameter("datyInf");if ((dateDebut==null)||dateDebut.compareTo("")==0) dateDebut="";
  dateFin=request.getParameter("datySup");if ((dateFin==null)||dateFin.compareTo("")==0) dateFin="";
  colonne=request.getParameter("colonne");if ((colonne==null)||colonne.compareTo("")==0) colonne=nomCol[0];
  projet=request.getParameter("projet");if ((projet==null)||projet.compareTo("")==0) projet="%";
  partenaire=request.getParameter("partenaire");if ((partenaire==null)||partenaire.compareTo("")==0) partenaire="%";
  facture=request.getParameter("facture");if ((facture==null)||facture.compareTo("")==0) facture="%";
  //fournisseur=request.getParameter("fournisseur");if ((fournisseur==null)||fournisseur.compareTo("")==0) fournisseur="%";
  ordre=request.getParameter("ordre");if ((ordre==null)||ordre.compareTo("")==0) ordre="DESC";
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
//(String idSortie, String daty1, String daty2, String beneficiaire, String typeSortie, String designation, String idModePaiement, String idDevise, String idCaisse, String idEtat)
  u=(user.UserEJB)session.getValue("u");
  lien=(String)session.getValue("lien");
ag = u.findTypeObjet("Agence","%","%");
  mp = u.findTypeObjet("Beneficiaire","%","%");
  te = u.findTypeObjet("TypeSortie","%","%");
  caiss = u.findCaisse("%","%","%","%");
  dev = u.findTypeObjet("Devise","%","%");
  ut=u.getUser();
  ////////findSortieAgence( idSortie, daty1, daty2, beneficiaire, typeSortie, designation, idModePaiement, idDevise, idCaisse, idEtat, parution, agence, colonne, ordre,  prj, part, fact
  sort= u.findSortieAgence(idDepense,dateDebut,dateFin,idModePaiement,idType,designation, "%", "%",caisse, "eta2",parution,agence,colonne,ordre, projet, partenaire, facture,idLigne);//n'affiche que les sorties crees seulement, n'affiche pas le annulees
  indiceDebut=Utilitaire.getBornePage(pazy,sort)[0];
  indiceFin=Utilitaire.getBornePage(pazy,sort)[1];
  nbPage=Utilitaire.calculNbPage(sort);
  sommePage=AdminCharge.getSommeSortie(sort,indiceDebut,indiceFin);
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>

<link href="style.css" rel="stylesheet" type="text/css">
<h1>Valider Union </h1>
<p align="center" class="remarque">&nbsp;</p>
<form action="<%=lien%>?but=finance/listeSortie.jsp" method="post" name="listeDepense" id="listeDepense">

</form>
<script language="JavaScript">
var cal1 = new calendar1(document.forms['listeDepense'].elements['datyInf']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['listeDepense'].elements['datySup']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>

