<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="historique.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String lien=null;
        MapHistorique a[]=null;
        UserEJB u=null;
        Objet[] obj=null;
        MapUtilisateur[] ut=null;
        String refUser =null;
        String refObjet=null;
        String objet=null;
        String action=null;
        String daty1,daty2;
        int nbPage = 0;
        int nbParPage = 0;
%>
<%
try{
lien=(String)session.getValue("lien");
u=(UserEJB)session.getValue("u");
obj=u.findObjet("%","%");
ut=u.findUtilisateurs("%","%","%","%","%","%","%");
refUser=request.getParameter("utilisateur");if ((refUser==null)||refUser.compareTo("")==0) refUser="%";
refObjet=request.getParameter("refObjet");if ((refObjet==null)) refObjet="";
objet=request.getParameter("objet");if ((objet==null)||objet.compareTo("")==0) objet="%";
action=request.getParameter("action");if ((action==null)||action.compareTo("")==0) action="%";
daty1=request.getParameter("daty1");if ((daty1==null)||daty1.compareTo("")==0) daty1="";
daty2=request.getParameter("daty2");if ((daty2==null)||daty2.compareTo("")==0) daty2="";
}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
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
<h1>Lister Historique</h1>
<table width="600" border="0" cellpadding="0" align="center">
    <tr>
    <td>
<form action="<%=lien%>?but=historique/listeHistorique.jsp" method="post" name="historique">
<table width="100%" border="0">
        <tr>
          <td colspan="2"><table width="100%" border="0" cellspacing="0" class="monographe">
                <tr>
                  <td width="15%" height="28" align="left" class="left">
                    <div align="center">Objet</div></td>
                <td width="35%"><div align="center">
                      <select name="objet" class="champ" id="select2">
                        <option value="%">tous</option>
                      <%
  for (int i=0;i<obj.length;i++)
  {
%>
                      <option value="<%=obj[i].getObjet()%>"><%=obj[i].getDesc()%></option>
                      <%
    }
  %>
                    </select>&nbsp;
                      <img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
                  <td class="left" width="18%">
<div align="center">Action</div></td>
                <td width="32%"><div align="center">
                      <select name="action" class="champ" id="action">
                        <option value="%" selected>tous</option>
                      <option value="insert">insert</option>
                      <option value="update">update</option>
                      <option value="delete">delete</option>
                      <option value="login">login</option>
                        <option value="logout">logout</option>
                    </select>&nbsp;
                      <img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
              </tr>
              <tr>
                  <td height="28" class="left">
                    <div align="center">Utilisateur</div></td>
                <td><div align="center">
                      <select name="utilisateur" class="champ" id="utilisateur">
                        <option value="%">tous</option>
   <%
  for (int i=0;i<ut.length;i++)
  {
%>
                      <option value="<%=ut[i].getRefuser()%>"><%=ut[i].getLoginuser()%></option>
                      <%
    }
  %>
                    </select>&nbsp;
                      <img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
                  <td class="left">
<div align="center">Ref Objet</div></td>
                <td><div align="center">
                      <input name="refObjet" type="text" class="champ" id="refObjet" value="<%=refObjet%>">
                      &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle"></div></td>
              </tr>
              <tr>
                  <td height="28" class="left">
                    <div align="center">Date
                    Inf </div></td>
                <td><div align="center">
                      <input name="daty1" type="text" class="champ" id="daty1" value="<%=daty1%>">
                      &nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></div></td>
                  <td class="left">
<div align="center">Date Sup</div></td>
                <td><div align="center">
                      <input name="daty2" type="text" class="champ" id="daty2" value="<%=daty2%>">&nbsp;
                      <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></div></td>
              </tr>
            </table></td>
        </tr>
        <tr>
            <td height="30" align="right">
              <div align="center">
                <input name="Submit" type="submit" class="submit" value="Envoyer">
              </div></td>
          <td><div align="center">
                <input name="Submit2" type="reset" class="submit" value="Annuler">
            </div></td>
        </tr>
      </table>
	  </form>
	  <script language="javascript">
var cal1 = new calendar1(document.forms['historique'].elements['daty1']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['historique'].elements['daty2']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>



    </td>
  </tr>

</table>
</body>
</html>
