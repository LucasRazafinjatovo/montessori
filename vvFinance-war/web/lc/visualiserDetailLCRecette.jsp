<%@ page import="user.*"%>
<%@ page import="facture.*"%>
<%@ page import="finance.*"%>
<%@ page import="lc.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="bean.*"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" errorPage=""%>
<%!
  String apres = "lc/apresVisualiserLCRecette.jsp";

  String lien = null;
  UserEJB u = null;
  LigneCreditComplet l = null;
  String indiceSelection =  null;
  String numObjet = null;
  String readOnly = "readonly";
        %>
        <%
          try {
          u = (user.UserEJB) session.getValue("u");
          lien = (String) session.getValue("lien");
          String indiceSelection=request.getParameter("indice");
          if(indiceSelection==null) indiceSelection="";
          numObjet=request.getParameter("numObjet"+indiceSelection);
		LigneCreditCompletUtil lcu=new LigneCreditCompletUtil();
		lcu.setNomTable("LigneCreditRecetteComplet");
          l = ((LigneCreditComplet[])lcu.rechercher(1,numObjet))[0];


        } catch (Exception e) {
          %>
  <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
  <%
    }
  %>
  <SCRIPT language="JavaScript" src="script.js"></script>
  <link href="style.css" rel="stylesheet" type="text/css">
  <h1>Visualiser ligne de credit</h1>
  <h1>Ligne credit mère</h1>

<form action="<%=lien%>?but=<%=apres%>" method="post" name="listeRecette" id="listeRecette">
  <table width="450" border="0" align="center" cellpadding="0"
          cellspacing="0">
          <tr>
                  <td>
                 <table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
       <tr>
       <td class="left" width="40%">Id Ligne Crédit:</td>
       <td><%=l.getIdLigne() %></td>
       </tr>
         <tr>
       <td class="left">Désignation:</td>
       <td><%=l.getDesignation() %></td>
       </tr>
       <tr>
       <td class="left">Type d'utilisation:</td>
       <td><%=l.getTypeLC() %></td>
       </tr>
       <tr>
       <td class="left">Crédit Initial:</td>
       <td><%=Utilitaire.formaterAr(l.getCreditInitial()) %></td>
       </tr>
       <tr>
       <td class="left">Crédit Actuel:</td>
       <td><%=Utilitaire.formaterAr(l.getCreditModifier()) %></td>
       </tr>
       <tr>
       <td class="left">Crédit Dispo:</td>
       <td><%=Utilitaire.formaterAr(l.getCreditInitial()-l.getMontantEng()) %></td>
       </tr>
       <tr>
       <td class="left">Montant Engagé:</td>
       <td><%=Utilitaire.formaterAr(l.getMontantEng())  %></td>
       </tr>
       <tr>
       <td class="left">Montant Visa:</td>
       <td><%=Utilitaire.formaterAr(l.getMontantVis()) %></td>
       </tr>
       <tr>
       <td class="left">Montant Facturé:</td>
       <td><%=Utilitaire.formaterAr(l.getMontantFac()) %></td>
       </tr>
       <tr>
       <td class="left">Direction:</td>
       <td><%=l.getLibelledir()+" ("+l.getAbbrevdir()+")" %></td>
       </tr>
       <tr>
       <td class="left">Entité:</td>
       <td><%=l.getEntite() %></td>
       </tr>
       <tr>
       <td class="left">Num Compte:</td>
       <td><%=l.getNumCompte()+ " ("+l.getDescCompte()+")" %></td>
       </tr>
       <tr>
       <td class="left">Excercice:</td>
       <td><%=l.getMois()+ " / "+l.getAnnee() %></td>
       </tr>

  </table>
                  </td>
          </tr>
          <tr>
                  <td height="30" align="center">
      <input type="hidden" name="acte" value="detail" />
      <input type="hidden"  name="numobjet" value="<%=l.getIdLigne()%>">
                  <table width="75%" border="0" cellspacing="0" cellpadding="0">
                          <tr>
                            <td align="center">
<% if(u.getUser().getLoginuser().compareToIgnoreCase("tahina")==0){ %>
<input type="submit" name="Submit"  class="submit" onClick="acte.value='detail'" value="Creer Detail"></td>
<td align="center"><input type="submit" name="Submit"  class="submit" onClick="acte.value='modif'" value="Modifier LC"></td>
<td align="center"><input type="submit" name="Submit"  class="submit" onClick="acte.value='dupliquer'" value="Dupliquer LC"></td>

<% } %>
                          </tr>
                  </table>
                  </td>
          </tr>
  </table>
  </form>
