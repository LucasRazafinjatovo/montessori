<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%!
RubriqueLibelle rl;
%>
<%
rl=new RubriqueLibelle();
rl.setNomTable("rubrique_libelle");
PageConsulte pc=new PageConsulte(rl,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
String libelle[]={"Identifiant","ID Journal","Libelle","Acronyme journal","Journal","Date de l'opération","ID Journal"};
pc.setLibAffichage(libelle);

pc.getListeChamp()[5].setValeur(Utilitaire.formatterDaty(pc.getListeChamp()[5].getValeur()));
//rl=(RubriqueLibelle)pc.getBase();
%>
<html>
<h1>Consultation d'une parution</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresPub.jsp&id=<%=request.getParameter("id")%>" method="post" name="ficheRubrique" id="ficheRubrique">
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=pub/apresTarif.jsp&id="+request.getParameter("id")%>&acte=delete&bute=pub/listeRubrique.jsp&classe=pub.RubriqueLibelle">Supprimer</a>

</form>
</html>
