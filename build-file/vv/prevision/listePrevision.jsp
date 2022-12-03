<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="prevision.*" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%

PrevRecetteSum e=new PrevRecetteSum();
String etat="PREVRECETTESUM";

PrevDepenseSum previsionDepenseSum =new PrevDepenseSum();
String etatPrevDepense = "PREVDEPENSESUM";

e.setNomTable(etat);
String listeCrt[]={"daty"};
String listeInt[]={"daty"};
String libEntete[]={"daty"};

PageRecherche pr=new PageRecherche(e,request,listeCrt,listeInt,2);
pr.setUtilisateur((user.UserEJB)session.getValue("u"));
pr.setLien((String)session.getValue("lien"));
pr.setApres("prevision/listePrevision.jsp");
String[]colSomme=null;
pr.creerObjetPage(libEntete,colSomme);
String daty1 = request.getParameter("daty1"); if(daty1==null || daty1.compareToIgnoreCase("")==0) daty1="01/"+Utilitaire.getMoisEnCours()+"/"+Utilitaire.getAneeEnCours();
String daty2 = request.getParameter("daty2"); if(daty2==null || daty2.compareToIgnoreCase("")==0) daty2="15/"+Utilitaire.getMoisEnCours()+"/"+Utilitaire.getAneeEnCours();
String unionListDates = "";

// Recette
PrevRecetteSum prs=new PrevRecetteSum();
prs.setNomTable("prevrecettedate");
PrevRecetteSum[] ldate=(PrevRecetteSum[])CGenUtil.rechercher(prs,null,null," and '"+daty1+"'<=daty and daty<='"+daty2+"' order by daty ASC");
prs.setNomTable("prevrecettedesignation");
PrevRecetteSum[] ldesigDoublon=(PrevRecetteSum[])CGenUtil.rechercher(prs,null,null," and '"+daty1+"'<=daty and daty<='"+daty2+"'");
PrevRecetteSum[] ldesign = new PrevRecetteSum[ldesigDoublon.length];
for(int k=0;k<ldesigDoublon.length;k++){
  String test = ldesigDoublon[k].getDesignationlc();
  boolean ok = true;
  for(int i=(k+1);i<ldesigDoublon.length;i++){
    if(test.equalsIgnoreCase(ldesigDoublon[i].getDesignationlc())){
      ok = false;
      break;
    }
  }
  if(ok){
    ldesign[k] = ldesigDoublon[k];
  }
}


// Depense
previsionDepenseSum.setNomTable("PREVDEPENSEDATE");
PrevDepenseSum[] listDatePrevDepense = (PrevDepenseSum[])CGenUtil.rechercher(previsionDepenseSum,null,null," and '"+daty1+"'<=daty and daty<='"+daty2+"' order by daty ASC");
previsionDepenseSum.setNomTable("PREVDEPENSEDESIGNATION");
PrevDepenseSum[] designPrevDepense = (PrevDepenseSum[])CGenUtil.rechercher(previsionDepenseSum,null,null," and '"+daty1+"'<=daty and daty<='"+daty2+"'");
PrevDepenseSum[] listeDesignPrevDepense = new PrevDepenseSum[designPrevDepense.length];
for(int k=0;k<designPrevDepense.length;k++){
  String test = designPrevDepense[k].getDesignationlc();
  boolean ok = true;
  for(int i=(k+1);i<designPrevDepense.length;i++){
    if(test.equalsIgnoreCase(designPrevDepense[i].getDesignationlc())){
      ok = false;
      break;
    }
  }
  if(ok){
    listeDesignPrevDepense[k] = designPrevDepense[k];
  }
}

%>
<h1>Etat pr&eacute;vision </h1>
<form action="<%=pr.getLien()%>?but=prevision/listePrevision.jsp" method="post" name="listeprevision" id="listeprevision">
<%
out.println(pr.getFormu().getHtmlEnsemble());%>
</form>
<!--LISTE ETAT DEPENSE-->
<p align="center"><strong><u>ETAT DEPENSE</u></strong></p>
<div id="scroll1" style="overflow:scroll; height:250px;">
<table border="1" cellpadding="0" cellspacing="0" align="center" class="monographe" width="100%">
  <tr class="head" height="30">
     <td align="center" valign="center"><div align="center">Ligne Credit Depense</div></td>
<% for(int i=0;i<listDatePrevDepense.length;i++){
%>
       <td align="right" valign="center"><div align="center"><%=Utilitaire.datetostring(listDatePrevDepense[i].getDaty())%></div></td><%
  }
%>
  </tr>
<%for(int k=0;k<listeDesignPrevDepense.length;k++){
  if(listeDesignPrevDepense[k] != null){
    previsionDepenseSum.setNomTable(etatPrevDepense);
    previsionDepenseSum.setDesignationlc(listeDesignPrevDepense[k].getDesignationlc());
   %>

  <tr>
    <td><%=listeDesignPrevDepense[k].getDesignationlc()%></td>
<%for(int j=0;j<listDatePrevDepense.length;j++){
    PrevDepenseSum[] listPrevDepSum = (PrevDepenseSum[])CGenUtil.rechercher(previsionDepenseSum,null,null," and daty='"+Utilitaire.datetostring(listDatePrevDepense[j].getDaty())+"'");

%>
<% if(listPrevDepSum!=null && listPrevDepSum.length>0 && listPrevDepSum[0].getMontant()!=0){%>
    <td align="center" style="background-color:WHITE"><a href="<%=pr.getLien()%>?but=prevision/fichePrevisionDepense.jsp&idligne=<%=listPrevDepSum[0].getIdligne()%>&daty=<%=Utilitaire.datetostring(listDatePrevDepense[j].getDaty())%>&montant=<%=listPrevDepSum[0].getMontant()%>" title="<%=listPrevDepSum[0].getIdentite()%>" class="prevision"><%=Utilitaire.formaterAr(listPrevDepSum[0].getMontant())%></a></td>
<% }else{%>
    <td align="center"><pre></pre></td>
<%  }
  }%>
  </tr>
<%
  }
}
%>
  <tr>
    <td class="left" align="center">Total:</td>
<%double summontant=0;
  int ij=0;
  for(ij=0;ij<listDatePrevDepense.length;ij++){
    summontant=0;
    previsionDepenseSum.setDesignationlc("%");
    unionListDates += Utilitaire.datetostring(listDatePrevDepense[ij].getDaty()) + "-";
    PrevDepenseSum[] lsum=(PrevDepenseSum[])CGenUtil.rechercher(previsionDepenseSum,null,null," and daty='"+Utilitaire.datetostring(listDatePrevDepense[ij].getDaty())+"'");
    if(lsum!=null && lsum.length>0 && lsum[0].getMontant()!=0){
      for(int sm=0;sm<lsum.length;sm++){
           summontant += lsum[sm].getMontant();
      }
    }%>
    <td align="center" class="left"><%=Utilitaire.formaterAr(summontant)%></td>
<%}
%>

  </tr>
</table>
</div>
<br/><br/>
<!--LISTE ETAT RECETTE-->
<p align="center"><strong><u>ETAT RECETTE</u></strong></p>
<div id="scroll2" style="overflow:scroll; height:250px;">
<table border="1" cellpadding="0" cellspacing="0" align="center" class="monographe" width="100%">
  <tr class="head" height="30">
     <td align="center" valign="center"><div align="center">Ligne Credit Recette</div></td>
<% for(int i=0;i<ldate.length;i++){%>
       <td align="right" valign="center"><div align="center"><%=Utilitaire.datetostring(ldate[i].getDaty())%></div></td><%}
%>
  </tr>
<%for(int k=0;k<ldesign.length;k++){
    prs.setNomTable("prevrecettesum");
    prs.setDesignationlc(ldesign[k].getDesignationlc());
   %>
  <tr>
    <td><%=ldesign[k].getDesignationlc()%></td>
<%for(int j=0;j<ldate.length;j++){
    PrevRecetteSum[] lsum=(PrevRecetteSum[])CGenUtil.rechercher(prs,null,null," and daty='"+Utilitaire.datetostring(ldate[j].getDaty())+"'");
%>
<% if(lsum!=null && lsum.length>0 && lsum[0].getMontant()!=0){%>
    <td align="center" style="background-color:WHITE"><a href="<%=pr.getLien()%>?but=prevision/fichePrevisionRecette.jsp&idligne=<%=lsum[0].getIdligne()%>&daty=<%=Utilitaire.datetostring(ldate[j].getDaty())%>&montant=<%=lsum[0].getMontant()%>" title="<%=lsum[0].getIdentite()%>" class="prevision"><%=Utilitaire.formaterAr(lsum[0].getMontant())%></a></td>
<% }else{%>
    <td align="center"><pre></pre></td>
<%  }
  }%>
  </tr>

<%}%>
<tr>
    <td class="left" align="center">Total:</td>
<%summontant=0;
  ij=0;
  PrevRecetteSum prevrec=new PrevRecetteSum();
  prevrec.setDesignationlc("%");
  for(ij=0;ij<ldate.length;ij++){
    summontant=0;
    unionListDates += Utilitaire.datetostring(ldate[ij].getDaty()) + "-";
    PrevRecetteSum[] lsum=(PrevRecetteSum[])CGenUtil.rechercher(prevrec,null,null," and daty='"+Utilitaire.datetostring(ldate[ij].getDaty())+"'");
    if(lsum.length>0){
        for(int sm=0;sm<lsum.length;sm++){
           summontant += lsum[sm].getMontant();
        }
    }%>
    <td align="center" class="left"><%=Utilitaire.formaterAr(summontant)%></td>
<%  }
%>
  </tr>
</table>
</div>
<br/><br/>
<!--SOLDE-->
<%
  // Listes des dépenses et recettes
  // Utiles pour les lignes des soldes
  // (soustraction des montants recette et dépense)
  double[] mntRecettes = null;
  double[] mntDepenses = null;
  String[] dates = Utilitaire.split(unionListDates, "-");
  Date[] listeDates = null;
  String listeDatesUnique = "";
  for(int m=0;m<dates.length;m++){
    if(listeDatesUnique.lastIndexOf(dates[m]) == -1){
      listeDatesUnique += dates[m] + "-";
    }
  }
  dates = Utilitaire.split(listeDatesUnique, "-");
  java.sql.Date listDatesSql[] = new java.sql.Date[dates.length];
  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
  for(int n=0;n<dates.length;n++){
    listDatesSql[n] = new java.sql.Date(sdf.parse(dates[n]).getTime());
  }
  Arrays.sort(listDatesSql);
  mntRecettes = new double[listDatesSql.length];
  mntDepenses = new double[listDatesSql.length];

%>

<p align="center"><strong><u>SOLDE</u></strong></p>
<div id="scroll2" style="overflow:scroll; height:100px;">
<table border="1" cellpadding="0" cellspacing="0" align="center" class="monographe" width="100%">
  <tr class="head" height="30">
      <td align="center" valign="center"><div align="center"></div></td>
  <%
       for(int i=0;i<listDatesSql.length;i++){%>
          <td align="right" valign="center"><div align="center"><%=Utilitaire.datetostring(listDatesSql[i])%></div></td><%
       }
  %>
  </tr>
  <tr>
<%
  PrevRecetteSum[] lsumRecette = new  PrevRecetteSum[listDatesSql.length];
  PrevRecetteSum prevR = new PrevRecetteSum();
  prevR.setDesignationlc("%");
%><td align="center" style="background-color:WHITE">Recette</td> <%
  for(int j=0;j<listDatesSql.length;j++){
     lsumRecette=(PrevRecetteSum[])CGenUtil.rechercher(prevR,null,null," and daty='"+Utilitaire.datetostring(listDatesSql[j])+"'");
     summontant = 0;
     if(lsumRecette.length>0){
      for(int sm=0;sm<lsumRecette.length;sm++){
         summontant += lsumRecette[sm].getMontant();
      }
    }
    mntRecettes[j] = summontant;
    %>
    <td align="center" style="background-color:WHITE"><%=Utilitaire.formaterAr(summontant)%></td>
  <%}%>
  </tr>
<tr>
<%
  PrevDepenseSum[] lsumDepense = new  PrevDepenseSum[listDatesSql.length];
  PrevDepenseSum prevD = new PrevDepenseSum();
  prevD.setDesignationlc("%");
%><td align="center" style="background-color:WHITE">Dépense</td> <%
  for(int j=0;j<listDatesSql.length;j++){
     lsumDepense=(PrevDepenseSum[])CGenUtil.rechercher(prevD,null,null," and daty='"+Utilitaire.datetostring(listDatesSql[j])+"'");
     summontant = 0;
      if(lsumDepense.length>0){
         for(int sm=0;sm<lsumDepense.length;sm++){
             summontant += lsumDepense[sm].getMontant();
         }
      }
      mntDepenses[j] = summontant;
  %>
  <td align="center" style="background-color:WHITE"><%=Utilitaire.formaterAr(summontant)%></td>
  <%}%>
  </tr>
  <tr>
      <td class="left" valign="center">Solde</td>
  <%
    for(int j=0;j<listDatesSql.length;j++){
      double solde = mntRecettes[j] - mntDepenses[j];
      %><td class="left" valign="center"><div align="center"><%=Utilitaire.formaterAr(solde)%></div></td><%
    }
   %>
  </tr>
</table>
</div>
