<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Commande m=new Commande();
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));

pi.getFormu().getChamp("datecmd").setDefaut(Utilitaire.dateDuJour());
//pi.getFormu().getChamp("datelivraisoncmd").setDefaut(Utilitaire.dateDuJour());
pi.getFormu().getChamp("dateLivraisonCmd").setTypeData("date");
pi.getFormu().getChamp("dateLivraisonCmd").setLibelle("date livraison cmd");
pi.getFormu().getChamp("remarque").setType("textarea");
// A mettre un calendrier gerant la date
pi.getFormu().getChamp("iddevis").setPageAppel("listeDemandeDevisLibelleChoix.jsp");
%>
<!--<script type="text/javascript" src="calendar/calendar1.js"></script>  -->
<h1>Saisir Commande </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="cmd" id="cmd">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/listecommandelibelle.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.Commande">
 <!--<input name="rajoutLien" type="hidden" id="classe" value="idcmd-rmq-dateliv"> -->
</form>
<script language="javascript">
var cal1 = new calendar1(document.forms['cmd'].elements['dateLivraisonCmd']);
cal1.year_scroll = false;
cal1.time_comp = false;
</script>