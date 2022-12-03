<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
	String apres="facture/apresTraficEvp.jsp";
	String lien= null;
	Service svc[] = null;
        UserEJB u = null;
        facture.SCatService sCatServ = null;
        String mois = null;
        String annee = null;
        String date = null;
        int nombre;
%>
<%
mois = request.getParameter("dateDebut");
annee = request.getParameter("dateFin");
date = request.getParameter("date");
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
//String idService, String idSCatService, String daty1, String daty2, String unite, String des, String devise, String idClient
svc = u.findService("%", "%", "", "", "%", "%","%","%");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<h1>Ajout Trafic EVP </h1>
 <form name="traffic" method="post" action="<%=lien%>?but=<%=apres%>">
  <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr><td>
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">

          <tr>
            <td width="203" class="left"> &nbsp;Date :</td>
            <td> <div align="left">
                <input name="date" type="text" class="champ" id="date" maxlength="10" value="<%=request.getParameter("date")%>" disabled>
                &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>
          <tr>
            <td  align="left" valign="top" class="left">&nbsp;Mois de :</td>
            <td  align="center" valign="top"> <div align="left"><b><%=Utilitaire.nbToMois(Utilitaire.stringToInt(request.getParameter("dateDebut")))%></b> <img src="images/blank.gif" width="16" height="16" align="absmiddle"> 
              </div></td>
          </tr>
          <tr>
            <td align="left" valign="top" class="left">&nbsp;Année :</td>
            <td  align="center" valign="top"> <div align="left">
                <input name="dateFin" type="text" class="champ" id="dateFin" size="4" maxlength="4" value="<%=annee%>" disabled>
                &nbsp; <img src="images/blank.gif" width="16" height="16" align="absmiddle"> 
              </div></td>
          </tr>

          <tr>
            <td class="left"> &nbsp;Service :</td>
            <td align="center"> <div align="left">
                <select name="idService" class="champ" id="idService">
                  <%
for(int i=0;i<svc.length;i++){
  if(svc[i].getIdSCatService().compareTo("scat2")==0){
%>
                  <option value=<%=svc[i].getIdService()%> <%if(svc[i].getIdService().compareTo("serv18")==0)out.print("selected");%>><%=svc[i].getDesignation()%></option>
                  <%
  }
}
%>
                </select>
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"> 
              </div></td>
          </tr>
          <tr>
            <td height="20" class="left"> &nbsp;Nombre de conteneur :</td>
            <td height="20"> <div align="left">
                <input name="nombre" type="text" class="champ" id="nombre" value="<%=u.getNombreEVP(mois,annee)%>">
                &nbsp;
				<a href='javascript:Popup("facture/syntheseEvp1.jsp?mois=<%=mois%>&annee=<%=annee%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>[afficher]</a>
				<!--<a href="facture/syntheseEvp1.jsp?mois=<%=mois%>&annee=<%=annee%>" target="_blank">[afficher]</a>--></div></td>
          </tr>
          <tr>
            <td valign="top" class="left"> &nbsp;Remarque :</td>
            <td> <div align="left">
                <textarea name="remarque" class="champ" id="remarque"></textarea>
                &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
          </tr>

        </table>
  <input name="acte" type="hidden" id="acte" value="INSERT">
      <input name="date" type="hidden" id="date" value="<%=date%>">
      <input name="dateDebut" type="hidden" id="dateDebut" value="<%=mois%>">
      <input name="dateFin" type="hidden" id="dateFin" value="<%=annee%>"> </td>
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

</body>
</html>
