<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>社团管理系统 - 登录</title>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', system-ui, sans-serif;
        }
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4eaf1 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .login-wrapper {
            width: 100%;
            max-width: 420px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        .login-header {
            background: linear-gradient(135deg, #43cea2 0%, #185a9d 100%);
            padding: 30px 20px;
            text-align: center;
            color: white;
        }
        .login-header h1 {
            font-size: 24px;
            margin-bottom: 8px;
            font-weight: 600;
        }
        .login-header p {
            font-size: 14px;
            opacity: 0.9;
        }
        .login-body {
            padding: 30px 25px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-control {
            width: 100%;
            height: 50px;
            padding: 0 15px;
            border: 1px solid #e1e5eb;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease;
            background: #fcfcfc;
        }
        .form-control:focus {
            border-color: #43cea2;
            box-shadow: 0 0 0 3px rgba(67, 206, 162, 0.15);
            outline: none;
            background: white;
        }
        .form-control::placeholder {
            color: #a0aec0;
        }
        .btn-login {
            width: 100%;
            height: 52px;
            background: #43cea2;
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }
        .btn-login:hover {
            background: #38b292;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 206, 162, 0.2);
        }
        .btn-login:active {
            transform: translateY(0);
        }
        .error-message {
            background: #fff5f5;
            border-left: 4px solid #fc8181;
            color: #c53030;
            padding: 12px 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
        }
        .error-message i {
            margin-right: 8px;
        }
        .message {
            background: #f0fff4;
            border-left: 4px solid #68d391;
            color: #22543d;
            padding: 12px 15px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
            display: flex;
            align-items: center;
        }
        .message i {
            margin-right: 8px;
        }
        .link-text {
            text-align: center;
            color: #718096;
            font-size: 14px;
        }
        .link-text a {
            color: #43cea2;
            text-decoration: none;
            font-weight: 500;
        }
        .link-text a:hover {
            color: #38b292;
            text-decoration: underline;
        }
        .input-icon {
            position: relative;
        }
        .input-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #a0aec0;
        }
        .input-icon .form-control {
            padding-left: 45px;
        }

        /* 身份选择器样式 */
        .role-selector {
            display: flex;
            margin-bottom: 25px;
            border-radius: 8px;
            overflow: hidden;
            border: 1px solid #e1e5eb;
        }
        .role-option {
            flex: 1;
            text-align: center;
            padding: 12px 0;
            cursor: pointer;
            background-color: #fcfcfc;
            transition: all 0.3s ease;
            font-weight: 500;
            color: #718096;
        }
        .role-option.active {
            background-color: #43cea2;
            color: white;
        }
        .role-option:hover:not(.active) {
            background-color: #e2f7f0;
        }
    </style>
</head>
<body>
<div class="login-wrapper">
    <div class="login-header">
        <h1>社团管理系统</h1>
        <p>请选择身份并登录</p>
    </div>

    <div class="login-body">
        <c:if test="${not empty error}">
            <div class="error-message">
                <i class="fa fa-exclamation-circle"></i>${error}
            </div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="message">
                <i class="fa fa-check-circle"></i>${message}
            </div>
        </c:if>

        <!-- 身份选择器 -->
        <div class="role-selector">
            <div id="user-role" class="role-option active">
                <i class="fa fa-user-circle mr-2"></i>用户登录
            </div>
            <div id="admin-role" class="role-option">
                <i class="fa fa-shield mr-2"></i>管理员登录
            </div>
        </div>

        <!-- 表单提交路径 -->
        <form action="${pageContext.request.contextPath}/login" method="post">
            <!-- 隐藏字段存储角色信息（关键修改：传递数字1/2，与数据库role字段对应） -->
            <input type="hidden" id="role" name="role" value="1"> <!-- 默认学生角色（1） -->

            <div class="form-group input-icon">
                <i class="fa fa-user"></i>
                <input type="text" class="form-control" name="username"
                       placeholder="用户名" required autofocus>
            </div>

            <div class="form-group input-icon">
                <i class="fa fa-lock"></i>
                <input type="password" class="form-control" name="password"
                       placeholder="密码" required>
            </div>

            <button type="submit" class="btn-login">登录系统</button>

            <div class="link-text">
                还没有账号？<a href="${pageContext.request.contextPath}/register">立即注册</a>
            </div>
        </form>
    </div>
</div>

<script>
    // 角色切换逻辑（关键修改：传递数字1/2，与数据库role字段匹配）
    const userRole = document.getElementById('user-role');
    const adminRole = document.getElementById('admin-role');
    const roleInput = document.getElementById('role');

    // 切换到学生角色（对应数据库role=1）
    userRole.addEventListener('click', () => {
        userRole.classList.add('active');
        adminRole.classList.remove('active');
        roleInput.value = '1'; // 传递1给后端
    });

    // 切换到管理员角色（对应数据库role=2）
    adminRole.addEventListener('click', () => {
        adminRole.classList.add('active');
        userRole.classList.remove('active');
        roleInput.value = '2'; // 传递2给后端
    });
</script>
</body>
</html>