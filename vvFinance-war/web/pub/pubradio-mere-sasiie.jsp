<%-- 
    Document   : pubradio-mere-sasiie
    Created on : 15 mai 2017, 15:45:17
    Author     : Doudou Tiarilala
--%>
 
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageInsert"%>
<%@page import="pub.PubTopRadioMere"%>
<%
PubTopRadioMere pj=new PubTopRadioMere();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("nom_client").setLibelle("Client");
pi.getFormu().getChamp("reference_pub").setLibelle("Reference pub");
pi.getFormu().getChamp("date_saisie").setDefaut(Utilitaire.formatterDaty(Utilitaire.dateDuJourSql()));
pi.getFormu().getChamp("date_saisie").setLibelle("date de saisie");
pi.preparerDataFormu();
%>

<h1>Saisir Pub top RADIO</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="plagehoraire" id="plagehoraire">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="pub/pubradio-fille-saisie.jsp">
 <input name="classe" type="hidden" id="classe" value="pub.PubTopRadioMere">
<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">
</form>
