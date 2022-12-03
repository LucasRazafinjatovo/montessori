<%@ page import="user.*" %>
<%@ page import="pub.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ventegazety/apresTypeVente.jsp";
        String lien= null;
        UserEJB u = null;
        String id=null;
        Parution p=null;
        Parution[] lp=null;
        Parution[] lpl=null;
        String type=null;
     %>
<%
id=request.getParameter("id");
type=request.getParameter("type");
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
p=new Parution();
p.setId(id);
lp=(Parution[])CGenUtil.rechercher(p,null,null,"");
p.setNomTable("parutionlibelle");
pl.setId(id);
lpl=(Parution[])CGenUtil.rechercher(p,null,null,"");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Modifier parution</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent" onsubmit="return (verifie(daty.value)&&verifie(designation.value)&&verifie(montant.value))">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">

         <tr>
            <td class="left">id parution:</td>
            <td align="center"> <%=lp[0].getId()%><input name="id" type="hidden" id="id" value="<%=lp[0].getId()%>">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
          <tr>
            <td class="left">Daty : </td>
            <td align="center"> <input type="text" name="daty" id="champ" value="<%=Utilitaire.datetostring(lp[0].getDaty())%>"/>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
          <tr>
            <td class="left">Journal : </td>
            <td align="center"> <input type="text" name="journal" id="champ" value="<%=lp[0].getNbreprise()%>"/>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
 <input name="tableJointure" type="hidden" id="tableJointure" value="<%=Constante.getObjetOp()%>">

          <input name="acte" type="hidden" id="acte" value="update">
              &nbsp;
                          <input type="hidden" name="place" value="" class="submit">&nbsp;
                          <input name="type" type="hidden" id="type" value="<%=type%>">
                          <input type="hidden" name="bute" value="ventegazety/listePrise.jsp">
                           <input type="hidden" name="classe" value="ventegazety.Prisejournal">
                          <input type="submit" name="Submit" value="Modifier">


          </td>
  </tr>
</table>
    </td>
        </tr>
</table>
</form>
  <span class="remarque">(*) Champs obligatoires</span></div>