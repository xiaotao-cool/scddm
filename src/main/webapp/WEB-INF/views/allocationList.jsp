<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>设备调配申请管理</title>
    
    <!-- Bootstrap 4.6.2 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 20px 0;
            font-family: 'Microsoft YaHei', sans-serif;
        }
        
        .container {
            max-width: 1400px;
        }
        
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .card-header {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
            color: white;
            padding: 20px 25px;
            border: none;
            font-size: 20px;
            font-weight: 600;
        }
        
        .card-body {
            padding: 25px;
            background: white;
        }
        
        .table {
            margin-bottom: 0;
        }
        
        .table thead th {
            background: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
            font-weight: 600;
            color: #495057;
            padding: 15px;
        }
        
        .table tbody td {
            padding: 15px;
            vertical-align: middle;
        }
        
        .table tbody tr:hover {
            background-color: #f8f9fa;
            transition: background-color 0.2s;
        }
        
        .badge {
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: 500;
        }
        
        .btn {
            border-radius: 8px;
            padding: 8px 20px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .btn-sm {
            padding: 6px 15px;
            font-size: 14px;
        }
        
        .back-btn {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
            border-radius: 50px;
            padding: 12px 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
    </style>
</head>
<body>

<!-- 返回按钮 -->
<a href="${pageContext.request.contextPath}/index" class="btn btn-secondary back-btn">
    <i class="bi bi-arrow-left"></i> 返回首页
</a>

<div class="container">
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <span><i class="bi bi-arrow-left-right"></i> 设备调配申请列表</span>
            <a href="${pageContext.request.contextPath}/allocation/applyPage" class="btn btn-light btn-sm">
                <i class="bi bi-plus-circle"></i> 新增调配申请
            </a>
        </div>

        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover text-center">
                    <thead class="thead-light">
                    <tr>
                        <th>申请编号</th>
                        <th>设备ID</th>
                        <th>调出部门</th>
                        <th>调入部门</th>
                        <th>申请原因</th>
                        <th>申请时间</th>
                        <th>状态</th>
                        <th style="width: 200px;">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:choose>
                        <c:when test="${empty list}">
                            <tr>
                                <td colspan="8" class="text-muted py-4">
                                    <i class="bi bi-inbox"></i> 暂无调配申请记录
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${list}" var="a">
                                <tr>
                                    <td>${a.id}</td>
                                    <td>${a.deviceId}</td>
                                    <td>${a.fromDept}</td>
                                    <td>${a.toDept}</td>
                                    <td class="text-left">${a.reason}</td>
                                    <td>${a.applyTime}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${a.status == '待审批'}">
                                                <span class="badge badge-warning">待审批</span>
                                            </c:when>
                                            <c:when test="${a.status == '已通过'}">
                                                <span class="badge badge-success">已通过</span>
                                            </c:when>
                                            <c:when test="${a.status == '已拒绝'}">
                                                <span class="badge badge-danger">已拒绝</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-secondary">${a.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${a.status == '待审批'}">
                                            <form action="${pageContext.request.contextPath}/allocation/approve" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="${a.id}">
                                                <input type="hidden" name="pass" value="true">
                                                <button type="submit" class="btn btn-success btn-sm">
                                                    <i class="bi bi-check"></i> 同意
                                                </button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/allocation/approve" method="post" style="display:inline;">
                                                <input type="hidden" name="id" value="${a.id}">
                                                <input type="hidden" name="pass" value="false">
                                                <button type="submit" class="btn btn-danger btn-sm ml-2">
                                                    <i class="bi bi-x"></i> 拒绝
                                                </button>
                                            </form>
                                        </c:if>
                                        <c:if test="${a.status != '待审批'}">
                                            <span class="text-muted">无可操作</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="card-footer text-muted text-center bg-light py-3">
            软件学院设备管理系统 · 设备调配管理模块
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
