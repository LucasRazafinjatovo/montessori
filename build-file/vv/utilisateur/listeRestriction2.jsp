<%@ page import="user.*" %>
<%@page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="restriction.*" %>
<%@ page import="historique.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<script language="javascript">
<!--
function popupcentree(page,largeur,hauteur,options)
{
var top=(screen.height-hauteur)/2;
var left=(screen.width-largeur)/2;
window.open(page,"","top="+top+",left="+left+",width="+largeur+",height="+hauteur+","+options);
}
-->
</script>
<%!
        String apres="utilisateur/listeRestriction.jsp";
        String lien= null;
        MapRoles mr[] = null;
        UserEJB u = null;

%>
<%
/** on prend les restrictions **/
Connection c=new UtilDB().GetConn();

String[]listeResInsert=Restriction.getAllTableRestrict(c,"ACT1");
String[]listeResUpdate=Restriction.getAllTableRestrict(c,"ACT3");
String[]listeResDelete=Restriction.getAllTableRestrict(c,"ACT4");

System.out.println("Taille de insert "+listeResInsert.length);

u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
mr = u.findRole("%");
%>
 
<link href="style.css" rel="stylesheet" type="text/css">
<%=mr[0].getIdRole()%>
<%=mr[0].getDescRole()%>

<br/>
<br/>
<a href="<%out.print(lien);%>?but=utilisateur/formRestriction.jsp" style="color:#990000;font-size:18px" >Ajouter une restriction</a>
<h2>DROITS D'INSERTION</h2>
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center" >
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
        <tr class="head">
    <td width="20" height="19" valign="top"><strong>Table de restriction</strong></td>

    <td width="130" align="center"><strong>Profil</strong></td>
    <td width="20" height="19" valign="top"><strong>Ajouter profil</strong></td>
  </tr>
<%
for(int i=0;i<listeResInsert.length;i++)
{
  String[]listeProfIns=new Restriction().getAllProfil(listeResInsert[i],c,"ACT1");
%>
<tr>
<td ><%= listeResInsert[i]%></td>

<td bgcolor="#CCCCCC" align="center">
<%for(int j=0;j<listeProfIns.length;j++)
{
  out.print(listeProfIns[j]);
  if(j<listeProfIns.length-1)out.print(" , ");
}
%>
</td>
<td align="center">
<a href='javascript:popupcentree("listeRoleChoix.jsp?action=insert&tableRestriction=<%out.print(listeResInsert[i]);%>",800,1080,"menubar=no,scrollbars=yes,statusbar=no,resizeble=no")' style="color:#0099FF" >Ajouter</a>
</td>
</tr>
<% } %>
  </table>
</td>
  </tr>
</table>

<h2>DROITS DE MODIFICATION</h2>
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center" >
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
        <tr class="head">
    <td width="20" height="19" valign="top"><strong>Table de restriction</strong></td>

    <td width="130" align="center"><strong>Profil</strong></td>
    <td width="20" height="19" valign="top"><strong>Ajouter profil</strong></td>
  </tr>
<%
for(int i=0;i<listeResUpdate.length;i++)
{
  String[]listeProfModif=new Restriction().getAllProfil(listeResUpdate[i],c,"ACT3");
%>
<tr>
<td ><%= listeResUpdate[i]%></td>

<td bgcolor="#CCCCCC" align="center">
<%for(int j=0;j<listeProfModif.length;j++)
{
  out.print(listeProfModif[j]);
  if(j<listeProfModif.length-1)out.print(" , ");
}
%>
</td>
<td align="center">
<a href='javascript:popupcentree("listeRoleChoix.jsp?action=modif&tableRestriction=<%out.print(listeResUpdate[i]);%>",800,1080,"menubar=no,scrollbars=yes,statusbar=no,resizeble=no")' style="color:#0099FF" >Ajouter</a>
</td>
</tr>
<% } %>
  </table>
</td>
  </tr>
</table>

<h2>DROITS DE SUPPRESSION</h2>
<table width="600" border="0" cellspacing="0" cellpadding="0" align="center" >
  <tr>
    <td><table width="100%" border="0" align="center" cellpadding="3" cellspacing="3" class="monographe">
        <tr class="head">
    <td width="20" height="19" valign="top"><strong>Table de restriction</strong></td>

    <td width="130" align="center"><strong>Profil</strong></td>
    <td width="20" height="19" valign="top"><strong>Ajouter profil</strong></td>
  </tr>
<%
for(int i=0;i<listeResDelete.length;i++)
{
  String[]listeProfDel=new Restriction().getAllProfil(listeResDelete[i],c,"ACT4");
%>
<tr>
<td ><%= listeResDelete[i]%></td>

<td bgcolor="#CCCCCC" align="center">
<%for(int j=0;j<listeProfDel.length;j++)
{
  out.print(listeProfDel[j]);
  if(j<listeProfDel.length-1)out.print(" , ");
}
%>
</td>
</td>
<td align="center">
<a href='javascript:popupcentree("listeRoleChoix.jsp?action=delete&tableRestriction=<%out.print(listeResDelete[i]);%>",800,1080,"menubar=no,scrollbars=yes,statusbar=no,resizeble=no")' style="color:#0099FF" >Ajouter</a>
</td>
</tr>
<% } %>
  </table>
</td>
  </tr>
</table>



