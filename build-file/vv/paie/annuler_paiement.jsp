<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="paie.Solde_attache" %>
<%@ page import="paie.Demande_attache" %>
<%@ page import="affichage.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="paie.DefaultPaieUrl" %>
<%@page import="java.util.Vector" %>
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<script type="text/javascript" src="../jquery-1.7.min.js"></script>
<script type="text/javascript" src="../spin.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
var opts = {
lines: 13, // The number of lines to draw
length: 20, // The length of each line
width: 10, // The line thickness
radius: 30, // The radius of the inner circle
corners: 1, // Corner roundness (0..1)
rotate: 0, // The rotation offset
direction: 1, // 1: clockwise, -1: counterclockwise
color: '#000', // #rgb or #rrggbb
speed: 1, // Rounds per second
trail: 60, // Afterglow percentage
shadow: false, // Whether to render a shadow
hwaccel: false, // Whether to use hardware acceleration
className: 'spinner', // The CSS class to assign to the spinner
zIndex: 2e9, // The z-index (defaults to 2000000000)
top: 'auto', // Top position relative to parent in px
left: 'auto' // Left position relative to parent in px
};
var target = document.getElementById('loading');
var spinner = new Spinner(opts).spin(target);
});
</script>

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<div id="loading">Veuillez patienter s'il vous plaît...</div>
<%
  UserEJB u = null;
String acte=null;
String lien=null;
String bute = "";
String rajoutLie="";
String urlAjax = "";

String idop = request.getParameter("idop");

Connection con = null;
try
{
  lien=(String)session.getValue("lien");
  u=(UserEJB)session.getAttribute("u");
  if(con==null)con = new UtilDB().GetConn();
  con.setAutoCommit(false);


  String[]rajoutLien=null;
  String val="";
  String tempRajout=request.getParameter("rajoutLien");
  if(tempRajout!=null&&tempRajout.compareToIgnoreCase("")!=0)
  {
    rajoutLien=Utilitaire.split(tempRajout,"-");
  }
  if(bute==null||bute.compareToIgnoreCase("")==0) bute="pub/Pub.jsp";

  String classe=request.getParameter("classe");
  ClassMAPTable t=null;
  if(classe==null||classe.compareToIgnoreCase("")==0) classe="pub.Montant";
%>
          <script type="text/javascript">
$.ajax({
          url: '<%=DefaultPaieUrl.urlPaie%>/annulerop?idop=<%=idop%>',
          complete:function(data)
{
document.location.href = "<%=DefaultPaieUrl.urlRecette%>/modeleAdmin.jsp?but=ded/visualiserOP.jsp&id=<%=idop%>";
}
});
          </script>
<%
Solde_attache sol = new Solde_attache();
sol.setOrdrepaiement(idop);
Solde_attache[] liste = (Solde_attache[])CGenUtil.rechercher(sol,null,null,con,"");
for(int i=0;i<liste.length;i++)
{
  liste[i].deleteToTable(con);
}
if(liste.length==0)
{
  Demande_attache dem = new Demande_attache();
  dem.setOrdrepaiement(idop);
  Demande_attache[] listedem = (Demande_attache[])CGenUtil.rechercher(dem,null,null,con,"");
  for(int j=0;j<listedem.length;j++)
  {
    listedem[j].deleteToTable(con);
  }
}
con.commit();
}
catch (Exception e){
  e.printStackTrace();
  con.rollback();
           %>

          <script type="text/javascript"> alert("<%=e.getMessage()%>");history.back(); </script>
                          <%
                            return;
}
finally
{
  if(con!=null)con.close();
}
%>
</html>

