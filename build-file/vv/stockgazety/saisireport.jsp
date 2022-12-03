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
Reportstock prt=new Reportstock();
PageInsert pi=new PageInsert(prt,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[2];
TypeObjet mg=new TypeObjet();
mg.setNomTable("magasin");
liste[0]=new Liste("magasin",mg,"val");
Article art=new Article();
art.setNomTable("article");
liste[1]=new Liste("article",art,"libelle","libelle");
pi.getFormu().changerEnChamp(liste);
pi.preparerDataFormu();
%>

<h1>Saisir Report</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisirpt" id="saisirpt">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="stockgazety/saisireport.jsp">
 <input name="classe" type="hidden" id="classe" value="stockgazety.Reportstock">
<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">
</form>
