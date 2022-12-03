<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="stockgazety.*" %>
<%!
public static String essai(String hoho)
{
  return "salut";
}
%>
<%
Perte prt=new Perte();
PageInsert pi=new PageInsert(prt,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[1];
Mouvementstock mvst=new Mouvementstock();
mvst.setNomTable("mouvementstock");
liste[0]=new Liste("mvtStock",mvst,"quantiteSortie","quantiteSortie");
pi.getFormu().changerEnChamp(liste);
pi.preparerDataFormu();
pi.getFormu().getChamp("date").setDefaut(Utilitaire.dateDuJour());
%>

<h1>Saisir perte</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisiprt" id="saisiprt">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="stockgazety/saisiperte.jsp">
 <input name="classe" type="hidden" id="classe" value="stockgazety.Perte">
<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">
</form>
