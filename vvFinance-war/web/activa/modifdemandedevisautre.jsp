<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
DemandeDevis atcl=new DemandeDevis();
atcl.setNomTable("demandedevis");
PageUpdate pi=new PageUpdate(atcl,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

/*affichage.Champ[] liste=new affichage.Champ[2];
CodeRV c=new CodeRV();
c.setNomTableSelect("coderv");
liste[0]=new Liste("idCodeRV",c,"val","idcoderv");

Article a=new Article();
a.setNomTable("article");
liste[1]=new Liste("idArticle",a,"libelle","idarticle"); */

//pi.getFormu().changerEnChamp(liste);
//pi.getFormu().getChamp("idArticle").setVisible(false);
pi.getFormu().getChamp("idDevis").setAutre("readonly='readonly'");
pi.getFormu().getChamp("idGestion").setAutre("readonly='readonly'");
pi.getFormu().getChamp("designation").setAutre("readonly='readonly'");
pi.getFormu().getChamp("margeBenefice").setAutre("readonly='readonly'");
pi.getFormu().getChamp("nbExemplaireA3").setAutre("readonly='readonly'");
pi.getFormu().getChamp("nombre").setAutre("readonly='readonly'");
pi.getFormu().getChamp("remise").setAutre("readonly='readonly'");
pi.getFormu().getChamp("idTirage").setAutre("readonly='readonly'");
//pi.getFormu().getChamp("idMarge").setVisible(false);
pi.getFormu().getChamp("idMarge").setAutre("readonly='readonly'");
pi.getFormu().getChamp("idCodeRV").setAutre("readonly='readonly'");
pi.getFormu().getChamp("statut").setAutre("readonly='readonly'");
pi.preparerDataFormu();
%>

<h1>Modification Demande devis</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="demandedevis" id="demandedevis">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="statutoff" type="hidden" id="nature1" value="1">
 <input name="bute" type="hidden" id="bute" value="activa/listedemandedevislibellevalide.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.DemandeDevis">
</form>
