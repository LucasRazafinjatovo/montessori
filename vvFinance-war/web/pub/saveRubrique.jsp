<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
Rubrique p=new Rubrique();
p.setNomTable("rubrique");
PageInsert pc=new PageInsert(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet to=new TypeObjet();
to.setNomTable("journal");
liste[0]=new Liste("journal",to,"desce","id");
//((Liste)liste[0]).setDefaultSelected("j11");
pc.getFormu().changerEnChamp(liste);
pc.preparerDataFormu();
pc.getFormu().getChamp("journal").setLibelle("Journal");
pc.getFormu().getChamp("libelle").setLibelle("Rubrique");
%>
<h1>Ajout rubrique</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresTarif.jsp" method="post" name="publication" id="publication">
<%
out.println(pc.getFormu().getHtmlInsert());
%>
  <input type="submit" name="Submit2" value="valider" class="submit">
  <input name="acte" type="hidden" id="acte" value="insert">
  <input name="bute" type="hidden" id="bute" value="pub/saveRubrique.jsp">
  <input name="classe" type="hidden" id="classe" value="pub.Rubrique">
  
</form>
