<%@page import="user.*" %>
<%@page import="bean.*" %>
<%@page import="penalite.*" %>
<%@page import="facture.*" %>
<%@page import="utilitaire.*" %>
<%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
        String apres="facture/factureFille.jsp";
        String lien= null;
        UserEJB u = null;
        bean.TypeObjet unite[] = null;
        Penalite pen = null;
        String idPen = null;
        facture.SCatService sctserv = null;
         ParametrePenalite paraPen = null;
          Change ch= null;


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
paraPen = u.loadParametrePenalite(Utilitaire.formatterDaty(pen.getDateFin()));
sctserv = u.findSCatService(pen.getIdSCatService(), "%", "%", "%")[0];
ch = u.loadChangeValide("Eur",Utilitaire.formatterDaty(pen.getDateFin()));
}catch(Exception e){
%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
        <%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<title>D&eacute;tails p&eacute;nalit&eacute; vol conteneur</title><h1>D&eacute;tails p&eacute;nalit&eacute;s li&eacute;es aux vols de conteneur</h1>

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
                <td align="center"><%=Utilitaire.formaterAr((double)pen.getMontant())%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Type :</td>
                <td align="center"><%=sctserv.getNomSCatService()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Nombre de vol an en cours
                  :</td>
                <td align="center"><%=pen.getChamp1()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Nombre de vol année précédente
                  :</td>
                <td align="center"><%=pen.getChamp2()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Seuil nombre de perte par
                  an :</td>
                <td align="center"><%=pen.getChamp3()%></td>
              </tr>
              <tr>
                <td align="right" class="left">&nbsp;Seuil rapport entre perte
                  annuel :</td>
                <td align="center"><%=pen.getChamp4()%></td>
              </tr>
               <tr>
                <td align="right" class="left">Change du <%=Utilitaire.formatterDaty(pen.getDateFin())%> :</td>
                <td align="center"><%=ch.getValeurEnAriary()%> Ar</td>
              </tr>
            </table></td>
  </tr>
</table>

</td>
  </tr>
</table><br>


<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr>
          <td height="30" align="center"> <strong>&nbsp;Montant</strong> = (<%=pen.getChamp1()%> - (<%=pen.getChamp2()%> x <%=pen.getChamp4()%> %)) x <%=paraPen.getPxUnVol()%> x <%=ch.getValeurEnAriary()%> = <%=Utilitaire.formaterAr((long)pen.getMontant())%> Ar </td>
        </tr>
      </table></td>
  </tr>
</table>
            
<br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td><table width="100%" border="0" cellpadding="3" cellspacing="3" class="monographe">
        <tr> 
          <td height="30" align="center"><div align="justify"> 
              <p>&#8226; Objectif :<br>
                Le Concessionnaire devra veiller &agrave; ce que le nombre de 
                vols ayant fait l&#8217;objet d&#8217;une plainte diminue d&#8217;ann&eacute;e 
                en ann&eacute;e. Il doit veiller &agrave; ce que le nombre de 
                pertes / vols pendant l&#8217;ann&eacute;e (N) repr&eacute;sente 
                50% de ceux de l&#8217;ann&eacute;e N-1, jusqu&#8217;&agrave; 
                ce que le nombre soit r&eacute;duit &agrave; moins de 5 par an.<br>
                <br>
                &#8226; Sanction : p&eacute;nalit&eacute; de 2500 Euros pour chaque 
                perte / vol additionnel<br>
                <u>Exemple :</u> <br>
                An 1 : taux de vol 40<br>
                An 2 : taux de vol 25<br>
                Ecart de performance : 25-(40*50%)=5<br>
                P&eacute;nalit&eacute; : 5 x 2500= 12500 Euros<br>
              </p>
            </div></td>
        </tr>
      </table></td>
  </tr>
</table>
<%
if(a.compareTo("yes")!=0){
%>

<div align="center"><br>
  <br>
  <!--<a href="penalites/detailPenVolConteneur.jsp?idPen=<%=pen.getIdPenalite()%>&a=yes" target="_blank">Voir
  aperçu</a>-->
   <a href='javascript:Popup("penalites/detailPenVolConteneur.jsp?idPen=<%=pen.getIdPenalite()%>","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aperçu</a></div>
  </div>

<%
}
%>

