<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%@ page import="ded.*" %>
<%@ page import="prevision.*" %>
<%@ page import="finance.*" %>
  <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<%!
  UserEJB u = null;
  String acte=null;
  String lien=null;
  String bute;
%>
<%
  try
{
  lien=(String)session.getValue("lien");
  u=(UserEJB)session.getAttribute("u");
  acte=request.getParameter("acte");
  bute=request.getParameter("bute");
  String[]rajoutLien=null;
  String tempRajout=request.getParameter("rajoutLien");
  String tableBdd=request.getParameter("tableBdd");
  if(tempRajout!=null&&tempRajout.compareToIgnoreCase("")!=0)
  {
    rajoutLien=utilitaire.Utilitaire.split(tempRajout,"-");
  }
  if(bute==null||bute.compareToIgnoreCase("")==0) bute="pub/Pub.jsp";

  String classe=request.getParameter("classe");
  ClassMAPTable t=null;
  if(classe==null||classe.compareToIgnoreCase("")==0) classe="pub.Montant";
                if(acte.compareToIgnoreCase("retourcaisse")==0){
                                        String idMvt = request.getParameter("id");
                                        String idr = u.retournerMouvementDeCaisse(idMvt);
                                        bute = bute + "&id="+idr;
                }
                if(acte.compareToIgnoreCase("insert")==0)
                {
                  String [] idoffrejournal=request.getParameterValues("idoffrejournal");
                  String [] idabonnement=request.getParameterValues("idabonnement");
                  String [] quantite=request.getParameterValues("quantite");
                  for(int i=0;i<idabonnement.length;i++)
                  {
                    AbonnementJournal a=new AbonnementJournal();
                    a.setIdoffreJournal(idoffrejournal[i]);
                    a.setIdabonnement(idabonnement[i]);
                    a.setIdabonnement(quantite[i]);
                    u.createObject(a);
                  }
                }
                String rajoutLie="";
                if(rajoutLien!=null)
                {
                        for(int o=0;o<rajoutLien.length;o++)
                        {
                                String valeur = request.getParameter(rajoutLien[o]);
                                rajoutLie=rajoutLie+"&"+rajoutLien[o]+"="+valeur;
                        }
                }
                %>
                <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute+rajoutLie%>"); </script>
                <%
        }catch (Exception e){
                e.printStackTrace();
           %>
                        <script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
            <%
                return;
        }
        %>
</html>



