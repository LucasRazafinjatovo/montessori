<%-- 
    Document   : rubrique-prix-entite-modif
    Created on : 22 mai 2018, 12:18:44
    Author     : pro
--%>

<%@page import="etudiant.EntiteBeneficiaire"%>
<%@page import="recette.RubriquePrixEntite"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
RubriquePrixEntite rubriquePrixEntite=new RubriquePrixEntite();
PageUpdate pi=new PageUpdate(rubriquePrixEntite,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste=new affichage.Champ[1];
String idSociete = "SOC00003";
EntiteBeneficiaire entite=new EntiteBeneficiaire();
entite.setIdSociete(idSociete);
liste[0]=new Liste("entite",entite,"val","id");

pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("id").setAutre("readonly='readonly'");
pi.preparerDataFormu();
%>

<h1>Modification rubrique prix entite</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="rubrique/rubrique-prix-entite-liste.jsp">
 <input name="classe" type="hidden" id="classe" value="recette.RubriquePrixEntite">
</form>
