<%@ page import="user.*" %>
<%@ page import="lc.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    UserEJB u;
    Typelcrecette p = new Typelcrecette();
    p.setNomTable("TYPELCRECETTETOUS");
    u = (user.UserEJB) session.getValue("u");
    PageUpdate pc = new PageUpdate(p, request, (user.UserEJB) session.getValue("u"));
	
    pc.getFormu().getChamp("val").setLibelle("Libelle");
    pc.getFormu().getChamp("desce").setLibelle("Compte compta");
    

	affichage.Champ[] liste = new affichage.Champ[1];
	
	String[] affiche = {"Oui","Non"};
    String[] value = {"1","0"};
	Liste lst = new Liste();
    lst.ajouterValeur(value, affiche);
    liste[0] = lst;
    liste[0].setNom("etat");
	pc.getFormu().changerEnChamp(liste);
	
    pc.getFormu().getChamp("etat").setLibelle("Activ&eacute;");
	
    pc.preparerDataFormu();

%>
<h1> Modification Type LC Recette</h1>

<form action="<%=(String) session.getValue("lien")%>?but=pub/apresTarif.jsp" method="post" name="configuration" id="idvaldesce">
	<%
		out.println(pc.getFormu().getHtmlInsert());
	%>
	<input class="button" type="submit" name="Submit2" value="Modifier" class="submit">
	<input name="acte" type="hidden" id="acte" value="update">
	<input name="bute" type="hidden" id="bute" value="lc/listeTypeLcRec.jsp">
	<input name="classe" type="hidden" id="classe" value="lc.Typelcrecette">
</form>

