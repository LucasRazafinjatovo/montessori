<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
Montant p=new Montant();
p.setNomTable("montant");
PageInsert pc=new PageInsert(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
affichage.Champ[] liste=new affichage.Champ[2];
TypeObjet to=new TypeObjet();
to.setNomTable("journal");
liste[0]=new Liste("idgazety",to);
((Liste)liste[0]).setDefaultSelected("j1");
String[]format=ConstanteAffichage.format;
TypeObjet to2=new TypeObjet();
to2.setNomTable("format");
liste[1]=new Liste("taille",to2,"id","id");
pc.getFormu().changerEnChamp(liste);
pc.preparerDataFormu();
pc.getFormu().getChamp("page").setValeur("0");
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<h1>Tarif de publicite</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresTarif.jsp" method="post" name="publication" id="publication">
<%
pc.getFormu().makeHtmlInsertTabIndex();
out.println(pc.getFormu().getHtmlInsert());
%>
  <input name="acte" type="hidden" id="nature" value="insert">
<input name="bute" type="hidden" id="bute" value="pub/listeTarif.jsp">
</form>
