<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%@ page import="finance.*" %>

<%
try{
EtatCaisseTableau2 p = new EtatCaisseTableau2();
p.setNomTable("ETATCAISSEENREGISTREE");
String listeCrt[] = {"caisse", "daty"};
String listeInt[]={"daty"};
String libEntete[]={"id", "daty", "caisse", "report", "depense", "recette", "disponible"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,3,libEntete, 7);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("finance/listeEtatCaisseTableau2.jsp");
affichage.Champ[] liste=new affichage.Champ[1];
Caisse to = new Caisse();
to.setNomTable("caisse");
liste[0] = new Liste("caisse",to,"descCaisse","descCaisse");

pr.getFormu().changerEnChamp(liste);
String colSomme[]={"report", "depense", "recette", "disponible"};


pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste etat de caisse</h1>
<form action="<%=pr.getLien()%>?but=finance/listeEtatCaisseTableau2.jsp" method="post" name="listeactualite" id="listeactualite">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=finance/listeEtatCaisseTableau2.jsp"};
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
