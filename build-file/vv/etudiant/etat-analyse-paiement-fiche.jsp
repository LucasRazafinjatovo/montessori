<%-- 
    Document   : rubrique-prix-entite-fiche
    Created on : 22 mai 2018, 12:08:03
    Author     : pro
--%>


<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%!
    EtatPaiement e;
    UserEJB u = null;
    historique.MapUtilisateur ut=null;
%>
<%
    e=new EtatPaiement();
    PageConsulte pc=new PageConsulte(e,request,(user.UserEJB)session.getValue("u"));//ou avec argument liste Libelle si besoin
    u=(user.UserEJB)session.getValue("u");
    ut=u.getUser();

%>
<html>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<h1>Fiche de paiement</h1>
<%
out.println(pc.getHtml());
%>
<a href="<%=(String)session.getValue("lien")%>"><u>Exit</u></a>
<br/>
 <div id="content">
    			<br>
    			<div id="tools">
					<form action="/montessori/imprimerRecu" method="post">
						<input type="hidden" name="action" value="imprimerRecu"/>
						<input type="hidden" name="id" value="<%=request.getParameter("id")%>"/>
						<input type="hidden" name="signature" id="impression"/>
                     <button class="link" type="submit" id="btnImprimer">Imprimer</button>
					</form>
				</div>
    		</div>
</html>
