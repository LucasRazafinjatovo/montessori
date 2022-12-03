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
        penalite.ParametrePenalite paraPen = null;

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
paraPen = u.loadParametrePenalite(Utilitaire.formatterDaty(pen.getDateFin()));
}catch(Exception e){
%>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
        <%
}
%>
<link href="style.css" rel="stylesheet" type="text/css">
<title>D&eacute;tails p&eacute;nalit&eacute; dommage conteneur</title><h1>D&eacute;tails p&eacute;nalit&eacute;s li&eacute;es aux dommages sur conteneur</h1>

<table width="450" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td>

	<table width="600" border="0" cellspacing="0" cellpadding="0" class="monographe">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td width="48%" class="left">&nbsp;Num&eacute;ro :</td>
                <td width="52%"><%=pen.getIdPenalite()%></td>
              </tr>
              <tr>
                <td class="left">&nbsp;Date d&eacute;but :</td>
                <td><%=Utilitaire.formatterDaty(pen.getDateDebut())%></td>
              </tr>
              <tr>
                <td class="left">&nbsp;Date fin :</td>
                <td><%=Utilitaire.formatterDaty(pen.getDateFin())%></td>
              </tr>
              <tr>
                <td valign="top" class="left">&nbsp;D&eacute;signation :</td>
                <td><%=pen.getDesignation()%></td>
              </tr>
              <tr>
                <td class="left">&nbsp;Montant :</td>
                <td><%=Utilitaire.formaterAr((double)pen.getMontant())%></td>
              </tr>
              <tr>
                <td class="left">&nbsp;Type :</td>
                <td><%=sctserv.getNomSCatService()%></td>
              </tr>
              <tr>
                <td class="left"> Nbre de conteneur manutentionn&eacute; :</td>
                <td>&nbsp;<%=pen.getChamp3()%></td>
              </tr>
              <tr>
                <td class="left">Nbre domm. sur cont(mtant&gt;5000 &euro;) :</td>
                <td>&nbsp;<%=pen.getChamp2()%></td>
              </tr>
              <tr>
                <td class="left">Ratio minimal :</td>
                <td>&nbsp;<%=paraPen.getSlRapEnDomTotal()%></td>
              </tr>
            </table></td>
  </tr>
</table>

</td>
  </tr>
</table>
<%

%>

<br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" class="monographe">
        <tr>
          <td height="30" align="center"><strong>&nbsp; Montant</strong> = ([<%=pen.getChamp2()%> x 100 / <%=pen.getChamp3()%> ] - <%=paraPen.getSlRapEnDomTotal()%> )x <%=pen.getChamp4()%> x <%=u.findChange("%","Eur",Utilitaire.formatterDaty(pen.getDateFin()))[0].getValeurEnAriary()%> = <%=Utilitaire.formaterAr((double)pen.getMontant())%></td>
        </tr>
      </table></td>
  </tr>
</table>
            
<br>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td><table width="100%" border="0" cellpadding="3" cellspacing="3" class="monographe">
        <tr> 
          <td height="30" align="center"><div align="justify">&#8226; Objectif 
              :<br>
              Le Concessionnaire devra s&#8217;engager &agrave; la diminution 
              des dommages caus&eacute;s aux conteneurs, dont le montant d&eacute;passe 
              cinq mille Euros. Il devra respecter, sur une base annuelle, le 
              ratio suivant :<br>
              Le nombre de dommages se chiffrant &agrave; plus de <%=paraPen.getValLimCont()%> euros divis&eacute; par le nb de conteneurs manutentionn&eacute;s 
              doit &ecirc;tre inf&eacute;rieur ou &eacute;gal &agrave; <%=paraPen.getSlRapEnDomTotal()%> %.<br>
              <br>
              &#8226; Sanction :<br>
              Chaque ann&eacute;e, lorsque le ratio de dommages sur conteneurs 
              est sup&eacute;rieur &agrave; <%=paraPen.getSlRapEnDomTotal()%> %, le Concessionnaire paie une p&eacute;nalit&eacute; 
              de <%=paraPen.getPxPtageExc()%> Euros par point additionnel d&#8217;&eacute;cart 
              (en %).<br>
              Exemple : avec un ratio de 2%, soit <%=paraPen.getSlRapEnDomTotal()%> % d&#8217;&eacute;cart, l&#8217;amende sera de <%=paraPen.getPxPtageExc()%> 
              Euros.<br>
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
  <a href='javascript:Popup("penalites/detailPenDommageCont.jsp?idPen=<%=pen.getIdPenalite()%>&a=yes","fenetre",800,600,"menubar=yes,scrollbars=yes,statusbar=no")'>Voir aperçu</a>
 <!-- <a href="penalites/detailPenDommageCont.jsp?idPen=<%=pen.getIdPenalite()%>&a=yes>" target="_blank">Voir
  aperçu</a>--></div>
<%
}
%>
