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
Intrastock prt=new Intrastock();
PageInsert pi=new PageInsert(prt,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[2];
Mouvementstock art=new Mouvementstock();
art.setNomTable("mouvementstock");
liste[0]=new Liste("mvtStockDep",art,"quantiteEntree","quantiteEntree");
liste[1]=new Liste("mvtStockArr",art,"quantiteSortie","quantiteSortie");
pi.getFormu().changerEnChamp(liste);
pi.preparerDataFormu();
%>

<h1>Saisir intra Stock</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisintr" id="saisintr">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="stockgazety/saisintrastock.jsp">
 <input name="classe" type="hidden" id="classe" value="stockgazety.Intrastock">
<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">
</form>
