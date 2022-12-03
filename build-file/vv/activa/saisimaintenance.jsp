<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Production p=new Production();
String max=UserEJBBean.getMaxIdProduction();
p.setIdProduction(max);
Production[] pt=(Production[])CGenUtil.rechercher(p,null,null,"");
Maintenance m=new Maintenance();
m.setNomTable("maintenance");
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
if(pt.length!=0)pi.getFormu().getChamp("finCompteur").setDefaut(String.valueOf(pt[0].getFinCompteur()));
pi.getFormu().getChamp("prixMO").setLibelle("tarif Main dOeuvre");
pi.getFormu().getChamp("remarque").setType("textarea");
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
%>
<h1>Saisir Maintenance </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="maintenance" id="maintenance">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/saisimaintenance.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.Maintenance">
<!-- <input name="rajoutLien" type="hidden" id="classe" value="idliv"> -->
</form>
