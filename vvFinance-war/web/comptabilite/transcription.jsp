<%@ page import="user.*" %>
<%@ page import="comptabilite.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>

<%
        String apres="comptabilite/apresCompta.jsp";
        String lien= null;
        UserEJB u = null;
        Societe caiss[] = null;
		TypeObjet journ[] = null;
     %>
<%
try{
	u=(user.UserEJB)session.getValue("u");
	lien=(String)session.getValue("lien");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>

<link href="style.css" rel="stylesheet" type="text/css">


<h1>Transcription</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>



<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<div class="box-footer">
            <a href="<%=lien%>?but=comptabilite/apresTranscription.jsp&acte=tiers">Transcrire tiers</a>
        </div>
	</tr>
	<tr>
		<div class="box-footer">
            <a href="<%=lien%>?but=comptabilite/apresTranscription.jsp&acte=depense">Transcrire depense</a>
        </div>
	</tr>
	<tr>
		<div class="box-footer">
            <a href="<%=lien%>?but=comptabilite/apresTranscription.jsp&acte=recette">Transcrire recette</a>
        </div>
	</tr>
	<tr>
		<div class="box-footer">
            <a href="<%=lien%>?but=comptabilite/apresTranscription.jsp&acte=tresor">Transcrire tresorerie</a>
        </div>
	</tr>
	<tr>
		<div class="box-footer">
            <a href="<%=lien%>?but=comptabilite/apresTranscription.jsp&acte=employe">Transcrire employe</a>
        </div>
	</tr>
</table>

<br>
<br>

<h1>Automatique</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>



<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<div class="box-footer">
            <a href="<%=lien%>?but=comptabilite/apresTranscription.jsp&acte=lettrage">Lettrage</a>
        </div>
	</tr>
	<tr>
		<div class="box-footer">
            <a href="<%=lien%>?but=comptabilite/apresTranscription.jsp&acte=declaration">Declaration</a>
        </div>
	</tr>
</table>







</form>