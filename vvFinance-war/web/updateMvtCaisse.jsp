<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="finance.*" %>

<%
MvtCaisseTous p=new MvtCaisseTous();
p.setNomTable("MvtCaisseTous");
PageUpdate pc=new PageUpdate(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin

pc.getFormu().getChamp("id").setAutre("readonly='true'");
pc.getFormu().getChamp("daty").setAutre("readonly='true'");
pc.getFormu().getChamp("designation").setAutre("readonly='true'");
pc.getFormu().getChamp("idmode").setAutre("readonly='true'");
pc.getFormu().getChamp("idcaisse").setAutre("readonly='true'");
pc.getFormu().getChamp("agence").setAutre("readonly='true'");
pc.getFormu().getChamp("tiers").setAutre("readonly='true'");
pc.getFormu().getChamp("numpiece").setAutre("readonly='true'");
pc.getFormu().getChamp("typemvt").setAutre("readonly='true'");
pc.getFormu().getChamp("datyvaleur").setAutre("readonly='true'");
pc.getFormu().getChamp("idordre").setAutre("readonly='true'");
pc.getFormu().getChamp("numcheque").setAutre("readonly='true'");
pc.getFormu().getChamp("etablissement").setAutre("readonly='true'");

pc.preparerDataFormu();
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<h1>Modifier un mouvement</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresTarif.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pc.getFormu().getHtmlInsert());
%>
  <input name="acte" type="hidden" id="nature" value="update">
<input name="bute" type="hidden" id="bute" value="finance/visualiserMvtCaisse.jsp&id=<%=request.getParameter("id")%>">
<input name="classe" type="hidden" id="classe" value="finance.MvtCaisseTous">
</form>
