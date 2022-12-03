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
Formule prt=new Formule();
PageInsert pi=new PageInsert(prt,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[10];
Article art=new Article();
art.setNomTable("article");
liste[0]=new Liste("article",art,"libelle","libelle");
liste[1]=new Liste("article",art,"libelle","libelle");
liste[2]=new Liste("article",art,"libelle","libelle");
liste[3]=new Liste("article",art,"libelle","libelle");
liste[4]=new Liste("article",art,"libelle","libelle");
liste[5]=new Liste("article",art,"libelle","libelle");
liste[6]=new Liste("article",art,"libelle","libelle");
liste[7]=new Liste("article",art,"libelle","libelle");
liste[8]=new Liste("article",art,"libelle","libelle");
liste[9]=new Liste("article",art,"libelle","libelle");
pi.getFormu().changerEnChamp(liste);
pi.preparerDataFormu();
%>

<h1>Saisir nouvelle formule</h1>
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
