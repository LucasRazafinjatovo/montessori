<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
String id=request.getParameter("id");
AbonnementJournalLibelle a=new AbonnementJournalLibelle();
AbonnementJournalLibelle [] aj=(AbonnementJournalLibelle [])CGenUtil.rechercher(a,null,null," and idabonnement="+id+"");
%>

<h1>Saisie Abonnement journal</h1>
<form action="<%=session.getValue("lien")%>?but=pub/apresTarifAbonnementJournal.jsp" method="post" name="saisipj" id="saisipj">
<table border="0">
<%
for(int i=0;i<aj.length;i++){
%>
<tr>
<td><input type="hidden" name="idoffrejournal" value="<%=aj[i].getIdoffrejournal()%>"></td>
<td><input type="hidden" name="idabonnement" value="<%=aj[i].getIdabonnement()%>"></td>
<td><input type="text" name="journal" value="<%=aj[i].getJournal()%>"></td>
<td><input type="text" name="quantite" value="<%=aj[i].getQuantite()%>"></td>
</tr>
<%}%>
</table>
<input type="submit" name="Submit2" value="valider" class="submit">
<input type="reset" name="Submit2" value="Annuler" class="submit">
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="ventegazety/abonnementJournal-liste.jsp">
 <input name="classe" type="hidden" id="classe" value="ventegazety.AbonnementJournal">
</form>
