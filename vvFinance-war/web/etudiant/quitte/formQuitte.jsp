<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="quitte.*" %>
<%@ page import="promotion.*" %>
<%

QuitteComplet pj=new QuitteComplet();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet categorieQuitte=new TypeObjet();
categorieQuitte.setNomTable("categoriequitte");
liste[0]=new Liste("categorieMotif",categorieQuitte,"val","id");
pi.getFormu().changerEnChamp(liste);
pi.getFormu().getChamp("motif").setType("textarea");
pi.getFormu().getChamp("etudiant").setPageAppel("listeEtudiantChoix.jsp");
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("daty").setLibelle("Date");
pi.getFormu().getChamp("daty").setTypeData("date");
pi.preparerDataFormu();
%>

<h1>Saisir quitte d'un &eacute;tudiant</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="quitte" id="quitte">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="quitte/formQuitte.jsp">
 <input name="classe" type="hidden" id="classe" value="quitte.QuitteComplet">
<!--<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">-->
</form>
<script language="javascript">
var cal = new calendar1(document.forms['quitte'].elements['daty']);
cal.year_scroll = false;
cal.time_comp = false;
</script>