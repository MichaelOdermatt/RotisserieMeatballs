<%@ include file="jdbc.jsp"%>
<%
	int id = request.getParameter("id");
	out.println("<h2>Inventory for warehouse: "+id+"</h2>");
	try {
		getConnection();
		String sql = "SELECT productId, quantity, price FROM productinventory WHERE warehouseId=?";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, id);
		ResultSet rst = pst.executeQuery();
		out.println("<table><tr><th>Id</th><th>Quantity</th><th>Price</th></tr>");
		while(rst.next()) {
			out.println("<tr><td><a href=\"product.jsp?id=\""+rst.getInt(1)+"\">"+rst.getInt(1)+"</a></td>");
			out.println("<td>"+rst.getInt(2)+"</td><td>"+rst.getDouble(3)+"</td></tr>");
		}
		out.println("</table>");
	} catch (SQLException ex) {
		out.print(ex);
	} finally {
		closeConnection();
	}
%>