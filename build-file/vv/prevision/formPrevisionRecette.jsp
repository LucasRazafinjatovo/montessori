<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ded.OpVita" %>
<%
OpVita pj = new OpVita();
PageInsert pi = new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("ded_id").setVisible(false);
pi.getFormu().getChamp("idLigne").setVisible(false);
pi.getFormu().getChamp("idor").setLibelle("Type prev");
pi.getFormu().getChamp("idor").setDefaut("Recette");
pi.getFormu().getChamp("idor").setAutre("readonly=true");
pi.getFormu().getChamp("etat").setVisible(false);
pi.getFormu().getChamp("remarque").setType("textarea");
pi.preparerDataFormu();
%>

<h1>Saisir prevision depense</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="depense" id="depense">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="prevision/formPrevisionRecette.jsp">
 <input name="classe" type="hidden" id="classe" value="ded.OpVita">
</form>
