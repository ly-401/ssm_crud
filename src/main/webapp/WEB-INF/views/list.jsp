<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Future
  Date: 2021/11/30
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>Title</title>

<%
    pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<%--
  web路径：
        不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
        以/开始的相对路径，找资源，以服务器的路径为标准
        (http://localhost:8080/ssm_crud)，需要加上项目名称

  --%>

    <%--  引入jquery  --%>
    <script type="text/javascript" src="${APP_PATH}/static/jquery/jquery-1.7.2.js"></script>
    <%--  引入样式  --%>
    <link rel="stylesheet" href="${APP_PATH}/static/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/js/bootstrap.min.js"></script>
</head>
<body>
    <%--    搭建显示页面    --%>
    <div class="container">
        <%--    标题    --%>
        <div class="row">
            <div class="col-md-12">
                <h1>SSM-CRUD</h1>
            </div>
        </div>
        <%--    按钮    --%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button type="button" class="btn btn-primary">新增</button>
                <button type="button" class="btn btn-danger">删除</button>
            </div>
        </div>
        <%--    显示表格数据    --%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                    <%--  遍历查询的所有员工信息，这里相对于是将数据重复了五遍显示在页面，只不过是用了遍历的方式  --%>
                    <%--         注意：list是pageInfo对象存储的结果集，也就是一个list，然后一个一个取出来           --%>
                    <c:forEach items="${requestScope.pageInfo.list}" var="emp">
                        <tr>
                            <th>${emp.empId}</th>
                            <th>${emp.empName}</th>
                            <th>${emp.gender == "M" ? "男" : "女"}</th>
                            <th>${emp.email}</th>
                            <th>${emp.department.deptName}</th>
                            <th>
                                <button type="button" class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                    编辑
                                </button>
                                <button type="button" class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                    删除
                                </button>
                            </th>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <%--    显示分页信息    --%>
        <div class="row">
            <%--      分页文字信息      --%>
            <div class="col-md-6">
                当前${requestScope.pageInfo.pageNum}页,
                总${requestScope.pageInfo.pages}页,
                总${requestScope.pageInfo.total}条记录
            </div>
            <%--       分页条信息         --%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <%--   是第一页就不可点击   --%>
                        <c:if test="${requestScope.pageInfo.pageNum == 1}">
                        <li class="disabled"><a href="emps">首页</a></li>
                        </c:if>
                        <c:if test="${requestScope.pageInfo.pageNum != 1}">
                            <li><a href="emps">首页</a></li>
                        </c:if>
                        <%-- 只有当前页大于1时才可以点击 --%>
                        <c:if test="${requestScope.pageInfo.pageNum > 1}">
                            <li>
                                <a href="emps?pn=${requestScope.pageInfo.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${requestScope.pageInfo.pageNum <= 1}">
                                <li class="disabled">
                                    <a href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                        </c:if>

                        <%-- 分页显示 --%>
                        <c:forEach items="${requestScope.pageInfo.navigatepageNums}" var="page_Num">
                            <%--  是当前页就加高亮  --%>
                            <c:if test="${page_Num == pageInfo.pageNum}">
                                <li class="active"><a href="emps?pn=${page_Num}">${page_Num}</a></li>
                            </c:if>
                            <%--  非当前页正常显示  --%>
                            <c:if test="${page_Num != pageInfo.pageNum}">
                                <li><a href="emps?pn=${page_Num}">${page_Num}</a></li>
                            </c:if>

                        </c:forEach>

                        <%-- 如果当前页是最后页，则不可点击 --%>
                        <c:if test="${requestScope.pageInfo.pageNum == pageInfo.pages}">
                            <li class="disabled">
                                <a href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li class="disabled"><a href="emps?pn=${pageInfo.pages}">末页</a></li>
                        </c:if>
                        <%-- 如果当前页不是最后页，可点击 --%>
                        <c:if test="${requestScope.pageInfo.pageNum != pageInfo.pages}">
                            <li>
                                <a href="emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li><a href="emps?pn=${pageInfo.pages}">末页</a></li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>

    </div>



</body>
</html>
