<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="restriction.*" %>
<%@ page import="historique.*" %>


<%
try{
ListeTable e=new ListeTable();

e.setNomTable("listetable");

String listeCrt[]={"nom","remarque"};
String listeInt[]=null;
String libEntete[]={"id","nom","remarque"};
PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,1,libEntete,3);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("utilisateur/listeTable.jsp");

pr.creerObjetPage(libEntete);
%>
<h1>Liste des tables</h1>
<form action="<%=pr.getLien()%>?but=utilisateur/listeTable.jsp" method="post" name="restriction" id="restriction">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=utilisateur/ficheTable.jsp"};
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

