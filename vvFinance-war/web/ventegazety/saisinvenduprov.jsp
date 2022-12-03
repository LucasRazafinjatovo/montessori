<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="ventegazety.*" %>

<%
Invendu inv=new Invendu();
String listeCrt[]={"id","idprise","daty","nombreinvendu","remarque"};
//String listeInt[]={""};
PageInsert pi=new PageInsert(inv,request,(user.UserEJB)session.getValue("u"));
pi.setLien((String)session.getValue("lien"));
affichage.Champ[] liste=new affichage.Champ[1];
Vendeur ve=new Vendeur();
liste[0]=new Liste("vendeur",ve,"nom");
pi.preparerDataFormu();
%>
<h1>Saisir Invendu</h1>
<form action="<%=pi.getLien()%>?but=pub/apresTarif.jsp" method="post" name="saisinvenduprov" id="saisinvenduprov">

<%
out.println(pi.getFormu().getHtmlInsert());
%>
<label class="left entete">Nom:</label> <input type="text" name="vendeur" class="champ" />
</form>
<input type="reset" name="Submit2" value="Annuler" class="submit">
<input type="submit" name="Submit2" value="valider" class="submit">
 <input name="acte" type="hidden" id="nature" value="insert">
 <input name="bute" type="hidden" id="bute" value="ventegazety/saisinvenduprov.jsp">
 <input name="classe" type="hidden" id="classe" value="ventegazety.Invendu">
