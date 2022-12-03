<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>


<%
try{
PrevisionDepense p = new PrevisionDepense();
p.setNomTable("previsiondepensetous");
String listeCrt[] = {"daty"};
String listeInt[] = {"daty"};
PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("prevision/listePrevisionDepesne.jsp");
pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
String libEntete[]={"id","daty","remarque","montant","idor"};
String[]colSomme = {"montant"};
pr.creerObjetPage(libEntete,colSomme);
%>
<h1>Liste prevision depense</h1>
<form action="<%=pr.getLien()%>?but=prevision/listePrevisionDepesne.jsp" method="post" name="listePrevisionDepense" id="listePrevisionDepense">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=prevision/fichePrevisionDepense.jsp"};
String colonneLien[]={"id"};
pr.getTableau().setLien(lienTableau);
pr.getTableau().setColonneLien(colonneLien);
out.println(pr.getTableauRecap().getHtml());%>
<br>
<form action="<%=pr.getLien()%>?but=prevision/attacherPrevOP.jsp" method="post">
<%
out.println(pr.getTableau().getHtmlWithRadio());
%>
   <input type="hidden" name="type" value="prevop" class="submit">
   <input type="submit" name="Submit" value="Valider" class="submit">
</form>
<% 
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

