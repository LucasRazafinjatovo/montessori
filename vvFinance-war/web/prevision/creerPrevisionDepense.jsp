<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%
PrevisionDepense pj = new PrevisionDepense();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

affichage.Champ[] liste = new affichage.Champ[1];
TypeObjet ve = new TypeObjet();
ve.setNomTable("typecharge");
liste[0] = new Liste("typecharge",ve,"val","id");

pi.getFormu().getChamp("montant").setLibelle("D&eacute;bit");
pi.getFormu().getChamp("montant").setType("texte");
pi.getFormu().getChamp("montantinit").setVisible(false);
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("description").setType("textarea");
pi.getFormu().getChamp("description").setLibelle("Designation");
pi.getFormu().getChamp("idligne").setLibelle("lc unique");
pi.getFormu().getChamp("typecharge").setLibelle("Type charge");
pi.getFormu().getChamp("remarque").setLibelle("Remarque");
pi.getFormu().getChamp("remarque").setType("textarea");
pi.getFormu().getChamp("idligne").setPageAppel("listeLCChoix.jsp");
pi.getFormu().getChamp("rang").setVisible(false);

pi.getFormu().changerEnChamp(liste);

pi.preparerDataFormu();
%>

<h1>Saisir pr&eacute;vision d&eacute;pense</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="prevision" id="prevision">

<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="recurrence" type="hidden" id="recurrence" value="champReturn">
 <input name="recurrenceAfficher" type="hidden" id="recurrenceAfficher" value="champReturnAfficher">
 <input name="champReturn" id="champReturn" type="hidden"/>
 <input name="acte" type="hidden" id="nature" value="insertprevisiondep">
 <input name="bute" type="hidden" id="bute" value="prevision/ventilationPrevLcDepense.jsp">
 <input name="classe" type="hidden" id="classe" value="prevision.PrevisionDepense">
</form>
<script language="javascript">
var cal = new calendar1(document.forms['prevision'].elements['daty']);
cal.year_scroll = false;
cal.time_comp = false;
</script>
