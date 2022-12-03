<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="prevision.*" %>
<%@ page import="ded.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
	Prevision p = new Prevision();
	String etat = "ORPREVISION";
	if(request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0)
		etat=request.getParameter("etat");
	p.setNomTable(etat);
	String listeCrt[]={"id", "daty", "montant", "remarque"};
	String listeInt[]={"daty", "montant"};
	String libEntete[]={"id", "daty", "montant", "remarque"};

	PageRecherche pr = new PageRecherche(p,request,listeCrt,listeInt,2,libEntete,4);
	pr.setUtilisateur((user.UserEJB)session.getValue("u"));
	pr.setLien((String)session.getValue("lien"));
	pr.setApres("ded/listeORPrevision.jsp");

	String colSomme[]={"montant"};
	pr.setNpp(100);
	pr.creerObjetPageMultiple(libEntete,colSomme);
%>
<h1>Liste Prevision Recette</h1>
<form action="<%=pr.getLien()%>?but=ded/listeORPrevision.jsp" method="post" name="listeop" id="listeop">
	<%
	out.println(pr.getFormu().getHtmlEnsemble());
	%>
	etat : 	<select name="etat" class="champ" id="etat" >
				<option value="ORPREVISION">Tous</option>
				<option value="ORPREVISIONAVISER"  <%if(etat.compareTo("ORPREVISIONAVISER")==0) out.println("selected");%>>Non vise</option>
				<option value="ORPREVISIONVISE"  <%if(etat.compareTo("ORPREVISIONVISE")==0) out.println("selected");%>> Vise</option>
			</select>
</form>
<%
	pr.setApresLienPage("&etat="+etat);
	String lienTableau[] = {pr.getLien()+"?but=ded/visualiserOR.jsp"};
	String colonneLien[] = {"id"};
	pr.getTableau().setLien(lienTableau);
	pr.getTableau().setColonneLien(colonneLien);
	out.println(pr.getTableauRecap().getHtml());%>
	<br>
	<%
	out.println(pr.getTableau().getHtmlWithCheckbox());
	out.println(pr.getBasPage());
	%>
