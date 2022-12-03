<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="bean.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<link href="style.css" rel="stylesheet" type="text/css">


<%!
        UserEJB u 			= null;
		String apres = "ded/enregistrerJointure.jsp";
		String lien  		=null;
		 String numObjet=null;
		 
		  String montantObjet=null;
		  String typeObjet=null;//Pour savoir si la table jointure
		  String tableJointure = null;
		
		 String[]numObjetJ=null;
		 String[] montant=null;
		 UnionIntraTable[] liste=null;
                 String acte=null;
				 String type
				 int testnonvalide=0;
%>
<%
try
{
// Saisie numObjet de l'objet mère et le type objet
testnonvalide=0;
  numObjet=request.getParameter("numObjet");if ((numObjet==null)||numObjet.compareTo("")==0) numObjet="%";
  typeObjet=request.getParameter("typeObjet");if ((typeObjet==null)||typeObjet.compareTo("")==0) typeObjet=Constante.getObjetDepense();


	numObjetJ=request.getParameterValues("numObjetJ");
	typeObjetJ=request.getParameter("typeObjetJ");
montantObjet=request.getParameter("montantObjet");

tableJointure=request.getParameterValues("tableJointure");

  lien	= (String)session.getValue("lien");
  u		= (UserEJB)session.getAttribute("u");
 liste =  u.findUnionIntraTable(tableJointure,"%","%",numObjet,"%","%","%","%","");
  
  
catch(Exception e){
  e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("erreur.jsp?message=<%=e.getMessage()%>"); </script>
<%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Visualisation de la jointure</h1>
<div align="center">RECAPITULATION
  <br>

</div>
Nature :

<table width="100%"  border="0" class="monographe">
  <tr>
    <td width="27%" class="left">Num <%=typeObjet%></td>
    <td width="73%"><div align="center"><%=numObjet%></div></td>
  </tr>
  <tr>
    <td class="left">Nature de l'objet</td>
    <td><div align="center"><%=typeObjet%></div></td>
  </tr>
  <tr>
    <td class="left">Montant</td>
    <td><div align="center"><%=Utilitaire.formaterAr(Utilitaire.stringToDouble(montantObjet))%> Ar </div></td>
  </tr>
</table>
<br>
<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeLC" id="listeLC">
<input type="hidden" value="<%=tableJointure%>" name="tableJointure"/>
<input type="hidden" value="<%=numObjet%>" name="numObjet"/>

<table width="100%"  border="0" class="monographe">
  <tr class="head">
    <td><div align="center">id</div></td>
    <td><div align="center">id <%=typeObjet%> </div></td>
    <td><div align="center">id LC </div></td>
    <td><div align="center">Montant</div></td>
    <td><div align="center">Remarque</div></td>
    <td><div align="center">etat</div></td>
  </tr>
  <%for (int j=0;j<liste.length;j++){%>
  <tr>
  <input type="hidden" name="idMapage" value="<%=liste[j].getId()%>">
  <input type="hidden" name="montant" value="<%=liste[j].getMontantMere()%>">
    <td height="25"><div align="center"><%=liste[j].getId()%></div></td>
    <td><div align="center"><%=liste[j].getId1()%></div></td>
    <td><div align="center"><%=liste[j].getId2()%></div></td>
    <td><div align="right"><%=Utilitaire.formaterAr(liste[j].getMontantMere())%> Ar </div></td>
    <td><div align="center"><%=liste[j].getRemarque()%></div></td>
    <td><div align="center">
	
	<%
if(liste[j].getEtat().compareToIgnoreCase("1")==0){
%>
<input type="checkbox" readonly="readonly" checked="checked" class="radio" name="idMapage" value="<%=liste[j].getId()%>">
<%
}else{
testnonvalide=1;
%>
 
<input type="checkbox" readonly="readonly" checked="checked" class="radio" name="idMapage" value="<%=liste[j].getId()%>">
<%
}
%>
	
	
	</div></td>
  </tr>  <%}%>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><div align="right"><strong><%=Utilitaire.formaterAr(AdminGen.calculSommeDouble(liste,4))%> Ar</strong></div></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
<table align ="center"><tr><td>
<input type="hidden" name="acte" value="valide">
<%
if(testvalide==1){
%>
<input type="submit" value="valider">
<%
}
%>
</td></tr></table>
</form>


</html>
