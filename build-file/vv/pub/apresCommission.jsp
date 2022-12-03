<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="pub.*" %>
<%!
        UserEJB u = null;
        String acte = null;
        String bute;
        String lien=null;
        int nb=0;
        String[] com;
        String[] g;
        PubFactPaye p=null;
        CommissionPubPaye c=null;
        String idcom;
%><%
try{
lien=(String)session.getValue("lien");
          u=(UserEJB)session.getAttribute("u");
          bute=request.getParameter("bute");
          if(bute==null||bute.compareToIgnoreCase("")==0) bute="pub/listeCommissionPub.jsp";
          acte=request.getParameter("acte");
          if(acte.compareToIgnoreCase("insert")==0){
          String h=request.getParameter("nb");
          System.out.print("h="+h);
          if(h!=null && h.compareToIgnoreCase("")!=0) nb=Utilitaire.stringToInt(h);
          com=new String[nb];
          g=new String[1];
          p=new PubFactPaye();
          c=new CommissionPubPaye();
          CommissionPubPaye[] lc=new CommissionPubPaye[nb];
          for(int i=0;i<nb;i++)
          {
            com[i]=request.getParameter("commission"+i);
            if(com[i]==null){
             }
              else{
              p.setNomTable("pubfactnonop");
              PubFactPaye[] pf=(PubFactPaye[])CGenUtil.rechercher(p,null,null," and factclient='"+com[i]+"'");
              String maxid=u.getMaxId("commissionpubpaye");
              g=utilitaire.Utilitaire.split(maxid,"CPP");
              int k=utilitaire.Utilitaire.stringToInt(g[0]);int nbracine=k+1;
              idcom="CPP"+nbracine;
              u.createPayementCommissionMultiple(idcom,pf[0].getFactclient(),pf[0].getClient(),pf[0].getNumcompte());
              }
          }
          }%>
<script language="JavaScript"> document.location.replace("modeleAdmin.jsp?but=pub/listeCommissionPub.jsp&etat=pubfactnonpaye"); </script>
<% }catch(Exception e){
  e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');history.back(); </script>
<%
                return;
                }
                %>

