<%@ page import="user.*" %>
<%@ page import="pointage.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%!

        String apres="pointage/apresPointage.jsp";
        String lien= null;
		TypeObjet[] source=null;
        String heureInf = null;
         String heureSup = null;
        String datyinf = null;
         String datySup = null,direction=null,entite=null;
          String idPointage = null;
          String datyDefaut=null;
          String nom = null;
          String type = null;
        String agence = null;
        String machine = null;
        String ip = null;
        UserEJB u = null;
        pointage.Tache[] fm=null;
        int pazy=0;
	int nbParPazy=Parametre.getNbParPage();
	lc.Direction dir[] = null;
        historique.MapUtilisateur[] sub=null;
		pointage.TacheVue tac=null;
		String idTache=null;
		EffTache []listeTache=null;
%>
<%
try{
	TypeObjet crt=new TypeObjet();

        u=(user.UserEJB)session.getValue("u");
        lien=(String)session.getValue("lien");
		idTache=request.getParameter("idTache");
        datyDefaut=request.getParameter("daty");if((datyDefaut==null)||(datyDefaut.compareTo("")==0)) datyDefaut=Utilitaire.dateDuJour();
        crt.setNomTable("Beneficiaire");
dir = u.findDirection("","","","","");
sub=u.findUserSubordonnee();
source=(TypeObjet[])CGenUtil.rechercher(crt,null,null," order by val asc");
EffTache crte=new EffTache();
crte.setTache(request.getParameter("idTache"));
listeTache=(EffTache[])bean.CGenUtil.rechercher(crte,null,null,"");
TacheVue crtt=new TacheVue();
crtt.setId(request.getParameter("idTache"));
crtt.setNomTable("tachelibelle");
tac=u.findTache(crtt,"","","")[0];
//findPointage(String idPointage, String user, String datyInf, String DateSup, String heureInf, String heureSup, String type, String rem, String ip, String agence, String machine) throws Exception, RemoteException;
}catch(Exception e){
%>
     <script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
<%
}
%>
	<link href="../style/style.css" rel="stylesheet" type="text/css">
	  <br>
	  <div align="center">&nbsp;<span class="ajouttitre">Detail de T&acirc;ches</span><br>
  <br>
</div>
<form action="<%=apres%>" method="post" name="tache">
 <input name="estTache" type="hidden" size="20" maxlength="50" value="estTacheInsert">
<table width="400" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td><table border="0" cellpadding="3" cellspacing="0" align="center" class="monographe" width="100%">
          <!--DWLayoutTable-->
          <tr>
          <td width="40%" height="23" valign="top" class="left">Date de la tache  :</td>
            <td width="60%" align="center" valign="top"><div align="center"><%=Utilitaire.formatterDaty(tac.getDatefin())%></div></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">Direction  :</td>
            <td align="center" valign="top"><div align="center"><%=tac.getDirection()%>
            </div></td>
        </tr>
        <tr>
          <td height="23" valign="top" class="left">entit&eacute; :</td>
            <td align="center" valign="top"><div align="center"><%=tac.getEntite()%>
            </div></td>
        </tr>
<tr>
  <td class="left" height="23">urgence : </td>
  <td align="center" valign="top"><div align="center"><%=tac.getUrgence()%></div></td>
</tr>
<tr>
  <td class="left" height="23">personne resp : </td>
  <td align="center" valign="top"><div align="center"><%=tac.getResp()%> </div></td>
</tr>
        <tr>
          <td height="23" valign="top" class="left">Designation :</td>
            <td align="center" valign="top"><div align="center"><%=tac.getDesignation()%> </div></td>
        </tr>
      </table></td>
  </tr>
  <tr>
      <td height="30" align="center">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center"><a href=<%=lien%>?but=pointage/transfert.jsp&idTache=<%=idTache%>>TRANSFERER</a></td>
          <td align="center"><a href=<%=lien%>?but=pointage/effTache.jsp&idTache=<%=idTache%>>EFFECTUER</a></td>
		  <td align="center"><a href=<%=lien%>?but=pointage/updateTache.jsp&idTache=<%=idTache%>>MODIFIER</a></td>
        </tr>
      </table>
      </td>
  </tr>
</table>
</form>
<div align="center" class="entete">HISTORIQUES DE LA TACHE
</div>
<table width="600" border="0" align="center" cellpadding="0" cellspacing="0" class="monographe">
  <tr class="head">
    <td  width ="15%" height="19" align="center">Daty</td>
    <td width ="15%" height="19" align="center">taux</td>
    <td width="70%" align="center">Comment</td>
  </tr>
  <%
  for(int i=0;i<listeTache.length;i++){
  %>
  <tr>
    <td ><div align="center"><%=Utilitaire.formatterDaty(listeTache[i].getDaty())%></div></td>
    <td >      <div align="center"><%=Utilitaire.formaterAr(listeTache[i].getTaux()) %></div></td>
    <td >      <div align="center"><%=listeTache[i].getCommentaire()%> </div></td>
  </tr>
  <%
  }
  %>
</table>
<br>
<table width="400" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
</tr>
</table>































