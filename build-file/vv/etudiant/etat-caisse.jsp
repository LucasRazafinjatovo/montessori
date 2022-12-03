<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="etudiant.*" %>
<%@ page import="promotion.*" %>
<%@ page import="etudiant.*" %>
<%  
    
  
    
    String dateDebut,dateFin,idecole;
    String[] debutFin=null;
    String lien=(String)session.getValue("lien");
    String nomPage = "etudiant/etat-caisse.jsp";
    dateDebut=request.getParameter("dateDebut");
    dateFin=request.getParameter("dateFin");
    idecole=request.getParameter("idecole");
    if(dateDebut==null || dateDebut.trim().isEmpty()){dateDebut=Utilitaire.formatSqlDate(Utilitaire.dateDuJour().replace('/','-'));}
    if(dateFin==null || dateFin.trim().isEmpty()){dateFin=Utilitaire.formatSqlDate(Utilitaire.dateDuJour().replace('/','-'));}
    if(idecole==null){idecole="%";}
    System.out.println("date debut = "+dateDebut);
    System.out.println("date fin = "+dateFin);
    Ecole[] ecole=Utilitaire.listecole();
    EtatDeCaisse caiss[] =Utilitaire.getEtatCaisse(dateDebut,dateFin,idecole);
     String rajoutLien = "&daty1="+dateDebut+"&daty2="+dateFin;
%>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Etats des caisses </h1>
<p align="center" class="remarque">(choisir les crit&egrave;res de votre recherche
  concernant les mouvements de caisse)</p>
<form action="<%=lien%>?but=<%=nomPage%>" method="post" name="listeRecette" id="listeRecette">
  <table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
    <tr>
      <td><table width="600" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr>
          <td>
            <table width="100%" border="0" cellpadding="5" cellspacing="0" align="center" class="monographe">
              <tr>
                <td class="left">Date d&eacute;but :</td>
                <td><input name="dateDebut" id="dateDebut" type="date" class="champ" size="10" maxlength="10" value="<%=dateDebut%>">
                    <a href="javascript:cal1.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
                <td class="left">Date fin:</td>
                <td><input name="dateFin"  id="dateFin" type="date" class="champ" size="10" value="<%=dateFin%>">
                    <a href="javascript:cal2.popup()"><img src="calendar/img/cal.gif" alt="Cliquez ici pour choisir une date" width=16 height=16 border=0 align="absmiddle"></a></td>
              </tr>

             <tr>
                <td class="left">Ecole :</td>
                <td><select name="idecole" class="champ" id="idecole">
                    <option value="%">Tous</option>
                    <%
                    for(int i=0;i<ecole.length;i++){ %>
                    <option value="<%=ecole[i].getId()%>"><%=ecole[i].getNom()%></option>
                    <%} %>
                </select></td>
          
              </tr>
          </table></td>
        </tr>
        <tr>
          <td height="30" align="center">
            <table width="75%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center">
                  <input type="submit" name="Submit2" value="Afficher" class="submit">
                </td>
                <td align="center">
                  <input name="Annuler" type="reset" class="submit" value="Annuler">
                </td>
              </tr>
            </table>
            <div align="center"></div></td>
        </tr>
      </table></td>
    </tr>

  </table>
</form>


<table border="0" cellpadding="0" cellspacing="0" align="center" width="600">
  <tr>
    <td>
      <br>
      <p align="center"><strong><u>DETAIL PAR CAISSE</u></strong></p>
      <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="monographe">
        <tr class="head">
          <td width="18" align="center" valign="top"><div align="center">Caisse</div></td>
          <td width="116" align="center" valign="top"><div align="center">Date report</div></td>
          <td width="116" align="center" valign="top"><div align="center">Report</div></td>
          <td width="146" align="center" valign="top"><div align="center">Somme Debit</div></td>
          <td width="160" align="center" valign="top"><div align="center"><strong>Somme Credit </strong></div></td>
          <td width="126" align="center" valign="top"><div align="center">Reste</div></td>
            <td width="18" align="center" valign="top"><div align="center">Ecole</div></td>
        </tr>

    <% for(int j=0;j<caiss.length;j++) {%>
        <tr onmouseover="this.style.backgroundColor='#EAEAEA'" onmouseout="this.style.backgroundColor=''">
          <td align="right"><div align="center"><a href="<%=lien%>?but=etudiant/etat-caisse-fiche.jsp&idcaisse=<%=caiss[j].getIdcaisse()%><%=rajoutLien%>"><%=caiss[j].getCaisse()%></a></div></td>
           <td align="center"><div align="center"><%=caiss[j].getDaty()%></div></td>
          <td align="center"><div align="center"><%=caiss[j].getMontant()%></div></td>
          <td align="center"><div align="center"><%=caiss[j].getDebit()%></div></td>
          <td align="center"><div align="center"><%=caiss[j].getCredit()%></div></td>
          <td align="center"><div align="center"><%=caiss[j].getReste()%></div></td>
          <td align="center"><div align="center"><%=caiss[j].getEcole()%></div></td>
        </tr>
	<% } %>
      </table>      <p align="center">&nbsp;</p></td>
  </tr>
</table>
<br>
