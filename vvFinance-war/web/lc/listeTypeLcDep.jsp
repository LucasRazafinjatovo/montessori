<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="affichage.*" %>

<%
try{
TypeObjet p = new TypeObjet();
p.setNomTable("TYPESORTIE");
String listeCrt[] = {"id","val","desce"};
String listeInt[] = null;
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,3);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("lc/listeTypeLcDep.jsp");

pr.getFormu().getChamp("val").setLibelle("Libelle");
pr.getFormu().getChamp("desce").setLibelle("Compta Compte");
String libEntete[] = {"id","val","desce"};

String[]colSomme = null;
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste type LC D&eacute;penses</h1>
<form action="<%=pr.getLien()%>?but=lc/listeTypeLcDep.jsp" method="post" name="listeactualite" id="listeactualite">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=lc/modifTypeLcDep.jsp"};
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
