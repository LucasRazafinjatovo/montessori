<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
Montant p=new Montant();
p.setNomTable("montant");
PageUpdate pc=new PageUpdate(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
affichage.Champ[] liste=new affichage.Champ[2];
TypeObjet to=new TypeObjet();
to.setNomTable("journal");
liste[0]=new Liste("idgazety",to);
((Liste)liste[0]).setDefaultSelected("j1");
String[]format=ConstanteAffichage.format;
liste[1]=new Liste("taille",format);
pc.getFormu().changerEnChamp(liste);
pc.preparerDataFormu();
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<h1>Modification de tarif</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresTarif.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pc.getFormu().getHtmlInsert());
%>
  <input type="submit" name="Submit2" value="valider" class="submit">
  <input name="acte" type="hidden" id="nature" value="update">
<input name="bute" type="hidden" id="bute" value="pub/listeTarif.jsp">
</form>
