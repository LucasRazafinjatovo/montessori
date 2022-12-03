<%-- 
    Document   : pubTopRadioMere-saisie
    Created on : 16 mai 2017, 16:31:56
    Author     : Safidimahefa
--%>
<%@page import="pub.PubType"%>
<%@page import="pub.PubPlageHoraire"%>
<%@page import="pub.PubRadioMere"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="actualite.*" %>
<%
PubRadioMere pj=new PubRadioMere();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet r = new TypeObjet();
r.setNomTable("agence");
//PubPlageHoraire to2=new PubPlageHoraire();
//PubType to1 = new PubType();
liste[0]=new Liste("responsable",r,"val","id");
//liste[1]=new Liste("pubtype",to1,"designation","id");

pi.getFormu().getChamp("daty").setLibelle("Date Saisie");
pi.getFormu().getChamp("etat").setVisible(false);
pi.getFormu().getChamp("observation").setType("textarea");
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());

pi.getFormu().getChamp("client").setPageAppel("pub/clientChoix.jsp");

pi.getFormu().changerEnChamp(liste);
//pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
//pi.getFormu().getChamp("actualite").setType("textarea");
//pi.getFormu().getChamp("daty").setLibelleAffiche("date actu");
pi.preparerDataFormu();
%>

<h1>Saisir Pub Top Radio  Mere</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="actualite" id="actualite">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="pub/pubTopRadioFille-saisie.jsp">
 <input name="classe" type="hidden" id="classe" value="pub.PubRadioMere">
<!--<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">-->
</form>

