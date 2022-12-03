<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="lc.Direction" %>
<%@ page import="affichage.*" %>
<%@ page import="facture.*" %>
<%@ page import="facturefournisseur.*"%>


<%
//System.out.print("aaaaaaaaaaaaaaaaa   idType");
String keySearch=request.getParameter("recherche");
String action=request.getParameter("action");
try{
  if(action.compareTo("suggestions") == 0 && keySearch.compareTo("")!=0){
    Client crt=new Client();
    String ret = "";
    char [] CharkeySearch = keySearch.toCharArray();
    if(CharkeySearch.length <2){
      out.print("");
      return;
    }
    Client[]reponse=(Client[])CGenUtil.rechercher(crt,null,null," and upper(nom) like upper('%"+keySearch.trim()+"%') order by nom");

    if(reponse.length!=0){
%>
<%
  for(int i=0;i<reponse.length;i++){

    //out.print("<item id='"+reponse[i].getId()+"' name='"+reponse[i].getSurnom()+"'/>");
    ret+="<li id='"+reponse[i].getIdClient()+"' onclick='choixVendeur(this);'>"+reponse[i].getNom()+"</li>";
  }
    }
    out.print(ret);
  }
  if(action.compareTo("inforamtion") ==0){
    Client crt=new Client();
    crt.setIdClient(keySearch);
    Client[]reponse=(Client[])CGenUtil.rechercher(crt,null,null,"");
    String ret = "";
    if(reponse.length!=0){
      ret+= reponse[0].getTelephone() +"|" + reponse[0].getFax()+ "|" + reponse[0].getAdresse()+ "|"+ reponse[0].getNumstat()+"|"+ reponse[0].getNif()+"|"+reponse[0].getRc()+"|"+ reponse[0].getQuittance()+"|"+ reponse[0].getIdRegime()+"|"+ reponse[0].getTp()+"|"+reponse[0].getNom()+"|";
    }
    out.print(ret);
  }

  if(action.compareTo("tarifFact") ==0){
    FactureFournisseur crt=new FactureFournisseur("facturefournisseurviseAop");//
    crt.setIdFactureFournisseur(keySearch);
    FactureFournisseur[] reponse=(FactureFournisseur[])CGenUtil.rechercher(crt,null,null,"");
    String montant = "";
    if(reponse.length!=0){
      montant+= reponse[0].getMontantTTC();
    }else{
      throw new Exception("Le facture n 'existe pas");
    }
    out.print(montant);
  }
  if(action.compareTo("tarifFactRecette") ==0){
    FactureFournisseur crt=new FactureFournisseur("FACTURECLIENTVISEAOR");//
    crt.setIdFactureFournisseur(keySearch);
    FactureFournisseur[] reponse=(FactureFournisseur[])CGenUtil.rechercher(crt,null,null,"");
    String montant = "";
    if(reponse.length!=0){
      montant+= reponse[0].getMontantTTC();
    }else{
      throw new Exception("Le facture n 'existe pas");
    }
    out.print(montant);
  }
}
catch(Exception e){
  e.printStackTrace();
  System.out.print(e.getMessage());
return;
}
%>
