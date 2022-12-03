<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%!
SaisieVirementLettreEtat p;
String[] debutFin=null;
%>
<%
try{
debutFin=Utilitaire.getDebutFinAnnee();
p=new SaisieVirementLettreEtat();
String etat="SaisieVirementLettreEtat";
p.setNomTable(etat);
String listeCrt[]={"daty","caissedep","caissearr","etat","id","remarque"};
String listeInt[]={"daty"};
String libEntete[]={"id","daty","montant","caissedep","caissearr","remarque"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("finance/listeVirement.jsp");
affichage.Champ[] liste=new affichage.Champ[3];
Caisse to=new Caisse();
to.setNomTable("caisse");
liste[0]=new Liste("caissedep",to,"desccaisse","desccaisse");
TypeObjet to1=new TypeObjet();
to1.setNomTable("viser");
liste[1]=new Liste("etat",to1,"desce","id");
Caisse to2=new Caisse();
to2.setNomTable("caisse");
liste[2]=new Liste("caissearr",to2,"desccaisse","desccaisse");
pr.getFormu().changerEnChamp(liste);
pr.getFormu().getChamp("caissedep").setLibelleAffiche("Caisse Depart");
pr.getFormu().getChamp("caissearr").setLibelleAffiche("Caisse Arrv");
pr.getFormu().getChamp("daty1").setLibelleAffiche("Date début");
pr.getFormu().getChamp("daty1").setDefaut(debutFin[0]);
pr.getFormu().getChamp("daty2").setLibelleAffiche("Date fin");
pr.getFormu().getChamp("daty2").setDefaut(debutFin[1]);
pr.getFormu().getChamp("id").setLibelleAffiche("id Virement");
String colSomme[]={"montant"};
pr.creerObjetPage(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>Lister les virements</h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les virements)</p>
<form action="<%=pr.getLien()%>?but=finance/listeVirement.jsp" width="80%" method="post" name="listeVirement" id="listeVirement">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
<br/>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=finance/detailVirement.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<%
out.println(pr.getTableau().getHtml());
out.println(pr.getBasPage());
}
catch(Exception e){
  e.printStackTrace();
  %>
   <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
  <%
  return;
}
%>