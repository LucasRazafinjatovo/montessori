<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="ded.Ded" %>
<%@ page import="ded.OrdonnerPayement" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%!
MvtCaisseLc p;
%>
<%
p=new MvtCaisseLc();
String etat="MvtCaisseLcREC";
if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0)
  etat=request.getParameter("etat");
p.setNomTable(etat);
String listeCrt[]={"designation","idOrdre","debit","credit","mois","annee","idDirection","numpiece","idEntite","id","idTypeLigne","daty","idDevise","idMode","idCaisse","agence","tiers","typemvt"};
String listeInt[]={"mois","daty","debit","credit"};
String libEntete[]={"id","daty","designation","agence","idCaisse","debit","credit"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,7);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("finance/listeMvtCaisse.jsp");
affichage.Champ[] liste=new affichage.Champ[7];
liste[0]=new Liste("mois1");
((Liste)(liste[0])).makeListeMois();
liste[1]=new Liste("mois2");
((Liste)(liste[1])).makeListeMois();
Direction dir=new Direction();
dir.setNomTable("direction");
liste[2]=new Liste("idDirection",dir,"libelledir","libelledir", true);
TypeObjet to=new TypeObjet();
to.setNomTable("beneficiaire");
liste[3]=new Liste("idEntite",to,"val","val", true);
TypeObjet to1=new TypeObjet();
to1.setNomTable("modepaiement");
liste[4]=new Liste("idMode",to1,"val","id", true);
Caisse to2=new Caisse();
to2.setNomTable("caisse");
liste[5]=new Liste("idCaisse",to2,"desccaisse","desccaisse", true);
TypeObjet to3=new TypeObjet();
to3.setNomTable("typemvt");
liste[6]=new Liste("typemvt",to3,"val","val", true);

pr.getFormu().getChamp("annee").setDefaut(String.valueOf(Utilitaire.getAneeEnCours()));
pr.getFormu().changerEnChamp(liste);
pr.getFormu().setLibelleAffiche("idMvt",12);
String colSomme[]={"debit","credit"};
pr.setNpp(100);
pr.creerObjetPageMultiple(libEntete,colSomme);
%>
<h1>Lister les Mouvements de caisse</h1>
<form action="<%=pr.getLien()%>?but=finance/listeMvtCaisse.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=finance/visualiserMvtCaisse.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
%>


<script language="javascript">
  var cal1 = new calendar1(document.forms['listeRecette'].elements['dateDebut']);
  cal1.year_scroll = false;
  cal1.time_comp = false;
  var cal2 = new calendar1(document.forms['listeRecette'].elements['dateFin']);
  cal2.year_scroll = false;
  cal2.time_comp = false;

</script>