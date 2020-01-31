<!DOCTYPE html>
<html>
<head>
<title>Account Page</title>
</head>
<body>

	<%@ include file="auth.jsp"%>
	<%@ page import="java.text.NumberFormat"%>
	<%@ include file="jdbc.jsp"%>

	<%
		String userName = (String) session.getAttribute("authenticatedUser");
	%>

	<%
		// Print Customer information
		String sql = "select customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password FROM Customer WHERE userid = ?";

		NumberFormat currFormat = NumberFormat.getCurrencyInstance();

		try {
			out.println("<h3>Customer Profile</h3>");

			getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userName);
			ResultSet rst = pstmt.executeQuery();
			rst.next();
	%>
	<h4>Must enter password for changes to take effect. No need to change password.</h4>
	<form action="updatecustomer.jsp">
		<table class="table" border="1">
			<tr>
				<th>Id</th>
				<td><%=rst.getString(1)%></td>
			</tr>
			<tr>
				<th>First Name</th>
				<td><input type="text" name="firstname" value=<%=rst.getString(2)%>></td>
			</tr>
			<tr>
				<th>Last Name</th>
				<td><input type="text" name="lastname" value=<%=rst.getString(3)%>></td>
			</tr>
			<tr>
				<th>Email</th>
				<td><input type="text" name="email" value=<%=rst.getString(4)%>></td>
			</tr>
			<tr>
				<th>Phone</th>
				<td><input type="text" name="phone" value=<%=rst.getString(5)%>></td>
			</tr>
			<tr>
				<th>Address</th>
				<td><input type="text" name="address" value=<%=rst.getString(6)%>></td>
			</tr>
			<tr>
				<th>City</th>
				<td><input type="text" name="city" value=<%=rst.getString(7)%>></td>
			</tr>
			<tr>
				<th>State</th>
				<td><input type="text" name="state" value=<%=rst.getString(8)%>></td>
			</tr>
			<tr>
				<th>Postal Code</th>
				<td><input type="text" name="postcode" value=<%=rst.getString(9)%>></td>
			</tr>
			<tr>
				<th>Country</th>
				<td><input type="text" name="country" value=<%=rst.getString(10)%>></td>
			</tr>
			<tr>
				<th>User id</th>
				<td><%=rst.getString(11)%></td>
			</tr>
			<tr>
				<th>Password</th>
				<td><input type="text" name="oldpass"></td>
			</tr>
			<tr>
				<th>New Password</th>
				<td><input type="text" name="password"></td>
			</tr>
		</table>
		<input type="submit" value="Submit">
	</form>
	<%
		} catch (SQLException ex) {
			out.println(ex);
		} finally {
			closeConnection();
		}
	%>
</body>
</html>

