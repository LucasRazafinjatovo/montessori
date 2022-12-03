<%@ page import="user.*" %>
<%@ page import="facture.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

        UserEJB u = null;
        String apres="facture/syntheseEvp.jsp";
        String lien= null;
        String datyInf = null;
        String datySup = null;
        facture.SyntheseEVP se[] = null;
        int pazy=0;
        int nbParPazy=Parametre.getNbParPage();
%>
<%
         datyInf = request.getParameter("datyInf");
         datySup = request.getParameter("datySup");
         if ((datyInf == null)|| datyInf.compareTo("")==0) datyInf="";
         if (datySup== null || datySup.compareTo("")==0) datySup="";
         pazy=Utilitaire.stringToInt(request.getParameter("pazy"));
%>
<%
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
se = u.findSyntheseEVP(datyInf,datySup);

}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Synth&egrave;se EVP</h1>
<p align="center" class="remarque">&nbsp;</p>
<form action="<%=lien%>?but=facture/syntheseEvp.jsp" method="post" name="listeFact">
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>


<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
          <tr>
            <td class="left">Date début :</td>
            <td><input name="datyInf" type="text" class="champ" id="datyInf" value="<%=datyInf%>">
              <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
            <td class="left">Date fin:</td>
            <td><input name="datySup" type="text" class="champ" id="datySup" value="<%=datySup%>">
              <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
          </tr>
        </table>



</td>
  </tr>
  <tr>
      <td height="30" align="center">
        <table width="75%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td align="center">
<input type="submit" name="Submit" value="Afficher" class="submit">
            </td>
            <td align="center">
<input name="Annuler" type="reset" class="submit" value="Annuler">
            </td>
          </tr>
        </table>
        <div align="center"></div></td>
  </tr>
</table>
</form>

<br>
<br>
<table cellpadding="0" cellspacing="0" border="0" width="600" align="center">
<tr>
    <td> <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
        <!--DWLayoutTable-->
        <tr class="head">
          <td width="96" height="25" align="center" valign="middle">Date </td>
          <td width="193" align="center" valign="middle">Quarante pied</td>
          <td width="191" align="center" valign="middle">Vingt pied</td>
          <td><div align="center">EVP</div></td>
        </tr>
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
if(pazy2>se.length){
  pazy2=se.length;
}
%>
   <%
  for(int i=pazy1;i<pazy2;i++){
  %>
        <tr>
          <td width="96" height="25" align="center" valign="middle"><%=Utilitaire.formatterDaty(se[i].getDaty())%></td>
          <td width="193" align="center" valign="middle"><%=se[i].getQuarante()%></td>
          <td width="191" align="center" valign="middle"><%=se[i].getVingt()%></td>
          <td width="116" align="center" valign="middle"><%=se[i].getEVP()%></td>
        </tr>
        <%
  }
  %>
      </table></td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
<tr>
<td height="25"><b>Nombre de r&eacute;sultat :</b> <%=se.length%></td><td align="right"><%if(se.length!=0){%><strong>page</strong> <%=pazy%> <b>sur</b> <%if(se.length%nbParPazy==0)out.println(se.length/nbParPazy);else out.println(se.length/nbParPazy+1);}%></td></tr>
    <tr>
    <td width="295" valign="top" height="25">
<%if(pazy!=1){%>
        <a href="<%=lien%>?but=penalites/syntheseEvp.jsp&pazy=<%=pazy-1%>&datyInf=<%=datyInf%>&datySup=<%=datySup%>">&lt;&lt;Page
      pr&eacute;c&eacute;dente</a>
<%

}
 pazy=pazy+1;
  %>
  </td>
    <td width="305" align="right">
      <%
      if(se.length>pazy2){
      %>
      <a href="<%=lien%>?but=penalites/syntheseEvp.jsp&pazy=<%=pazy%>&datyInf=<%=datyInf%>&datySup=<%=datySup%>">Page
      suivante&gt;&gt;</a>
     <%
     }
       %></td>
  </tr>
</table>

<br>
<script language="javascript">
var cal1 = new calendar1(document.forms['listeFact'].elements['datyInf']);
cal1.year_scroll = false;
cal1.time_comp = false;
var cal2 = new calendar1(document.forms['listeFact'].elements['datySup']);
cal2.year_scroll = false;
cal2.time_comp = false;
</script>
