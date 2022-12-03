<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
Publicite p=new Publicite();
p.setNomTable("publicite");
PageInsert pc=new PageInsert(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
affichage.Champ[] liste=new affichage.Champ[3];
Montant m=new Montant();
liste[0]=new Liste("idMont",m);
TypeObjet to=new TypeObjet();
to.setNomTable("categoriePub");
liste[1]=new Liste("idCat",to);
TypeObjet too=new TypeObjet();
too.setNomTable("Agence");
liste[2]=new Liste("idAgence",too);
pc.getFormu().changerEnChamp(liste);
pc.preparerDataFormu();
pc.getFormu().getChamp("idClient").setPageAppel("ded/choix_tiers.jsp");
%>
<h1>Création d'une pubicite</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresPub.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pc.getFormu().getHtmlInsert());
%>
  <input type="submit" name="Submit2" value="attacher Lc" class="submit" onClick="acte.value='attach'">
  <input name="nature" type="hidden" id="nature" value="nature">
</form>
