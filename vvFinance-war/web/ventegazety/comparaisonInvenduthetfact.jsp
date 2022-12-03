<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
try{
EtatComparaisonPoidsInvendu p=new EtatComparaisonPoidsInvendu();
p.setNomTable("INVENDUTHEORIQUEETFACTURE");
String listeCrt[]={"daty","theorique","facture","diference"};
String listeInt[]={"daty"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ventegazety/comparaisonInvenduthetfact.jsp");

pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
String libEntete[]={"Daty","Theorique","Facture","Diference"};
String[]colSomme={"theorique","facture"};
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste</h1>
<form action="<%=pr.getLien()%>?but=ventegazety/comparaisonInvenduthetfact.jsp" method="post" name="listeactualite" id="listeactualite">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
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
