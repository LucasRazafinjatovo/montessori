<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%!
UserEJB u;
String type=null;
%>
<%
Vendeur p=new Vendeur();
u=(user.UserEJB)session.getValue("u");
type=request.getParameter("type");
PageUpdate pc=new PageUpdate(p,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
pc.preparerDataFormu();
pc.getFormu().getChamp("id").setAutre("readonly='true'");
pc.getFormu().getChamp("type").setAutre("readonly='true'");
pc.getFormu().getChamp("idPlace").setAutre("readonly='true'");
pc.getFormu().getChamp("nom").setAutre("readonly='true'");
pc.getFormu().getChamp("prenom").setAutre("readonly='true'");
pc.getFormu().getChamp("prenom").setVisible(false);
pc.getFormu().getChamp("surnom").setAutre("readonly='true'");
pc.getFormu().getChamp("dateembauche").setValeur(request.getParameter("dateembauche"));
%>

<SCRIPT language="JavaScript" src="script.js"></script>
<h1>Modification d'un vendeur</h1>
<form action="<%=(String)session.getValue("lien")%>?but=pub/apresTarif.jsp" method="post" name="listePub" id="listePub">
<%
out.println(pc.getFormu().getHtmlInsert());
%>
  <input type="submit" name="Submit2" value="valider" class="submit">
  <input name="acte" type="hidden" id="acte" value="update">
<input name="type" type="hidden" id="type" value="<%=type%>">
<input name="bute" type="hidden" id="bute" value="ventegazety/listeVendeur.jsp">
<input name="classe" type="hidden" id="classe" value="ventegazety.Vendeur">
</form>
