<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="lc.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
        UserEJB u = null;
        String acte=null;
        String id=null;
        String lien=null;
        historique.MapUtilisateur ut = null;
        String username=null;
        String pwd=null;
%>
<%
try
{
  username="lalanirina";
  pwd="ambinintsoa";
  UserEJBClient uc=new UserEJBClient();
  u=uc.getInterface();
  u.testLogin(username,pwd);
  session.setAttribute("u", u);
  ut=u.getUser();
  Direction crd=new Direction();
  crd.setIdDir(ut.getAdruser());
  Direction[] ret=(Direction[])(CGenUtil.rechercher(crd,null,null,""));
  String id=request.getParameter("id");
 // System.out.println(id);
  String montant=request.getParameter("montant");
  String idsolde=request.getParameter("idsolde");
  //System.out.println(montant);
  if(ret.length>0)
  {
    session.setAttribute("dirlib",ret[0].getLibelledir());
    u.setIdDirection(ret[0].getLibelledir());
  }
  if(ut.getIdrole().compareTo("dg")==0)
  {
    lien="modeleAdmin.jsp";
    session.setAttribute("lien", lien);
    session.setAttribute("dir",ut.getAdruser());
    out.println("<script language='JavaScript'> document.location.replace('../"+lien+"?but=paie/orpSal.jsp&id="+id+"&montant="+montant+"&idsolde="+idsolde+"'); </script>");
  }
}catch (Exception e){
 %>

<script language="JavaScript"> document.location.replace("<%=lien%>?but=erreur.jsp&message=<%=e.getMessage()%>"); </script>
		<%
		return;
		}
		%>


<head>
<title>Document sans titre</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table width="425" border="0" cellspacing="0">
  <tr>
    <td><div align="justify"></div>
    </td>
  </tr>
</table>
</body>
</html>




