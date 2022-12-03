<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Commande atcl=new Commande();
PageUpdate pi=new PageUpdate(atcl,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste=new affichage.Champ[1];
DemandeDevis d=new DemandeDevis();
d.setNomTable("demandedevis");
liste[0]=new Liste("iddevis",d,"iddevis","iddevis");
pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("idcmd").setAutre("readonly='readonly'");
pi.preparerDataFormu();
%>

<h1>Modification Commande</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="commande" id="commande">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="activa/listecommande.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.Commande">
</form>
