<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="activa.*" %>

<%
Tirage m=new Tirage();
m.setNomTable("tirage");
// preparation de l'affichage
PageInsert pi=new PageInsert(m,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());

/*affichage.Champ[] liste = new affichage.Champ[1];
TypeObjet encre=new TypeObjet();
encre.setNomTable("encre");
liste[0]=new Liste("typeCouleur",encre,"val","id");
pi.getFormu().getChamp("typeCouleur").setLibelle("type encre");
pi.getFormu().changerEnChamp(liste); */
/*pi.getFormu().getChamp("nombreTirage").setLibelle("nombre");
pi.getFormu().getChamp("coutNbTirage").setLibelle("Cout nombre tirage"); */
//pi.preparerDataFormu();
%>

<h1>Saisir Encre </h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="tirage" id="tirage">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="activa/saisitirage.jsp">
 <input name="classe" type="hidden" id="classe" value="activa.Tirage">
 <input name="rajoutLien" type="hidden" id="classe" value="nbre-cout-typecoul">
</form>
