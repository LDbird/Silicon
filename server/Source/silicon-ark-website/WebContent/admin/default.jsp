<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="SC" tagdir="/WEB-INF/tags/admin/" %>
<%
String path = "dashboard";
String p_path = request.getParameter("path");
if (p_path != null)
{
    if (p_path.equals("post") || p_path.equals("category") || p_path.equals("user") || p_path.equals("system"))
    {
        path = p_path;
    }
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
<SC:CoolFrame/>

<script>
$path = "<%= path%>";
$import("pt.cms.admin.common.page.AdminPageController");
</script>
<script>
$pageController = new pt.cms.admin.common.page.AdminPageController();
</script>

<title>Silicon 方舟</title>
</head>

<body>
    
<div id="admin">
    <SC:Header/>
    
    <div id="navigationListView"></div>
    <div id="toolstrip"></div>
    <SC:UserStatus/>
    
    <div id="content"></div>
</div>
    
</body>

</html>