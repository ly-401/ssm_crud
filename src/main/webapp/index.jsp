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
    <script type="text/javascript" src="${APP_PATH}/static/jquery/jquery-1.12.4.min.js"></script>
    <%--  引入样式  --%>
    <link rel="stylesheet" href="${APP_PATH}/static/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/js/bootstrap.min.js"></script>
</head>
<body>

<%-- 员工修改的模态框 --%>
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <%--        表单        --%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">
                                <%--  部门是由数据库查询出来的，部门提交部门id即可  --%>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <%--        表单        --%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<%-- 员工修改的模态框 --%>


<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <%--        表单        --%>
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">
                            <%--  部门是由数据库查询出来的，部门提交部门id即可  --%>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <%--        表单        --%>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工添加的模态框 -->

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
            <button type="button" class="btn btn-primary" id="emp_add_model_btn">新增</button>
            <button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <%--    显示表格数据    --%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%--    显示分页信息    --%>
    <div class="row">
        <%--      分页文字信息      --%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--       分页条信息         --%>
        <div class="col-md-6" id="page_nav_area">

        </div>

</div>

    <%--  页面加载完成之后，直接去发送一个ajax请求，获取到分页数据  --%>
    <script type="text/javascript">

        var totalRecord,currentPage;

        $(function () {
            //第一次请求是第一页
            to_page(1);
        });

        //查询分页
        function to_page(pn) {
            $.ajax({
                url:"emps",
                data:"pn="+pn,
                type:"GET",
                    success:function (event) {
                        //1.解析(json)并显示员工数据
                    build_emps_table(event);
                    //2.解析显示分页信息
                    build_page_info(event);
                    //3.//解析显示分页条数据
                    build_page_nav(event);

                }
            });
        }

        //解析显示员工数据
        function build_emps_table(event) {
            //在构建之前先清空表格
            $("#emps_table tbody").empty();//清空元素

            var emps = event.extend.pageInfo.list;
            //$.each是Jquery提供的遍历函数
            $.each(emps,function (index,item) {//index是索引，item是当前对象
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'></td>");
                var empIdTd = $("<td></td>").append(item.empId);
                var empNameTd = $("<td></td>").append(item.empName);
                var genderTd = $("<td></td>").append(item.gender == "M"?"男":"女");
                var emailTd = $("<td></td>").append(item.email);
                var deptNameTd = $("<td></td>").append(item.department.deptName);
                //编辑按钮
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                //为编辑按钮添加一个自定义的属性，来表示当前员工的id
                editBtn.attr("edit-id",item.empId);

                //删除按钮
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加一个自定义的属性来表示当前删除的员工id
                delBtn.attr("delete-id",item.empId);

                //将两个按钮追加到一个单元格中
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

                //append方法执行完成之后，还是返回原来的元素
                $("<tr></tr>").append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            });

        }

        //解析显示分页信息
        function build_page_info(event) {
            //在构建之前先清空元素信息
            $("#page_info_area").empty();//清空元素

            $("#page_info_area").append("当前"+ event.extend.pageInfo.pageNum
            +"页, 总"+ event.extend.pageInfo.pages +"页, 总"+
            event.extend.pageInfo.total +"条记录");
            totalRecord = event.extend.pageInfo.total;
            currentPage = event.extend.pageInfo.pageNum;
        }

        //解析显示分页条，点击分页要能正确跳转
        function build_page_nav(event) {
            //在构建之前先清空元素信息
            $("#page_nav_area").empty();//清空元素

            //$("#page_nav_area")

            var ul = $("<ul></ul>").addClass("pagination");

            //构建元素
            //首页li
            var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
            //前页li
            var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
            //如果没有前一页就不可点击
            if(event.extend.pageInfo.hasPreviousPage == false){
                firstPageLi.addClass("disabled");
                prePageLi.addClass("disabled");
            }else {
                //没被禁用才绑定单击事件
                //为元素添加点击翻页的事件
                firstPageLi.click(function () {
                    to_page(1);
                });
                prePageLi.click(function () {
                    to_page(event.extend.pageInfo.pageNum-1);
                });
            }

            //构建元素
            //后页li
            var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
            //末页li
            var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
            //如果没有下一页就不可点击
            if(event.extend.pageInfo.hasNextPage == false){
                nextPageLi.addClass("disabled");
                lastPageLi.addClass("disabled");
            }else {
                //为元素添加点击翻页的事件
                nextPageLi.click(function () {
                    to_page(event.extend.pageInfo.pageNum+1);
                });
                lastPageLi.click(function () {
                    to_page(event.extend.pageInfo.pages);
                });
            }

            //添加首页和前一页
            ul.append(firstPageLi).append(prePageLi);

            $.each(event.extend.pageInfo.navigatepageNums,function(index,item){

                var numLi = $("<li></li>").append($("<a></a>").append(item));
                if(event.extend.pageInfo.pageNum == item){
                    numLi.addClass("active");
                }
                //给分页条设置单机事件
                numLi.click(function () {
                    to_page(item);
                });

                //将1-5页，顺序的5页添加
                ul.append(numLi);
            });
            //添加后一页和末页
            ul.append(nextPageLi).append(lastPageLi);
            //将ul添加到nav中
            var navEle = $("<nav></nav>").append(ul);

            navEle.appendTo("#page_nav_area");
        }

        //清空表单样式及内容
        function reset_form(element){
            //清空表单内容
            $(element)[0].reset();
            //清空表单样式
            $(element).find("*").removeClass("has error has success");
            $(element).find(".help-block").text("");
        }


        //点击新增按钮弹出模态框
        $("#emp_add_model_btn").click(function () {

            //弹出模态框之前清除表单数据(表单完整重置)(表单的数据，表单的样式)
            reset_form("#empAddModel form");

            //模态框弹出之前，发送ajax请求，查出部门信息，显示在下拉列表中
            getDepts("#empAddModel select");

            //手动打开模态框
            $("#empAddModel").modal({
                backdrop:"static"
            });
        });

        //查出所有的部门信息并显示在下拉列表中
        function getDepts(element) {
            //遍历之前先清空上一次的缓存
            $(element).empty();

            $.ajax({
               url:"depts",
                type: "GET",
                success:function (event) {

                    //console.log(event);
//depts: Array(2)：{0: {deptId: 1, deptName: "开发部"}1: {deptId: 2, deptName: "测试部"}}
                    //显示部门信息在下拉列表中
                    //$("#empAddModel select").append("")
                    $.each(event.extend.depts,function () {
                        //this就是每一项，遍历的是depts，因为是list
                        var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
                        optionEle.appendTo(element);
                    });

                }
            });
        }

        //校验表单数据
        function validate_add_form(){
            //1.拿到要校验的数据，使用正则表达式进行校验
            //校验用户名
            var empName = $("#empName_add_input").val();
            var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
            if(!regName.test(empName)){
                //alert("用户名只能在2-5位中文或者6-16位英文和数字的组合！");
                //弹窗不友好，使用添加class来提示信息
                show_validate_msg("#empName_add_input","error","用户名只能在2-5位中文或者6-16位英文和数字的组合！");

                return false;
            }else {
                //校验成功的提示
                show_validate_msg("#empName_add_input","success","");
            }


            //校验邮箱
            var email = $("#email_add_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                //alert("邮箱格式不正确！");
                show_validate_msg("#email_add_input","error","邮箱格式不正确！");

                return false;
            }else {
                //校验成功的提示
                show_validate_msg("#email_add_input","success","");
            }

            return true;
        }

        function show_validate_msg(element,status,msg){
            //清除当前元素的校验状态
            $(element).parent().removeClass("has-success has-error");
            $(element).next("span").text("");

            if("success" == status){
                $(element).parent().addClass("has-success");
                $(element).next("span").text(msg);
            }else if("error" == status){
                $(element).parent().addClass("has-error");
                $(element).next("span").text(msg);
            }
        }

        //在保存员工之前发送ajax请求查看用户名是否重复，重复就提示，并无法提交
        $("#empName_add_input").change(function () {
            //发送ajax请求校验用户名是否可用
            var empName = this.value;
            $.ajax({
               url:"checkName",
               data:"empName="+empName,
               type:"POST",
               success:function (event) {
                   // console.log(event);
                    if(event.status == 200){
                        show_validate_msg("#empName_add_input","success","用户名可用");
                        $("#emp_save_btn").attr("ajax-va","success");
                    }else{
                        show_validate_msg("#empName_add_input","error",event.extend.va_msg);
                        $("#emp_save_btn").attr("ajax-va","error");
                    }
               }
            });
        });


        //给保存按钮绑定单击事件,保存员工
        $("#emp_save_btn").click(function () {
            //先对要提交给服务器的数据进行校验
            if(!validate_add_form()){
                //校验失败，直接停止往下执行
                return false;
            }

            //判断之前的ajax用户名校验是否成功，成功才继续走
            if($(this).attr("ajax-va") == "error"){
                return false;
            }

            //1.模态框中填写的表单数据提交给服务器进行保存
            //2.发送ajax请求保存员工信息
            $.ajax({
                url:"emp",
                type:"POST",
                data: $("#empAddModel form").serialize(),
                success:function (event) {
                    //alert(event.msg);
                    if(event.status == 200) {//校验成功才关闭模态框
                        //保存成功后
                        //1.关闭模态框
                        $("#empAddModel").modal('hide');
                        //2.来到最后一页，显示刚才保存的数据
                        //发送ajax请求显示最后一页数据即可
                        to_page(totalRecord);//因为PageHelper插件配置过，访问超过最大页数，就访问最后一页
                    }else {
                        //用户校验失败
                        //显示失败信息
                        //console.log(event);
                        //有哪个字段的错误信息就显示哪个字段的
                        //如果是undefined表示没有报错，只有有值才是报错
                        if(undefined != event.extend.errorFields.email){
                            //显示邮箱错误信息
                            show_validate_msg("#email_add_input","error"
                                ,event.extend.errorFields.email);
                        }
                        if(undefined != event.extend.errorFields.empName){
                            //显示用户名错误信息
                            show_validate_msg("#empName_add_input","error"
                                ,event.extend.errorFields.empName);
                        }

                    }
                }
            });
        });

        //因为页面的数据是通过ajax请求获取的，在记载jsp页面时，会先加载完所有的js代码，才会继续执行
        //ajax请求，所以是绑定不到的
        /**
         * 我们是按钮创建之前就绑定了click，所以是绑定不上的
         *
         * 解决方法：
         *  1.可以在创建按钮的时候，绑定事件
         *  2.绑定单击  live()，但是Jquery新版没有Live(删除了)，使用on方法进行替代
         *
         */
        $(document).on("click",".edit_btn",function () {
            //alert("edit");

            //1.查出部门信息，并显示部门列表
            getDepts("#empUpdateModel select");
            //2.查出员工信息，显示员工信息
            getEmp($(this).attr("edit-id"));
            //3.把员工的id传递给模态框的更新按钮
            $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));

            $("#empUpdateModel").modal({
                backdrop: "static"
            });

        });

        function getEmp(id) {
            $.ajax({
               url : "emp/"+id,
               type : "GET",
               success : function (event) {
                    //console.log(event);
                   var empDate = event.extend.emp;
                   $("#empName_update_static").text(empDate.empName);
                   $("#email_update_input").val(empDate.email);
                   $("#empUpdateModel input[name=gender]").val([empDate.gender]);
                   $("#empUpdateModel select").val([empDate.dId]);
               }
            });
        }

        //给更新按钮绑定单击事件
        $("#emp_update_btn").click(function () {

            //1.验证邮箱是否合法
            var email = $("#email_update_input").val();
            var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
            if(!regEmail.test(email)){
                show_validate_msg("#email_update_input","error","邮箱格式不正确！");
                return false;
            }else {
                show_validate_msg("#email_update_input","success","");
            }
            //2.发送ajax请求保存更新的员工数据
            /**
             * 注意：使用了web.xml中的HiddenHttpMethodFilter过滤器将POST转换为PUT或者DELETE请求
             * 但是有一个要求，要在请求参数中加上一组参数    _method=PUT或者DELETE
             *
             */
            $.ajax({
                url : "emp/"+$(this).attr("edit-id"),
                type : "PUT",
                //$("#empUpdateModel form").serialize()将修改数据的模态框的表单数据作为键值对name=value&...
                data: $("#empUpdateModel form").serialize(),
                success : function (event) {
                    //alert(event.msg);
                    //1.关闭模态框
                    $("#empUpdateModel").modal("hide");
                    //2.回到当前页面
                    to_page(currentPage);
                }
            });
        });

        //给单个删除按钮绑定单击事件
        $(document).on("click",".delete_btn",function () {
            //1.弹出是否确认删除对话框
            //var empId = $(this).parents("tr").find("td:eq(0)").text();
            var empId = $(this).attr("delete-id");
            var empName = $(this).parents("tr").find("td:eq(2)").text();
            if(confirm("确认删除["+ empName +"]吗？")){
                //确认，发送ajax请求删除指定员工
                $.ajax({
                    url : "emp/"+empId,
                    type : "DELETE",
                    success : function (event) {
                        alert(event.msg);
                        //回到当前页码
                        to_page(currentPage);
                    }
                });

            }
        });

        //给全选删除按钮绑定单击事件，完成全选，全不选功能
        $("#check_all").click(function () {
            //attr获取checked是undefined
            //我们这些dom原生的属性：使用prop方法来获取,attr获取自定义属性的值
            //应该使用prop
            //alert($(this).prop("checked"));
            //如果是被选中状态，则全选
            $(".check_item").prop("checked",$(this).prop("checked"));
        });

        //给每一个选中按钮绑定单击事件
        $(document).on("click",".check_item",function () {
            //判断当前选中的元素是不是当前所有的check_item
            //被选中的复选框是否等于当前所有复选框的数量，相等就添加属性
            var flag = $(".check_item:checked").length == $(".check_item").length;
            $("#check_all").prop("checked",flag);

        });

        //给主页的删除按钮绑定单击事件(批量删除)
        $("#emp_delete_all_btn").click(function () {
            //当前被选中的复选框
            //遍历每一个被选中的复选框
            var empNames = "";
            var empId = "";

            $.each($(".check_item:checked"),function () {
                //获取到要删除的员工的姓名
                empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
                //组装员工id的字符串
                empId += $(this).parents("tr").find("td:eq(1)").text()+"-";
            });

            //去除empNames多余的逗号
            empNames = empNames.substring(0,empNames.length-1);
            //去除empId多余的-
            empId = empId.substring(0,empId.length-1);

            if(confirm("确认删除["+ empNames +"]吗？")){
                //发送ajax请求删除

                $.ajax({
                    url : "emp/"+empId,
                    type : "DELETE",
                    success : function (event) {
                        alert(event.msg);
                        //回到当前页面
                        to_page(currentPage);
                    }
                });

            }

        });


    </script>

</body>
</html>
