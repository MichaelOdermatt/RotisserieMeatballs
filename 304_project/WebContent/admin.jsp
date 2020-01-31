<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

	<%@ include file="../auth.jsp"%>
	<%@ page import="java.text.NumberFormat"%>
	<%@ include file="jdbc.jsp"%>

	<%
		String userName = (String) session.getAttribute("authenticatedUser");
	%>

	<%
		// Print out total order amount by day

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		try {
			String sql = "select year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";
			out.println("<h3>Administrator Sales Report by Day</h3>");
			getConnection();
			ResultSet rst = con.createStatement().executeQuery(sql);
			out.println("<table class=\"table\" border=\"1\">");
			out.println("<tr><th>Order Date</th><th>Total Order Amount</th>");

			while (rst.next()) {
				out.println("<tr><td>" + rst.getString(1) + "-" + rst.getString(2) + "-" + rst.getString(3)
						+ "</td><td>" + currFormat.format(rst.getDouble(4)) + "</td></tr>");
			}
			out.println("</table>");
		} catch (SQLException ex) {
			out.println(ex);
		} finally {
			closeConnection();
		}

		//list all customers
		try {
			String sql = "SELECT customerId, firstName, lastName, userid FROM customer";
			out.println("<h3>Customers</h3>");
			getConnection();
			ResultSet rst = con.createStatement().executeQuery(sql);
			out.println("<table class=\"table\" border=\"1\">");
			out.println("<tr><th>Name</th><th>Id</th>");
			while (rst.next()) {
				out.println("<tr><td><a href=\"customer.jsp?id=" + rst.getString(4) + "\">" + rst.getString(2) + " "
						+ rst.getString(3) + "</a></td><td>" + rst.getInt(1) + "</td></tr>");
			}
			out.print("</table>");
		} catch (SQLException ex) {
			out.println(ex);
		} finally {
			closeConnection();
		}
	%>
	<h3>Add a product</h3>
	<form action="addproduct.jsp">
		<table>
			<tr>
				<th>Name</th>
				<th>Price</th>
				<th>Description</th>
				<th>Category Id</th>
			</tr>
			<tr>
				<td><input type="text" name="name"></td>
				<td><input type="text" name="price"></td>
				<td><input type="text" name="desc"></td>
				<td><input type="text" name="catid"></td>
				<td><input type="submit" name="submit" value="Submit"></td>
			</tr>
		</table>
	</form>
	<h3>Warehouses</h3>
	<%
	try {
		getConnection();
		String sql = "SELECT warehouseId, warehouseName FROM warehouse";
		ResultSet rst = con.createStatement().executeQuery(sql);
		out.println("<table border=\"1\"><tr><th>Name</th><th>Id</th></tr>");
		while (rst.next()) {
			out.println("<tr><td><a href=\"warehouseinventory.jsp?id="+rst.getInt(1)+"\">"+rst.getString(2)+"</a></td><td>"+rst.getInt(1)+"</td></tr>");	
		}
		out.println("</table>");
	} catch (SQLException ex) {
		out.print(ex);
	} finally {
		closeConnection();
	}
	%>
</body>
</html>

