<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="historique.*" %>
<%@ page import="ded.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="prevision/apresFichePrevision.jsp";
	String lien= null;
        UserEJB u = null;
        OpVita op = null;
        OpVita[] lo = null;
        String id = null;
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
id = request.getParameter("id");
op = new OpVita();
op.setId(id);
lo = (OpVita[])CGenUtil.rechercher(op,null,null,"");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Modifier prévision dépense</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1>Modifier prévision dépense </h1>
<form name="traffic" method="post" action="<%=lien%>?but=<%=apres%>">
  <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr><td>
  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">

          <tr>
            <td align="left" valign="top" class="left">&nbsp;Id prev :</td>
            <td  align="center" valign="top"><input name="id" type="text" class="champ" readonly id="id" maxlength="10" value="<%=lo[0].getId()%>"/>&nbsp;</td>
          </tr>
          <tr>
            <td align="left" valign="top" class="left">&nbsp;Designation :</td>
            <td  align="center" valign="top"><TEXTAREA name="remarque" type="text" class="champ" id="remarque"  ><%=lo[0].getRemarque()%></textarea>&nbsp;

            </td>
          </tr>

          <tr>
            <td width="203" class="left"> &nbsp;Date :</td>
            <td align="center" valign="top">
                <input name="daty" type="text" class="champ" id="daty" maxlength="10" value="<%=Utilitaire.datetostring(lo[0].getDaty())%>">
                &nbsp;
              </td>
          </tr>
		  <tr>
            <td class="left"> &nbsp;Montant :</td>
           <td  align="center" valign="top">
			<input name="montant" type="text" class="champ" id="montant" value="<%=lo[0].getMontant()%>">&nbsp;


          </tr>
            <tr>
            <td class="left"> &nbsp;IdOp :</td>
           <td  align="center" valign="top">
              <input name="idor" type="text" class="champ" readonly id="idor" value="<%=lo[0].getIdor()%>" >&nbsp;</td>

          </tr>
            <tr>
            <td class="left"> &nbsp;ded_id :</td>
           <td  align="center" valign="top">
              <input name="ded_Id" type="text" class="champ" id="ded_Id" readonly value="<%=lo[0].getDed_Id()%>">&nbsp;</td>

          </tr>
        </table>

        <input name="acte" type="hidden" id="acte" value="update">
        <input name="bute" type="hidden" id="bute" value="prevision/fichePrevisionDetail.jsp">
        <input name="classe" type="hidden" id="classe" value="ded.OpVita">
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