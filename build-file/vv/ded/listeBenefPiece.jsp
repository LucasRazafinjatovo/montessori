<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="ded.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%!
BenefPiece p;
%>
<%
try{
p=new BenefPiece();
String etat="BenefPiece";
p.setNomTable(etat);
String listeCrt[]={"id","nom","tel","poste"};
String listeInt[]=null;
String libEntete[]={"id","nom","tel","poste"};
PageRecherche pr=new PageRecherche(p,request,listeCrt,listeInt,2);

pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("ded/listeBenefPiece.jsp");
String colSomme[]=null;
pr.creerObjetPage(libEntete,colSomme);
//pr.preparerDataFormu();
%>
<h1>Lister coursier</h1>
<form action="<%=pr.getLien()%>?but=ded/listeBenefPiece.jsp" method="post" name="liste" id="liste">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
<br/>
</form>
<%
String lienTableau[]={pr.getLien()+"?but=ded/ficheBenefPiece.jsp"};
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