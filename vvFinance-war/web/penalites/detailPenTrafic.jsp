<%@page import="user.*" %>
<%@page import="bean.*" %>
<%@page import="penalite.*" %>
<%@page import="utilitaire.*" %>
<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/factureFille.jsp";
        String lien= null;
        UserEJB u = null;
        bean.TypeObjet unite[] = null;
        Penalite pen = null;
        String idPen = null;
     facture.SCatService  sctserv = null;
     String a = null;
%>
<%
a =request.getParameter("a");
if(a==null)a="";
idPen = request.getParameter("idPen");
%>
<%
try{
u=(UserEJB)session.getValue("u");
lien=(String)session.getValue("lien");
unite = u.findTypeObjet("unite","%","%");
//String idPenalite, String daty, String designation, String montant, String idSCatService, String champ1, String champ2, String champ3, String champ4
pen = u.findPenalite(idPen,"","%","%","%","%","%","%","%")[0];
sctserv = u.findSCatService(pen.getIdSCatService(), "%", "%", "%")[0];
}catch(Exception e){
%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
        <%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<title>D&eacute;tails p&eacute;nalit&eacute; trafic sur conteneur</title><h1>D&eacute;tails p&eacute;nalit&eacute;s li&eacute;es aux trafics de conteneurs</h1>

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>

	<table width="600" border="0" cellspacing="0" cellpadding="0" class="monographe">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td width="42%" align="right" class="left">&nbsp;Num&eacute;ro
                  :</td>
                <td width="58%" align="center"><%=pen.getIdPenalite()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Date d&eacute;but :</td>
                <td align="center"><%=Utilitaire.formatterDaty(pen.getDateDebut())%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Date fin :</td>
                <td align="center"><%=Utilitaire.formatterDaty(pen.getDateFin())%></td>
              </tr>
              <tr>
                <td align="right" valign="top" class="left">&nbsp;D&eacute;signation
                  :</td>
                <td align="center"><%=pen.getDesignation()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Montant :</td>
                <td align="center"><%=Utilitaire.formaterAr((double)pen.getMontant())%> Ar</td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Type :</td>
                <td align="center"><%=sctserv.getNomSCatService()%></td>
              </tr>
              <tr>
                <td align="right" class="left">Moyenne nombre de mouvements/shift/cale opérante :</td>
                <td align="center"><%=pen.getChamp2()%></td>
              </tr>
              <tr>
                <td align="right" class="left">Objectif de performance pour l'ann&eacute;e <%=Utilitaire.getAnnee(pen.getDateFin())%> :</td>
                <td align="center"><%=pen.getChamp3()%></td>
              </tr>
              <tr>
                <td align="right" class="left">Chiffre d'affaire TAC mois de <%=Utilitaire.nbToMois(Utilitaire.getMois(pen.getDateFin()))%> :</td>
                <td align="center"><%=pen.getChamp4()%> Ar</td>
              </tr>
            </table></td>
  </tr>
</table>

</td>
  </tr>
</table>


<br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr>
          <td height="30"><div align="center"><strong>Montant</strong> = ((<%=pen.getChamp3()%> - <%=pen.getChamp2()%>)/<%=pen.getChamp3()%>) x 1 x <%=pen.getChamp4()%> = <%=Utilitaire.formaterAr((double)pen.getMontant())%> Ar </div></td>
        </tr>
      </table></td>
  </tr>
</table>

            
<br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td><table width="100%" border="0" cellpadding="3" cellspacing="3" class="monographe">
        <tr> 
          <td height="30" align="center"><div align="justify">Chargement et d&eacute;chargement 
              des conteneurs :<br>
              Rendement ( performance) = nombre de mouvements/shift/cale op&eacute;rante.<br>
              Mouvement : nombre des conteneurs manipul&eacute;s durant l&#8217;op&eacute;ration 
              commerciale d&#8217;un navire.<br>
              &#8226; Objectifs : <br>
              <br>
              Objectif de performance pour l'ann&eacute;e <%=Utilitaire.getAnnee(pen.getDateFin())%> : <%=pen.getChamp3()%><br>
              <!--<table width="90%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolor="#000000">
                <tr>
                  <td width="48%">&nbsp;</td>
                  <td width="9%"><div align="center">2006</div></td>
                  <td width="11%"><div align="center">2007</div></td>
                  <td width="10%"><div align="center">2008</div></td>
                  <td width="10%"><div align="center">2009</div></td>
                  <td width="12%">2010 et +</td>
                </tr>
                <tr> 
                  <td>Nb moyen de mouvements / h / navire</td>
                  <td><div align="center">30</div></td>
                  <td><div align="center">34</div></td>
                  <td><div align="center">38</div></td>
                  <td><div align="center">42</div></td>
                  <td>45</td>
                </tr>
              </table>-->
              <p> &#8226; Sanction : &eacute;cart entre la performance r&eacute;alis&eacute;e 
                et la performance vis&eacute;e (en%) x 1 x le chiffre d&#8217;affaires 
                du mois consid&eacute;r&eacute;.<br>
                Exemple : <br>
                Mars 2006, Nb = 28 =&gt; Ecart de performance = (30-28)/30 = 6,66%<br>
                P&eacute;nalit&eacute; = 6,66% x 1 x CA du mois consid&eacute;r&eacute;. 
              </p>
             
            </div></td>
        </tr>
      </table></td>
  </tr>
</table>
<br>
<%
if(a.compareTo("yes")!=0){
%>
<div align="center"><br>
  <br>
  <!--
  <a href="penalites/detailPenTrafic.jsp?idPen=<%=pen.getIdPenalite()%>&a=yes" target="_blank">Voir
  aperçu</a>-->
  <a href='javascript:Popup("penalites/detailPenTrafic.jsp?idPen=<%=pen.getIdPenalite()%>&a=yes","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aperçu</a></div>
  <%
}
  %>

