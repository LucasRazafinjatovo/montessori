<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%!
Ecole p;
%>
<%
p=new Ecole();
p.setNomTable("ecolelib");
PageConsulte pc=new PageConsulte(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
//pc.getFormu().getChamp("remarque").setLibelle("Remarque");
String[]libAffichage={"id","nom","Type Ecole","Lieu","Remarque"};
pc.setLibAffichage(libAffichage);

%>
<html>
<h1>Fiche de l'&eacute;cole</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")+"?but=etudiant/modifEcole.jsp&id="+request.getParameter("id")%>">Modifier</a>
</html>
