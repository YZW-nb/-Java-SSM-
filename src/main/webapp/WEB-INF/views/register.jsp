
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>社团管理系统 - 注册</title>
    <link href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', system-ui, sans-serif;
        }
        body {
            background: linear-gradient(135deg, #edf2f7 0%, #e2e8f0 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .register-wrapper {
            width: 100%;
            max-width: 450px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        .register-header {
            background: #3182ce;
            padding: 30px 20px;
            text-align: center;
            color: white;
        }
        .register-header h1 {
            font-size: 24px;
            margin-bottom: 8px;
            font-weight: 600;
        }
        .register-header p {
            font-size: 14px;
            opacity: 0.9;
        }
        .register-body {
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
            border-color: #3182ce;
            box-shadow: 0 0 0 3px rgba(49, 130, 206, 0.15);
            outline: none;
            background: white;
        }
        .form-control::placeholder {
            color: #a0aec0;
        }
        .form-hint {
            font-size: 13px;
            color: #718096;
            margin-top: 5px;
            margin-left: 1px;
            display: flex;
            align-items: center;
        }
        .form-hint i {
            font-size: 12px;
            margin-right: 5px;
        }
        .btn-register {
            width: 100%;
            height: 52px;
            background: #3182ce;
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }
        .btn-register:hover {
            background: #2a69ac;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(49, 130, 206, 0.2);
        }
        .btn-register:active {
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
            color: #3182ce;
            text-decoration: none;
            font-weight: 500;
        }
        .link-text a:hover {
            color: #2a69ac;
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
        .password-strength {
            height: 4px;
            background: #edf2f7;
            border-radius: 2px;
            margin-top: 5px;
            overflow: hidden;
        }
        .strength-bar {
            height: 100%;
            width: 0;
            transition: width 0.3s ease;
        }
    </style>
</head>
<body>
<div class="register-wrapper">
    <div class="register-header">
        <h1>账号注册</h1>
        <p>加入社团管理系统，探索更多精彩</p>
    </div>

    <div class="register-body">
        <!-- 使用JSTL标签替代有问题的EL表达式拼接 -->
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

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="form-group input-icon">
                <i class="fa fa-user-plus"></i>
                <input type="text" class="form-control" name="username"
                       placeholder="设置用户名" required>
                <p class="form-hint"><i class="fa fa-info-circle"></i>由字母、数字或下划线组成，3-16位</p>
            </div>

            <div class="form-group input-icon">
                <i class="fa fa-lock"></i>
                <input type="password" class="form-control" id="password" name="password"
                       placeholder="设置密码" required>
                <div class="password-strength">
                    <div class="strength-bar" id="strengthBar"></div>
                </div>
                <p class="form-hint"><i class="fa fa-info-circle"></i>不少于6位，包含数字和字母更佳</p>
            </div>

            <!-- 新增：学号输入框 -->
            <div class="form-group input-icon">
                <i class="fa fa-graduation-cap"></i>
                <input type="text" class="form-control" name="studentId"
                       placeholder="请输入学号（学生必填）" required>
                <p class="form-hint"><i class="fa fa-info-circle"></i>如：2023001001（字母或数字，不超过20位）</p>
            </div>

            <div class="form-group input-icon">
                <i class="fa fa-id-card"></i>
                <input type="text" class="form-control" name="name"
                       placeholder="真实姓名" required>
                <p class="form-hint"><i class="fa fa-info-circle"></i>请输入真实姓名，将用于社团认证</p>
            </div>

            <button type="submit" class="btn-register">完成注册</button>

            <div class="link-text">
                已有账号？<a href="${pageContext.request.contextPath}/login">返回登录</a>
            </div>
        </form>
    </div>
</div>

<script>
    // 密码强度检测
    const passwordInput = document.getElementById('password');
    const strengthBar = document.getElementById('strengthBar');

    passwordInput.addEventListener('input', () => {
        const value = passwordInput.value;
        let strength = 0;

        if (value.length >= 6) strength += 30;
        if (value.match(/[A-Za-z]/) && value.match(/[0-9]/)) strength += 40;
        if (value.length >= 10) strength += 30;

        strengthBar.style.width = strength + '%';

        // 设置强度颜色
        if (strength < 30) {
            strengthBar.style.background = '#fc8181';
        } else if (strength < 70) {
            strengthBar.style.background = '#ecc94b';
        } else {
            strengthBar.style.background = '#68d391';
        }
    });

    // 输入框聚焦效果
    document.querySelectorAll('.form-control').forEach(input => {
        input.addEventListener('focus', () => {
            input.parentElement.classList.add('focused');
        });
        input.addEventListener('blur', () => {
            input.parentElement.classList.remove('focused');
        });
    });
</script>
</body>
</html>