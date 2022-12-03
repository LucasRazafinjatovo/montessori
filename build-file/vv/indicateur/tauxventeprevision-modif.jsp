<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="indicateur.*" %>

<%
TauxVentePrevision atcl=new TauxVentePrevision();
PageUpdate pi=new PageUpdate(atcl,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste = new affichage.Champ[1];

TypeObjet journal = new TypeObjet();
journal.setNomTable("JOURNAL");
liste[0] = new Liste("journal", journal, "DESCE", "id");
    
pi.getFormu().changerEnChamp(liste);

pi.getFormu().getChamp("prix").setLibelle("Taux (%)");
pi.getFormu().getChamp("dateeffectivite").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("dateeffectivite").setLibelle("Date d'effectivi&eacute;");

pi.getFormu().getChamp("id").setAutre("readonly='readonly'");

pi.preparerDataFormu();
%>

<h1>Modification taux de vente prevision</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="article" id="article">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="update">
 <input name="bute" type="hidden" id="bute" value="indicateur/tauxventeprevision-liste.jsp">
 <input name="classe" type="hidden" id="classe" value="indicateur.TauxVentePrevision">
</form>
