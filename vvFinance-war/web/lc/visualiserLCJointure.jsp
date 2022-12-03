<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.*" %>
<%@ page import="bean.*" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<link href="style.css" rel="stylesheet" type="text/css">


<%!
        UserEJB u 			= null;
		String lien  		=null;
		 String numObjet=null;
		 String typeObjet=null;
		  String montantObjet=null;
		 String[]idLcArecup=null;
		 String[] montant=null;
		  UnionIntraTable[]  liste=null;
                 String acte=null;
%>
<%
try
{
  numObjet=request.getParameter("numObjet");if ((numObjet==null)||numObjet.compareTo("")==0) numObjet="%";
  typeObjet=request.getParameter("typeObjet");if ((typeObjet==null)||typeObjet.compareTo("")==0) typeObjet=Constante.getObjetDepense();
	idLcArecup=request.getParameterValues("idLC");
montantObjet=request.getParameter("montantObjet");if ((montantObjet==null)||montantObjet.compareTo("")==0) montantObjet="0";
acte=request.getParameter("acte");if ((acte==null)||acte.compareTo("")==0) acte="save";

  lien	= (String)session.getValue("lien");
  u		= (UserEJB)session.getAttribute("u");
  montant=new String[idLcArecup.length];
  liste=u.findUnionIntraTable(typeObjet, numObjet, "%", "%","%","","","%","");
}
catch(Exception e){
  e.printStackTrace();
%>
<script language="JavaScript"> document.location.replace("../erreur.jsp?message=<%=e.getMessage()%>"); </script>
<%
}
%>
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
<form action="<%=lien %>?but=lc/validerLcChoix.jsp" method="post" name="listeLC" id="listeLC">
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
    <td><div align="center"><%=liste[j].getId()%></div></td>
    <td><div align="center"><%=liste[j].getId1()%></div></td>
    <td><div align="center"><%=liste[j].getId2()%></div></td>
    <td><div align="right"><%=Utilitaire.formaterAr(liste[j].getMontantMere())%> Ar </div></td>
    <td><div align="center"><%=liste[j].getRemarque()%></div></td>
    <td><div align="center"><%=liste[j].getEtat()%></div></td>
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
</form>


</html>
