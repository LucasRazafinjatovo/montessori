<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>

<%
Publicite p = new Publicite();
p.setNomTable("Publicite");
PageUpdate pc=new PageUpdate(p,request,(user.UserEJB)session.getValue("u"));

affichage.Champ[] liste=new affichage.Champ[1];

TypeObjet to = new TypeObjet();
to.setNomTable("format");
liste[0]=new Liste("dimension",to,"id","id");

pc.getFormu().getChamp("id").setAutre("readonly='true'");
pc.getFormu().getChamp("idClient").setPageAppel("ded/choix_tiers.jsp");
pc.getFormu().getChamp("idParution").setPageAppel("listeParutionChoix.jsp");
pc.getFormu().getChamp("idMont").setPageAppel("listeTarifPubChoix.jsp");
pc.getFormu().getChamp("idCat").setPageAppel("listeCatPubChoix.jsp");
pc.getFormu().getChamp("idAgence").setPageAppel("listeAgenceChoix.jsp");

// pc.getFormu().getChamp("designation").setType("textarea");

pc.getFormu().changerEnChamp(liste);
pc.preparerDataFormu();
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<h1>Modification d'une publicite</h1>
<form action="<%=(String)session.getValue("lien")%>?but=admin/apresModifPub.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pc.getFormu().getHtmlInsert());
%>
  <input type="submit" name="Submit2" value="valider" class="submit">
  <input type="hidden" name="acte" value="update">
  <input type="hidden" name="classe" value="pub.Publicite">
  <input type="hidden" name="bute" value="admin/modifPub.jsp">
</form>
