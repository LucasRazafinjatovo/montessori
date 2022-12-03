package lc;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import bean.GenUtil;

public class LigneCreditUtil extends GenUtil {

	public LigneCreditUtil() {
		super("LIGNECREDIT","lc.LigneCredit");
	}

/*	public Object[] resultatGen(ResultSet rs) {
		try {
			int i = 0;
			LigneCredit temp = null;
			Vector vect = new Vector();
			while (rs.next()) {
				temp = new LigneCredit(rs.getString(1), rs.getString(2), rs
						.getDouble(3), rs.getDouble(4), rs.getDouble(5), rs
						.getDouble(6), rs.getDouble(7), rs.getString(8), rs
						.getString(9), rs.getString(10), rs.getString(11), rs
						.getString(12), rs.getInt(13), rs.getString(14));
				vect.add(i, temp);
				i++;
			}

			LigneCredit[] retour = new LigneCredit[i];
			vect.copyInto(retour);
			return retour;

		} catch (Exception s) {
			System.out.println("Recherche LigneCredit " + s.getMessage());
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (SQLException e) {
				System.out.println("Erreur Fermeture SQL LigneCredit "
						+ e.getMessage());
			}
		}
	}
*/
	public Object[] resultatLimit(int numBloc, ResultSet rs) {
		throw new java.lang.UnsupportedOperationException(
				"Method resultatLimit() not yet implemented.");
	}

}
