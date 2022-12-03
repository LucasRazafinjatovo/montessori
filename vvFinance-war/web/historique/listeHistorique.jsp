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
        int numPage = 1;
	int nombreElement=0;
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

String tempPage=request.getParameter("numPage");
if (tempPage!=null)
  numPage=Utilitaire.stringToInt(tempPage);
nombreElement=u.calculHistoriquePage(refUser,refObjet,objet,action,daty1,daty2);
nbPage=u.calculNombrePage(nombreElement);
//HistoriqueLocal rl = RecupereLocaleHistorique.recupHome().create();
                //a = rl.findHistoriquePage(refUser, refObjet, objet, action, daty1, daty2, numPage);
a=u.findHistoriquePage(refUser,refObjet,objet,action,daty1,daty2,numPage);
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
                      <option value="<%=obj[i].getObjet()%>" <%if(obj[i].getObjet().compareTo(objet)==0)out.println("selected");%>><%=obj[i].getDesc()%></option>
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
                      <option value="insert" <%if(action.compareTo("insert")==0)out.print("selected");%>>insert</option>
                      <option value="update" <%if(action.compareTo("update")==0)out.print("selected");%>>update</option>
                      <option value="delete" <%if(action.compareTo("delete")==0)out.print("selected");%>>delete</option>
                      <option value="login" <%if(action.compareTo("login")==0)out.print("selected");%>>login</option>
                        <option value="logout" <%if(action.compareTo("logout")==0)out.print("selected");%>>logout</option>
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
                      <option value="<%=ut[i].getRefuser()%>" <%if(String.valueOf(ut[i].getRefuser()).compareTo(refUser)==0)out.println("selected");%>><%=ut[i].getLoginuser()%></option>
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
                <input name="Submit" type="submit" class="submit" value="Afficher">
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
        <table width="100%" border="0" cellspacing="0" class="monographe" align="center">
        <tr class="head">
          <td width="15%" height="22">
            <div align="center">Date</div></td>
          <td width="15%">
            <div align="center">heure</div></td>
          <td width="15%">
            <div align="center">action</div></td>
          <td width="20%">
            <div align="center">Objet</div></td>
          <td width="15%">
            <div align="center">ref</div></td>
          <td width="20%">
            <div align="center">user</div></td>
        </tr>
        <%


        for(int i=0;i<a.length;i++)
        {
%>
        <tr class="tuple-tableau">
          <td><%=Utilitaire.formatterDaty(a[i].getDateHistorique())%></td>
          <td><div align="center"><%=a[i].getHeure()%></div></td>
          <td><div align="center"><%=a[i].getAction()%></div></td>
          <td><div align="center"><%=a[i].getObjet()%></div></td>
          <td><div align="center"><%=a[i].getRefObjet()%></div></td>
          <td><div align="center"><%=a[i].getIdUtilisateur()%></div></td>
        </tr>
        <%
        }
        %>
      </table>
<br>
<%
if ((refUser==null)||refUser.compareTo("%")==0) refUser="";
if ((refObjet==null)||refObjet.compareTo("%")==0) refObjet="";
if ((objet==null)||objet.compareTo("%")==0) objet="";
if ((action==null)||action.compareTo("%")==0) action="";
%>
      <table width="100%" border="0">
        <tr>
          <td width="50%"> <%if (numPage>1) { %>
            <span class="modele"><a href="<%=lien%>?but=historique/listeHistorique.jsp&numPage=<%=numPage-1%>&objet=<%=objet%>&daty1=<%=daty1%>&daty2=<%=daty2%>&refObjet=<%=refObjet%>&utilisateur=<%=refUser%>&action=<%=action%>"><font color="#0000FF" size="1" face="Verdana, Arial, Helvetica, sans-serif">&lt;&lt;&lt;&lt;&lt;Pr&eacute;cedent</font></a></span><strong><a href="<%=lien%>?but=historique/listeHistorique.jsp&numPage=<%=numPage-1%>&objet=<%=objet%>&daty1=<%=daty1%>&daty2=<%=daty2%>&refObjet=<%=refObjet%>&utilisateur=<%=refUser%>&action=<%=action%>"><font color="#0000FF" size="2" face="Geneva, Arial, Helvetica, sans-serif">
            </font></a></strong>
            <%}%> </td>
          <td> <%if (numPage<nbPage) { %>
            <div align="right" class="nextprev"><a href="<%=lien%>?but=historique/listeHistorique.jsp&numPage=<%=numPage+1%>&objet=<%=objet%>&daty1=<%=daty1%>&daty2=<%=daty2%>&refObjet=<%=refObjet%>&utilisateur=<%=refUser%>&action=<%=action%>"><font color="#0000FF" size="1" face="Verdana, Arial, Helvetica, sans-serif">Suivant
              &gt;&gt;&gt;&gt;&gt;</font></a></div>
            <%}%> </td>
        </tr>
      </table></td>
  </tr>

</table>
</body>
</html>
