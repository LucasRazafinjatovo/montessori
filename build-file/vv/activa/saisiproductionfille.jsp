<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
String max=UserEJBBean.getMaxIdMaintenance();
String tt;
tt=request.getParameter("id");
String t=UserEJBBean.getMaxIdProduction();
Production p=new Production();
p.setNomTable("production");
p.setIdProduction(t);
Production[] pp = (Production[])CGenUtil.rechercher(p,null,null,"");
%>
<%
Production m=new Production();
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("idcmd").setDefaut(tt);
pi.getFormu().getChamp("remarque").setType("textarea");
if(pp.length!=0) pi.getFormu().getChamp("debutCompteur").setDefaut(String.valueOf(pp[0].getFinCompteur()+1));
else  pi.getFormu().getChamp("debutCompteur").setDefaut(String.valueOf(1));
pi.getFormu().getChamp("idMaintenance").setDefaut(max);
pi.preparerDataFormu();
%>
<h1>Saisir production </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="production" id="production">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/saisiproduction.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.Production">
 <!--<input name="rajoutLien" type="hidden" id="classe" value="idcmd-datedeb-datefin"> -->
</form>
