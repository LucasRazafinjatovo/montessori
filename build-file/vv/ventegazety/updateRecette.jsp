<%@ page import="user.*" %>
<%@ page import="ventegazety.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage="" %>
<%!
        String apres="ventegazety/apresTypeVente.jsp";
        String lien= null;
        UserEJB u = null;
        String id=null;
        Recette p=null;
        Recette[] lp=null;
        RecetteLibelle pl=null;
        RecetteLibelle[] lpl=null;
        String type=null;
     %>
<%
id=request.getParameter("id").trim();
type=request.getParameter("type");
try{
u=(user.UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
p=new Recette();
p.setId(id);
lp=(Recette[])CGenUtil.rechercher(p,null,null,"");
pl=new RecetteLibelle();
pl.setId(id);
lpl=(RecetteLibelle[])CGenUtil.rechercher(pl,null,null,"");
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
//out.println(datyinf + datySup + client + idEtat + idCatServ + idSsCatServ + numFact);
%>
<SCRIPT language="JavaScript" src="script.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">


<h1>Modifier recette</h1>
<h2>&nbsp;</h2>

<h2>&nbsp;</h2>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="recette" id="recette" target="_parent">

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td> <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0" class="monographe">

         <tr>
            <td class="left">id recette:</td>
            <td align="center"> <%=lp[0].getId()%><input name="id" type="hidden" id="id" value="<%=lp[0].getId()%>">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>

          <tr>
            <td class="left">publication:</td>
            <td align="center"> <%=lpl[0].getJournal()+" "+lpl[0].getNumparution()%>
              <input name="publicat" type="hidden" id="idprise" value="<%=lp[0].getPrise()%>">
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">        </td>
          </tr>

          <tr>
            <td class="left">Vendeur: </td>
            <td align="center"><%=lpl[0].getNom()%>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
          <tr>
            <td class="left">Daty : </td>
            <td align="center"> <input type="text" name="daty" id="champ" value="<%=Utilitaire.datetostring(lp[0].getDaty())%>"/>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
          <tr>
            <td class="left">Somme : </td>
            <td align="center"> <input type="text" name="nbre" id="champ" value="<%=lp[0].getSomme()%>"/>
              &nbsp;<img src="images/blank.gif" width="16" height="16" align="absmiddle">            </td>
          </tr>
        </table></td>
    </tr>
        <tr>
    <td height="30" align="center">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
          <td align="center">
           <input name="acte" type="hidden" id="acte" value="update">
              &nbsp;
                          <input type="hidden" name="place" value="" class="submit">&nbsp;
                          <input name="type" type="hidden" id="type" value="<%=type%>">
                          <input type="hidden" name="bute" value="ventegazety/listeInvendu.jsp">
                           <input type="hidden" name="classe" value="ventegazety.Invendu">
                          <input type="submit" name="Submit" value="Modifier" class="submit">


          </td>
  </tr>
</table>
    </td>
        </tr>
</table>
</form>
  <span class="remarque">(*) Champs obligatoires</span></div>