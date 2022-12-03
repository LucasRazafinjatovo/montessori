<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="finance.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="pcg.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="pcg/apresCompte.jsp";
        String lien= null;
        UserEJB u = null;
       String acte="";
	    String pcompte="0";
        Pcg pcg[] = null;
		String idFact = null;
		String compte="";
		String libelle="";
		String idPCompte="";

     %>
<%
idFact=request.getParameter("idFacture");
acte= request.getParameter("acte");
out.println(acte);
if(idFact == null) idFact = "";
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");


	compte=request.getParameter("compte");if ((compte==null)||compte.compareTo("")==0) compte="";
	libelle=request.getParameter("libelle");if ((libelle==null)||libelle.compareTo("")==0) libelle="";
 	pcompte=request.getParameter("pcompte");if ((pcompte==null)||pcompte.compareTo("")==0) pcompte="";
	idPCompte=request.getParameter("idCompte");if ((idPCompte==null)||idPCompte.compareTo("")==0) idPCompte="%";
   // pcg = u.findCompteTab(idPCompte, "%", "%", "%")[0];

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="/finance/script.js"></script>
<link href="/finance/style.css" rel="stylesheet" type="text/css">
<h1>CREER NOUVEL COMPTE</h1>
<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="compte" id="compte">
<input name="idCompte" type="hidden" class="champ" id="idCompte" value="<%=idPCompte%>"> 
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
      <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">
	   <%
		  if (acte=="NEW"){
		  %>
          <tr> 
            <td class="left"></td>
            <td align="center"> <input name="pcompte" type="hidden" class="champ" id="pcompte" value="<%=pcompte%>"> 
              &nbsp; </td>
          </tr>
		  
		  
		   <% }else{
		  %>
		  
		  <tr> 
            <td class="left">Compte parent</td>
            <td align="center"> <input name="pcompte" type="text" class="champ" id="pcompte" value="<%=pcompte%>"> 
              &nbsp; </td>
          </tr>
		  <% }
		  %> 
		  
          <tr> 
            <td class="left">Compte : </td>
            <td align="center"> <input name="compte" type="text" class="champ" id="compte" value="<%=compte%>"> 
              &nbsp;<img src="../Asa/EJB/gestion%20croise%20dyn/gestion%20vv/affichage/finance/images/blank.gif" width="16" height="16" align="absmiddle"> 
            </td>
          </tr>
          <tr> 
            <td class="left">Libell&eacute; du compte: </td>
            <td align="center"> <input name="libelle" type="text" class="champ" id="libelle" value="<%=libelle%>"> 
              &nbsp;<img src="../Asa/EJB/gestion%20croise%20dyn/gestion%20vv/affichage/finance/images/blank.gif" width="16" height="16" align="absmiddle"> 
            </td>
          </tr>
        </table></td>
	</tr>
	<tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
		  
		 
		  <input name="acte" type="hidden" id="acte" value="<%=acte%>">
         
		  
		      <input type="submit" name="Submit" value="Enregistrer" class="submit">
          </td>
          <td align="center">
<input type="reset" name="annuler" value="R&eacute;tablir" class="submit">
          </td>
  </tr>
</table>
    </td>
	</tr>
</table>










</form>
<div align="center"> <span class="remarque">(*) Champs obligatoires</span></div>
