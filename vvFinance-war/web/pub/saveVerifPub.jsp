<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
Statpub p=new Statpub();
p.setNomTable("statpubsaisie");
PageInsert pc=new PageInsert(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
affichage.Champ[] liste=new affichage.Champ[2];
TypeObjet to=new TypeObjet();
to.setNomTable("journal");
liste[0]=new Liste("journal",to);
((Liste)liste[0]).setColValeur("val");
((Liste)liste[0]).setDefaultSelected("VV");
String[]format=ConstanteAffichage.format;
liste[1]=new Liste("format",format);
pc.getFormu().changerEnChamp(liste);
pc.preparerDataFormu();
pc.getFormu().getChamp("montant").setValeur("0");
pc.getFormu().getChamp("couleur").setValeur("1");
pc.getFormu().getChamp("montant").setAutre("readonly='true'");
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<h1>Verification de publicite</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresTarif.jsp" method="post" name="publication2" id="publication2">
<%
out.println(pc.getFormu().getHtmlInsert());
%>
  <input type="submit" name="Submit2" value="valider" class="submit">
  <input name="acte" type="hidden" id="acte" value="insert">
<input name="bute" type="hidden" id="bute" value="pub/saveVerifPub.jsp">
<input name="classe" type="hidden" id="classe" value="pub.Statpub">
</form>
