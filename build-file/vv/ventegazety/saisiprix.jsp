<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>
<%!
public static String essai(String hoho)
{
  return "salut";
}
%>
<%
Prixjournal pj=new Prixjournal();
PageInsert pi=new PageInsert(pj,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[1];
TypeObjet ve=new TypeObjet();
ve.setNomTable("journal");
liste[0]=new Liste("journal",ve,"val");
pi.getFormu().changerEnChamp(liste);
pi.preparerDataFormu();
%>

<h1>Saisir Prix journal</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisipx" id="saisipx">

<%
out.println(pi.getFormu().getHtmlInsert());
%>
<input type="submit" name="Submit2" value="valider" class="submit">
<input type="reset" name="Submit2" value="Annuler" class="submit">
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="ventegazety/saisiprix.jsp">
 <input name="classe" type="hidden" id="classe" value="ventegazety.Prixjournal">
</form>
