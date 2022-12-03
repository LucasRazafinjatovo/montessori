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
Article ar=new Article();
PageInsert pi=new PageInsert(ar,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[2];
TypeObjet obj=new TypeObjet();
obj.setNomTable("unite_quantification");
liste[0]=new Liste("uniteQuantification",obj,"val");
TypeObjet obj2=new TypeObjet();
obj2.setNomTable("famille");
liste[1]=new Liste("famille",obj2,"val");
pi.getFormu().changerEnChamp(liste);
pi.preparerDataFormu();
%>

<h1>Saisir Article</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisiarticle" id="saisiarticle">
<%
pi.getFormu().makeHtmlInsertTabIndex();
out.println(pi.getFormu().getHtmlInsert());
%>
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="stockgazety/saisiarticle.jsp">
 <input name="classe" type="hidden" id="classe" value="stockgazety.Article">
<input name="rajoutLien" type="hidden" id="classe" value="publicat-daty">
</form>
