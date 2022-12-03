<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
UserEJB u=null;
%>
<%

u=(UserEJB)session.getAttribute("u");
VisaDevis m=new VisaDevis();
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("idDevis").setPageAppel("listeDemandeDevisChoixVisa.jsp");
pi.getFormu().getChamp("dateVisa").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("remarque").setType("textarea");
//recuperer la session
pi.getFormu().getChamp("login").setDefaut(u.getUser().getLoginuser());
pi.getFormu().getChamp("login").setVisible(false);
%>
<h1>Saisir VISA </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="visa" id="visa">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/saisivisa.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.VisaDevis">
<!-- <input name="rajoutLien" type="hidden" id="classe" value="iddevis"> -->
</form>
