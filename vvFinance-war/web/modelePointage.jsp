<%@ page import="utilitaire.*" %>
<%@ page import="user.*" %>
<%!
        String but="index.jsp";
    String lien="modele.jsp";
    UserEJB u = null;
%>
<%
        if (session.getValue("lien")!=null)
                        lien=(String)session.getValue("lien");
        if((request.getParameter("but")!=null)&&session.getValue("u")!=null)
        {
                but=request.getParameter("but");
                lien=(String)session.getValue("lien");
        }
        else
        {
                but="index.jsp";
        }
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Gestion des recettes</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="style/style.css" rel="stylesheet" type="text/css">
<script src="calendar/calendar1.js"></script>
<SCRIPT language="JavaScript" src="script.js"></script>
<style type="text/css">
<!--
.Style1 {color: #364FA3}
-->
</style>
</head>
<body>
<link href="style/style.css" rel="stylesheet" type="text/css">
<div align="center">
  <table width="1024" border="0">
    <tr>
      <td><table width="100%" border="0">
          <tr>
            <td bgcolor="#364FA3"><img src="images/bateau.jpg" width="251" height="99"></td>
            <td bgcolor="#364FA3"><span class="titre"><img src="images/banner.gif" width="320" height="75"></span></td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td><table width="100%" border="0">
          <tr>
            <td width="14%" valign="top" bgcolor="#364FA3"><table width="100%" border="0">

                <tr>
                  <td class="Style1">&nbsp;</td>
                </tr>
                <tr>
                  <td class="Style1"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                        <td background="images/bg.gif" width="110" align="center" class="haut">Pointage</td>
                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                      </tr>
                      <tr>
                        <td bgcolor="#FFFFFF"></td>
                        <td bgcolor="#ffffff" align="center"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/pointage.jsp" class="menu">Enregistrer</a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/criterePointage.jsp" class="menu">Lister </a>                            </tr>
                        </table></td>
                        <td bgcolor="#FFFFFF"></td>
                      </tr>
                      <tr>
                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                        <td bgcolor="#ffffff"></td>
                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td class="Style1">&nbsp;</td>
                </tr>
                <tr>
                  <td class="Style1"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                      <td background="images/bg.gif" width="94" align="center" class="haut">Suivi Pub</td>
                      <td width="23"><img src="images/right.gif" width="15" height="25"></td>
                    </tr>
                    <tr>
                      <td bgcolor="#FFFFFF"></td>
                      <td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                          <tr>
                            <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=pub/saveVerifPub.jsp" class="menu">Enreg suivi </a></td>
                          </tr>
                          <tr>
                            <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/statPubSaisie.jsp" class="menu">Listersuivi pub </a>&nbsp;</td>
                          </tr>
                          <tr>
                            <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listePubMep.jsp" class="menu">comparer </a>&nbsp;</td>
                          </tr>
                          <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pub/listePub.jsp" class="menu">Lister pub </a>&nbsp;</td>
                            </tr>




                      </table></td>
                      <td bgcolor="#FFFFFF"></td>
                    </tr>
                    <tr>
                      <td><img src="images/left_b.gif" width="15" height="10"></td>
                      <td bgcolor="#ffffff"></td>
                      <td><img src="images/right_b.gif" width="15" height="10"></td>
                    </tr>
                  </table></td>
                </tr>
                <tr>
                  <td class="Style1">&nbsp;</td>
                </tr>
				<tr>
                  <td class="Style1"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td  width="15" height="25"><img src="images/left.gif" width="15" height="25"></td>
                        <td background="images/bg.gif" width="110" align="center" class="haut">Taches</td>
                        <td width="15"><img src="images/right.gif" width="15" height="25"></td>
                      </tr>
                      <tr>
                        <td bgcolor="#FFFFFF"></td>
                        <td bgcolor="#ffffff"><table cellspacing="0" cellpadding="0" border="0" align="center" width="120">
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp; <a href="<%=lien%>?but=pointage/Tache.jsp" class="menu">nouvelle Tache </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/listeTache.jsp" class="menu">Lister Tache </a>&nbsp;</td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/saveContact.jsp" class="menu">Nouveau contact </a></td>
                            </tr>
                            <tr>
                              <td><img src="images/puce.gif" width="11" height="11">&nbsp;&nbsp;<a href="<%=lien%>?but=pointage/listContact.jsp" class="menu">Lister contact </a></td>
                            </tr>
                        </table></td>
                        <td bgcolor="#FFFFFF"></td>
                      </tr>
                      <tr>
                        <td><img src="images/left_b.gif" width="15" height="10"></td>
                        <td bgcolor="#ffffff"></td>
                        <td><img src="images/right_b.gif" width="15" height="10"></td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td class="Style1">&nbsp;</td>
                </tr>
                <tr>
                  <td class="Style1"><div align="center"><a href="<%=lien%>?but=Fermer.jsp" class="disconnect">Fermer
                    session </a></div></td>
                </tr>
            </table></td>
            <td width="71%" valign="top"><table width="100%" border="0">
                <tr>
                  <td><span class="modele">:: Pointage </span> </td>
                </tr>
                <tr>
                  <td><div align="center">
                    <jsp:include page='<%=but%>'/>
                  </div></td>
                </tr>
            </table></td>
            <td width="15%" valign="top">&nbsp;</td>
          </tr>
      </table></td>
    </tr>
    <tr>
      <td><div align="center"><span class="copy">&copy; JREWS
        Informatika</span> </div></td>
    </tr>
  </table>
</div>
</body>

<script type="text/javascript">

function pagePopUp(page,width,height){
        w= 750;
        h= 600;
        t ="DETAILS";

        if (width!=null||width=="")
        {
                w=width;
        }
        if(height!=null||height==""){
                h = height;
        }

       window.open(page,t,"titulaireresizable=no,scrollbars=yes,location=no,width="+w+",height="+h+",top=0,left=0");
 }

 function getChoix(){
  setTimeout("document.frmselect.submit()",800);
}
</script>

</html>
