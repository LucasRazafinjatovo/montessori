<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="promotion.*" %>
<%@ page import="etudiant.*" %>
<%

EntreeUniv pj=new EntreeUniv();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));

pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste=new affichage.Champ[1];
Promotion prom=new Promotion();
liste[0]=new Liste("promotion",prom,"nom","id");

pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("etudiant").setPageAppel("listeEtudiantChoix.jsp");
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("daty").setLibelleAffiche("Date d'entrée");
pi.preparerDataFormu();
%>

<h1>Saisir l'entr&eacute;e de l'&eacute;tudiant &agrave; l'universit&eacute; </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="entreeuniv" id="entreeuniv">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="etudiant/formEntreeUniv.jsp">
 <input name="classe" type="hidden" id="classe" value="promotion.EntreeUniv">
<!--<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">-->
</form>
