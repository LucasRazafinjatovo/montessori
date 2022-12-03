<%@ page import="user.*" %>
<%@ page import="finance.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="stock.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!
  String apres="facturefournisseur/listeFactureF.jsp";
  String lien= null;
  UserEJB u = null;
TypeObjet typeMvt = null;
MvtStock mvt= null;
MvtStock mvt1= null;
  String nomCol[]=null;
  double sommeEntree=0;
  String apresW=null;
Dossier[] dossier = null;
String id = null;
LettrageMvt[] letMvt =  null;
 %>
<%

  u=(UserEJB)session.getValue("u");
     lien=(String)session.getValue("lien");
     id = request.getParameter("id");
mvt=u.findMvtStock(id,"","","%","%")[0];
typeMvt = u.findTypeObjet("typeMvt",mvt.getTypeMvt(),"%")[0];
 letMvt = u.findLettrageMvt("%",id,"%");
     /*te = u.findTypeObjet("TypeEntree","%","%");
     clt = u.findClient("%", "%", "%", "%", "%", "%", "%", "%", "%", "%", "%");
     mp = u.findTypeObjet("Beneficiaire","%","%");

     caiss = u.findCaisse("%","%","%","%");*/

%>
<%
  try{

  // sommeEntree=AdminFF.getSommeEntree(factF,pazy1,pazy2);

}
catch (Exception e){
%>
<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
  return;
}
%>
<script language="javascript">
function page(page_dest){
        document.location=page_dest;
}
</script>
<link href="style.css" rel="stylesheet" type="text/css">
<h1>Confirmation de mouvement de stock entre entrepôt</h1>
<h2>Magasin source</h2>
<table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr>
    <td>


 <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="formadd">
  <tr>
   <td  valign="top" class="left">Référence mouvement :</td>
   <td  valign="top">&nbsp;<%=mvt.getId()%>
   </td>
 </tr>
          <tr>
   <td  valign="top" class="left">Type mouvement :</td>
   <td  valign="top"><font color="#FF0000"><%=typeMvt.getVal()%></font>
   </td>
 </tr>
 <tr>
   <td  valign="top" class="left">Date :</td>
   <td  valign="top">&nbsp;<%=Utilitaire.formatterDaty(mvt.getDaty())%>
   </td>
 </tr>
 <tr>
   <td  valign="top" class="left">Designation
     :</td>
   <td valign="top">&nbsp;designation<%=mvt.getDesignation()%></td>
 </tr>
 <tr>
   <td valign="top" class="left">Valeur</td>
   <td valign="top"><%=mvt.getDebit()%> <%=mvt.getUniteMvt()%></select>
           </td>
 </tr>
 <tr>
   <td valign="top" class="left">Magasin</td>
   <td valign="top">&nbsp;<font color="#003399"><%=mvt.getCompte()%></font>
           </td>
 </tr>
 <tr>
   <td valign="top" class="left">Remarque :</td>
   <td valign="top">&nbsp;<%=mvt.getRemarque()%></td>
 </tr>

      </table></td>
  </tr>
</table>




<hr align="center" color="#0099FF" noshade size="1" width="85%">


  <input name="action" type="hidden" id="action" value="ajouter">
  <input name="idMvmt" type="hidden" id="" value="">
  <br>

<h2>Liste magasin destination</h2>


<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr><td>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr><td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">

  <tr class="head">
    <td width="66"  height="20" align="center" >Magasin dest </td>
          <td width="132" align="center" >&nbsp;Quantit&eacute;</td>
                 <td width="26" align="center" valign="middle"></td>
<td width="26" align="center" valign="middle"></td>
     </tr>
                <%

                for(int i=0;i<letMvt.length;i++){
mvt1=u.findMvtStock(letMvt[0].getParent(),"","","%","%")[0];
        %>
     <tr>
          <td width="66"  height="20"><%=mvt1.getCompte()%></td>
          <td width="132"><%=mvt1.getCredit()%></td>
          <td width="26" align="center" valign="middle">
<a href="<%=lien%>?but=stock/dossier_mouvement.jsp&id=<%=mvt1.getId()%>">[dossier]</a>
</td>
        <td width="26" align="center" valign="middle"></td>
        </tr>
        <%
        }
                %>
          </table>
                </td></tr></table>

