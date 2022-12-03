<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="historique.*" %>
<%@ page import="prevision.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="prevision/apresFichePrevision.jsp";
	String lien= null;
        UserEJB u = null;
        String listePrev=null;
        String[] temps=null;
        PrevisionRecette prec = null;
        PrevisionRecette[] lprec = null;
        String designation="";
        String montant=null;
        java.sql.Date daty=null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
listePrev = request.getParameter("idprev");
System.out.println(listePrev);
montant = request.getParameter("montant");
prec = new PrevisionRecette();
prec.setNomTable("PrevisionRecette");
designation="";
prec.setId(listePrev);
lprec = (PrevisionRecette[])CGenUtil.rechercher(prec,null,null,"");
designation=designation+" "+lprec[0].getRemarque();
daty=lprec[0].getDaty();


%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Modifier prevision recette</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1>Modifier prevision recette </h1>
<form name="traffic" method="post" action="<%=lien%>?but=<%=apres%>">
  <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr><td>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">

          <tr>
            <td align="left" valign="top" class="left">&nbsp;Id prev :</td>
            <td  align="center" valign="top"><%=listePrev%>&nbsp;</td>
          </tr>
          <tr>
            <td align="left" valign="top" class="left">&nbsp;Designation :</td>
            <td  align="center" valign="top"><%=designation%>&nbsp;
              <img src="images/blank.gif" width="16" height="16" align="absmiddle">
            </td>
          </tr>
          <tr>
            <td class="left"> &nbsp;Montant :</td>
           <td  align="center" valign="top">
			<input name="montant" type="text" class="champ" id="montant" value="<%=montant%>">&nbsp;</b>
              <img src="images/blank.gif" width="16" height="16" align="absmiddle">

          </tr>
          <tr>
            <td width="203" class="left"> &nbsp;Date :</td>
            <td> <div align="center">
                <input name="date" type="text" class="champ" id="date" maxlength="10" value="<%=Utilitaire.datetostring(daty)%>">
                &nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              </div></td>
          </tr>
		  <tr>
            <td class="left"> &nbsp;Remarque :</td>
           <td  align="center" valign="top"><b>
		   <textarea name="remarque" class="champ" id="remarque" ></textarea>

          </tr>
        </table>
        <input name="listePrev" type="hidden" id="acte" value="<%=lprec[0].getId()%>">
        <input name="acte" type="hidden" id="acte" value="UPDATE">
        <input name="nature" type="hidden" id="nature" value="PrevisionRecette">
   </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
            <td align="center">
<input name="Submit" type="submit" class="submit" value="Enregistrer">
            </td>
            <td align="center">
<input name="Submit2" type="reset" class="submit" value="Annuler">
            </td>
  </tr>
</table>

      </td>
    </tr>
  </table>
</form>
<p>
</p>
</body>
</html>
<%
}catch(Exception e){
	e.printStackTrace();
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>