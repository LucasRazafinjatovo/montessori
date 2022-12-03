package affichage;

import bean.ClassMAPTable;
import javax.servlet.http.HttpServletRequest;
import bean.CGenUtil;
import java.lang.reflect.Field;

/**
 * <p>Title: Gestion des recettes </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2005</p>
 * <p>Company: </p>
 * @author unascribed
 * @version 1.0
 */

public class PageConsulte extends Page {

  private Champ[] listeChamp;
  private bean.ClassMAPTable critere;
  private String[] libAffichage;
  private String cssTableau="monographe";
  public PageConsulte() {
  }
  public PageConsulte(ClassMAPTable o,HttpServletRequest req,user.UserEJB u)throws Exception {
    setCritere(o);
    setReq(req);
    makeCritere();
    setUtilisateur(u);
    getData();
    makeChamp();
  }

  public void getData() throws Exception
  {
    ClassMAPTable[] result=(ClassMAPTable[])getUtilisateur().getData(getCritere(),null,null,null,"");
    if(result==null||result.length==0) throw new Exception("Pas de resultat pour votre consultation");
    setBase(result[0]);
  }
  public void makeChamp() throws Exception
  {
    Champ[] t=null;
    t=new Champ[getBase().getNombreChamp()];
    Field[]f=getBase().getFieldList();
    for(int i=0;i<t.length;i++)
    {
      t[i]=new Champ(f[i].getName());
      t[i].setLibelle(f[i].getName());
      t[i].setValeur(String.valueOf(CGenUtil.getValeurFieldByMethod(getBase(),f[i].getName())));
    }
    setListeChamp(t);
  }
  public void makeCritere() throws Exception
  {
    String valeur=getReq().getParameter(getCritere().getAttributIDName());
    Field f=CGenUtil.getField(getCritere(),getCritere().getAttributIDName());
    CGenUtil.setValChamp(getCritere(),f,valeur);
  }
  public Champ[] getListeChamp() {
    return listeChamp;
  }
  public void setListeChamp(Champ[] listeChamp) {
    this.listeChamp = listeChamp;
  }
  public void makeHtml()
  {
    String temp="";
    temp+="<table width=60% class="+getCssTableau()+">";
    for(int i=0;i<getListeChamp().length;i++)
    {
      temp+="<tr>";
      temp+="<td align=rigth width=30% class="+getListeChamp()[i].getCssLibelle()+">"+getListeChamp()[i].getLibelle()+"</td>";
      temp+="<td align=center width=70%>"+getListeChamp()[i].getValeur()+"</td>";
      temp+="</tr>";
    }
    temp+="</table>";
    setHtml(temp);
  }
  public void setCritere(bean.ClassMAPTable critere) {
    this.critere = critere;
  }
  public bean.ClassMAPTable getCritere() {
    return critere;
  }
  public void setLibAffichage(String[] libAffichag) throws Exception{
    if(libAffichag.length!=getListeChamp().length)throw new Exception("Nombre de champ non valide dans les lib spécifiques");
    this.libAffichage = libAffichag;
    for(int i=0;i<getListeChamp().length;i++)
    {
      Champ c=getListeChamp()[i];
      c.setLibelle(libAffichag[i]);
    }
  }
  public String[] getLibAffichage() {
    return libAffichage;
  }
  public void setCssTableau(String cssTableau) {
    this.cssTableau = cssTableau;
  }
  public String getCssTableau() {
    return cssTableau;
  }
}