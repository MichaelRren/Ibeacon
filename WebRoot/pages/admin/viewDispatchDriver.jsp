<%--
  Created by IntelliJ IDEA.
  User: R
  Date: 2019/3/21
  Time: 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html"
         import="java.util.*,com.ictwsn.bean.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String path = request.getContextPath();
    //获取当前角色的权限信息
    RoleBean rb = null;
    if ((RoleBean) session.getAttribute("RoleBean") != null) {
        rb = (RoleBean) session.getAttribute("RoleBean");
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/showBo.css"/>
    <link rel="stylesheet" type="text/css" href="css/pintuer.css">
    <link rel="stylesheet" type="text/css" href="css/admin.css">

</head>
<body>

<div class="panel admin-panel">
    <div class="panel-head">
        <strong class="icon-reorder"> 分配司机</strong> <a href=""
                                                              style="float:right; display:none;">添加字段</a>
    </div>
    <div class="padding border-bottom">
        <form method="get" action="searchDispatchByCondition.do"
              id="searchDispatchByConditionForm" name="searchDispatchByConditionForm">
            <ul class="search" style="padding-left:10px;">
                <li>
                        <a class="button border-main icon-plus-square-o" href="#"> 分配信息查询</a>
                </li>
                <li>
                        <select name="selectSearchType" class="input"
                                id="selectSearchType" style="width:200px; line-height:17px;"
                                onchange="setSearchType();">
                            <option value="userName">宾客姓名</option>
                        </select>
                </li>

                <li><input type="text" placeholder="请输入搜索关键字" name="keyword" id="keyword" class="input" style="width:250px; line-height:17px;display:inline-block" />
                    <input type="hidden" value="userName" name="type" id="type"/>
                    <input type="hidden" value="1" name="page" id="page"/>
                    <a href="javascript:searchDispatchByCondition();"
                        class="button border-main icon-search">搜索
                    </a>
                </li>

                <li style="padding-right:10px;float:right;"><span class="r" style="float:right;">共有数据：<strong>${totalCount}</strong>条</span></li>
            </ul>
        </form>
    </div>

    <table class="table table-hover text-center">
        <tr>
            <th width="160px">姓名</th>
            <th width="100px">抵达日期</th>
            <th width="120px">抵达时间</th>
            <th width="80px">航班/车次</th>
            <th width="200px">接站地址</th>
            <th width="150px">联系方式</th>
            <th width="140px">酒店名称</th>
            <th width="80px">司机姓名</th>
            <th width="180px">司机联系方式</th>
            <th width="120px">车牌号</th>
            <th width="120px">备注</th>
            <th width="124px">操作</th>
        </tr>
        <c:forEach var="list" items="${ddllist}">
            <tr id="device_tr_${list.userNumber}">
                <td width="160px" title="${list.userName}">${list.userName}</td>
                <td width="100px">${list.arrivalDate}</td>
                <td width="120px">${list.arrivalTime}</td>
                <td width="80px">${list.arrivalNumber}</td>
                <td width="200px" title="${list.arrivalStation}">${list.arrivalStation}</td>
                <td width="150px" title="${list.userNumber}">${list.userNumber}</td>
                <td width="140px">${list.hname}</td>
                <td width="80px">${list.dname}</td>
                <td width="180px" title="${list.dnumber}">${list.dnumber}</td>
                <td width="120px">${list.dplate}</td>
                <td width="120px">${list.remark}</td>
                <td width="124px">
                    <c:if test="${list.dnumber == null}">
                        <input type="button" id="editButton" onclick="javascript:window.location.href='beforeInsertDriver.do?userNumber=${list.userNumber}'" value="分配司机">&nbsp;
                    </c:if>
                    <c:if test="${list.dnumber != null}">
                        <input type="button" id="deleteButton" onclick="javascript:window.location.href='beforeDispatchDriver.do?userNumber=${list.userNumber}'" value="更换司机">
                    </c:if>

                </td>
            </tr>
        </c:forEach>

        <tr>
            <td colspan="20"><div class="pagelist">
                <c:choose>
                    <c:when test="${page==1}">
                        <a>上一页</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${prePageHref}">上一页</a>
                    </c:otherwise>
                </c:choose>
                &nbsp;&nbsp;${page}/${maxPage}&nbsp;&nbsp;
                <c:choose>
                    <c:when test="${page==maxPage}">
                        <a>下一页</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${nextPageHref}">下一页</a>
                    </c:otherwise>
                </c:choose>

            </div></td>
        </tr>
    </table>
</div>

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/pintuer.js"></script>
<script type="text/javascript" src="js/showBo.js"></script>

<script type="text/javascript">
    function setSearchType() {
        var types = document.getElementById("selectSearchType");
        for ( var i = 0; i < types.length; i++) {
            if (types[i].selected == true) {
                document.getElementById("type").value = types[i].value;
                break;
            }
        }
    }
    function searchDispatchByCondition(){
        if(document.getElementById("type").value==''){
            Showbo.Msg.alert("请选择查询项!",function (){
                document.getElementById("selectSearchType").focus();
            });
            return 0;
        }
        if(document.getElementById("keyword").value==''){
            alert("请输入查询参数!");

            document.getElementById("keyword").focus();

            return 0;
        }
        document.searchDispatchByConditionForm.submit();
    }
</script>

</body>
</html>


