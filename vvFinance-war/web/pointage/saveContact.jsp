<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="pointage.*" %>
<%
Contact contact=new Contact();
PageInsert pi=new PageInsert(contact,request,(user.UserEJB)session.getValue("u"));
pi.getFormu().getChamp("nom").setType("text");pi.getFormu().getChamp("nom").setLibelle("Nom");pi.getFormu().getChamp("nom").setAutre("Onblur=toUpCaseJs(this)");
pi.getFormu().getChamp("prenom").setType("text");pi.getFormu().getChamp("prenom").setLibelle("Prénom");
pi.getFormu().getChamp("tel1").setType("text");pi.getFormu().getChamp("tel1").setLibelle("Téléphone 1");pi.getFormu().getChamp("tel1").setAutre("OnBlur= telJs(this)");
pi.getFormu().getChamp("tel2").setType("text");pi.getFormu().getChamp("tel2").setLibelle("Téléphone 2");pi.getFormu().getChamp("tel2").setAutre("OnBlur= telJs(this)");
pi.getFormu().getChamp("mail").setType("text");pi.getFormu().getChamp("mail").setLibelle("Mail");
pi.getFormu().getChamp("adresse").setType("text");pi.getFormu().getChamp("adresse").setLibelle("Adresse");
pi.getFormu().getChamp("naissance").setType("text");pi.getFormu().getChamp("naissance").setLibelle("Date de naissance");pi.getFormu().getChamp("naissance").setAutre("OnBlur= dateJs(this)");
TypeObjet to=new TypeObjet();
to.setNomTable("typecontact");
affichage.Champ[] liste= new affichage.Champ[1];
liste[0] = new Liste("typecontact", to,"val","id");
pi.getFormu().changerEnChamp(liste);
pi.setLien((String)session.getValue("lien"));
pi.preparerDataFormu();

%>
<h1>Saisir contact</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="nom" id="nom">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
<input name="acte" type="hidden" id="nature" value="insert">
<input name="bute" type="hidden" id="bute" value="pointage/saveContact.jsp">
<input name="classe" type="hidden" id="classe" value="pointage.Contact">
</form>

