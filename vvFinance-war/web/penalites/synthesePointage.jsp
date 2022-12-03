<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="penalite.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/apresInit.jsp";
        String lien= null;
        UserEJB u = null;
        historique.MapUtilisateur ut=null;
        String nomEmp=null;
        String datyInf = null;
        String datySup = null;
        SynthesePointage synt[] = null;
        int pazy=0;
        int nbParPazy=Parametre.getNbParPage();
%>
<%
nomEmp = request.getParameter("nomEmp");
datyInf= request.getParameter("datyInf");
datySup = request.getParameter("datySup");
pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
%>
<%
if(datyInf== null)datyInf="";
if(datySup== null)datySup="";
if(nomEmp == null) nomEmp ="%";
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
synt = u.finSynthese(datyInf,datySup);
 ut=u.getUser();
 }
catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("erreur.jsp?message=<%=e.getMessage()%>"); </script>
<%
}
%>
<script language="javascript">
function decision(message, url){
if(confirm(message)) location.href = url;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Synth&egrave;se pointage</h1>
<form action="<%=lien%>?but=penalites/synthesePointage.jsp" method="post" name="synthPointage" id="synthPointage">
  <table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr>
            <td width="238" height="24" class="left"> Date d&eacute;but :<strong>
              </strong></td>
            <td valign="top" align="center" width="350"><strong>
              <input name="datyInf" type="text" class="champ" id="nomClient2" value="<%=datyInf%>">
              &nbsp;<a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              </strong></td>
        </tr>
        <tr>
            <td width="238" height="24" class="left"> Date fin :<strong> </strong></td>
            <td valign="top" align="center" width="350"><strong>
              <input name="datySup" type="text" class="champ" id="nomClient2" value="<%=datySup%>">
              &nbsp;<a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a>
              </strong></td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td height="30" align="center">
      <table width="75%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
            <input name="Submit" type="submit" class="submit" value="Afficher">
          </td>
          <td align="center">
<input name="Submit2" type="reset" class="submit" value="R&eacute;tablir">
          </td>
  </tr>
</table>
    </td>
  </tr>
</table>
</form>

 <%
int pejy=0;
if(pazy==0){
        pejy=0;
        pazy=1;
}else{
        pejy=pazy-1;
}
int pazy1=nbParPazy*pejy;
int pazy2=pazy*nbParPazy;
if(pazy2>synt.length){
  pazy2=synt.length;
}
%>


<table cellpadding="0" cellspacing="0" border="0" width="600" align="center">
<tr>
    <td> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="127" height="25" align="center" valign="middle">Date d'op&eacute;ration</td>
          <td width="169" align="center" valign="middle">Code pointage </td>
          <td width="120" align="center" valign="middle">Num&eacute;ro escale</td>
          <td width="110" align="center" valign="middle">Nbre de cont.</td>
         </tr>
         <%
  for(int i=pazy1;i<pazy2;i++){
  %>
        <tr>
          <td width="127" height="25" align="center" valign="middle"><%=Utilitaire.formatterDaty(synt[i].getDtOpt())%></td>
          <td width="169" align="center" valign="middle"><%=synt[i].getCdPointCtn()%></td>
          <td width="120" align="center" valign="middle"><%=synt[i].getNmEsc()%></td>
          <td width="110" align="center" valign="middle"><%=synt[i].getNombre()%></td>
   </tr>
      <%
  }
  %>
    </table>
</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr>
<td height="25"><b>Nombre de r&eacute;sultat :</b> <%=synt.length%></td><td align="right"><%if(synt.length!=0){%><strong>page</strong> <%=pazy%> <b>sur</b> <%if(synt.length%nbParPazy==0)out.println(synt.length/nbParPazy);else out.println(synt.length/nbParPazy+1);}%></td></tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=penalites/synthesePointage.jsp&pazy=<%=pazy-1%>&datyInf=<%=datyInf%>&datySup=<%=datySup%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %>
  </td>
    <td width="305" align="right">
      <%
      if(synt.length>pazy2){
      %>
      <a href="<%=lien%>?but=penalites/synthesePointage.jsp&pazy=<%=pazy%>&datyInf=<%=datyInf%>&datySup=<%=datySup%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>
<script language="JavaScript">
var cal1 = new calendar1(document.forms['synthPointage'].elements['datyInf']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['synthPointage'].elements['datySup']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
