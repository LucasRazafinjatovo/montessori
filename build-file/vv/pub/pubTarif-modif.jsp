<%@page import="pub.PubType"%>
<%@page import="pub.PubTarif"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
PubTarif atcl=new PubTarif();
PageUpdate pi=new PageUpdate(atcl,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste = new affichage.Champ[1];
PubType to2=new PubType();
liste[0]=new Liste("idtype",to2,"designation","id");
pi.getFormu().changerEnChamp(liste);

pi.getFormu().getChamp("idtype").setLibelle("Type");
pi.getFormu().getChamp("duree").setLibelle("Duree");
pi.getFormu().getChamp("durees").setLibelle("Durees");
pi.getFormu().getChamp("ID_PLAGE_HORAIRE").setLibelle("Plage horaire");
pi.getFormu().getChamp("ID_PLAGE_HORAIRE").setPageAppel("listePubPlageHoraire.jsp");
pi.getFormu().getChamp("id").setAutre("readonly='readonly'");

pi.preparerDataFormu();
%>

<h1>Modification Pub tarif</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="pub/pubTarif-liste.jsp">
 <input name="classe" type="hidden" id="classe" value="pub.PubTarif">
</form>
